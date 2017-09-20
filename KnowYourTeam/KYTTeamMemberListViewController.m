//
//  ViewController.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/6/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTTeamMemberListViewController.h"
#import "KYTPageInitViewController.h"

@interface KYTTeamMemberListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *teamMemberTableView;
@property IBOutletCollection(KYTTeamMember) NSMutableArray *teamMemberList;

@end

@implementation KYTTeamMemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Class and Instance Members
    [self initialzeMembers];
    
    // Load member data from plist file
    [self loadMemberData];
    
    // Assign instance of self as tableview's delegate and datasource
    self.teamMemberTableView.dataSource = self;
    self.teamMemberTableView.delegate = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Mark: TableView Datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRowIndex = indexPath.row;
    
    [self performSegueWithIdentifier:SHOW_PAGE_VIEW_SEGUE sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teamMemberList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    KYTTeamMemberViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    KYTTeamMember *teamMember = self.teamMemberList[indexPath.row];
    
    cell.firstNameLabel.text = teamMember.firstName;
    cell.lastNameLabel.text = teamMember.lastName;
    cell.imageViewTable.image = teamMember.photo;
    
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete){
        [_teamMemberList removeObjectAtIndex:indexPath.row];
        [_teamMemberTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
        [KYTTeamMemberPersistence writeArray:self.teamMemberList toFilePath:TEAM_MEMBER_FILE_NAME];
    }
}

// Mark: Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:SHOW_PAGE_VIEW_SEGUE])
    {
        // Get reference to the destination view controller
        KYTPageInitViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.selectedRowIndex = self.selectedRowIndex;
    }
    //Deselect row item
    [self.teamMemberTableView deselectRowAtIndexPath:[self.teamMemberTableView indexPathForSelectedRow] animated:YES];
}

// Mark: Actions
- (IBAction)unwindToTeamMemberList:(UIStoryboardSegue*)sender
{
    KYTMemberViewController *sourceViewController;
    KYTTeamMember *member;
    
    if (sender.sourceViewController != nil) {
        sourceViewController = sender.sourceViewController;
        member = sourceViewController.member;
        
        //Verify user entered data
        if (member != nil){
            // Add a new member to list.
            NSArray *path = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[self.teamMemberList count] inSection:0]];
            
            [self.teamMemberList addObject:member];
            
            [[self teamMemberTableView] insertRowsAtIndexPaths:path withRowAnimation:UITableViewRowAnimationAutomatic];
            
            // Save updated member list.
            [KYTTeamMemberPersistence writeArray:self.teamMemberList toFilePath:TEAM_MEMBER_FILE_NAME];
        }
    }
    
    
}

// Mark: Private Methods
- (void)initialzeMembers
{
    self.teamMemberList = [[NSMutableArray alloc] init];
}

- (void)loadMemberData
{
    //Load data from plist
    self.teamMemberList = [KYTTeamMemberPersistence readFileToArray:TEAM_MEMBER_FILE_NAME];
    //If plist is blank, fill project with temp user data
    if ([self.teamMemberList count] <= 0 ){
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" withLastName:@"Landry" withPhoto:[UIImage imageNamed:@"DustinLandry.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Luke" withLastName:@"Romero" withPhoto:[UIImage imageNamed:@"LukeRomero.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Mark" withLastName:@"Shen" withPhoto:[UIImage imageNamed:@"MarkShen.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Ben" withLastName:@"Rodrigue" withPhoto:[UIImage imageNamed:@"BenRodrigue.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Chris" withLastName:@"Parich" withPhoto:[UIImage imageNamed:@"ChrisParich.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Erasto" withLastName:@"Padron" withPhoto:[UIImage imageNamed:@"ErastoPadron.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"MaryBeth" withLastName:@"Ostasz" withPhoto:[UIImage imageNamed:@"MaryBethOstasz.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Moony" withLastName:@"Chen" withPhoto:[UIImage imageNamed:@"MoonyChen.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Roy" withLastName:@"Condrey" withPhoto:[UIImage imageNamed:@"RoyCondrey.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Ruth" withLastName:@"Miller" withPhoto:[UIImage imageNamed:@"RuthMiller.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Tim" withLastName:@"Porter" withPhoto:[UIImage imageNamed:@"TimPorter.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Titus" withLastName:@"Treme" withPhoto:[UIImage imageNamed:@"TitusTreme.jpeg"]]];
        
        //Save initial member list
        [KYTTeamMemberPersistence writeArray:self.teamMemberList toFilePath:TEAM_MEMBER_FILE_NAME];
        }
}

-(void)dealloc
{
    NSLog(@"TeamMemberListViewController is being deallocated");
}


@end
