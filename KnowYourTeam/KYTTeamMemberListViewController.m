//
//  ViewController.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/6/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTTeamMemberListViewController.h"

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teamMemberList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"TeamMemeberTableViewCell";
    
    KYTTeamMemberViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    KYTTeamMember *teamMember = self.teamMemberList[indexPath.row];
    
    cell.firstNameLabel.text = teamMember.firstName;
    cell.lastNameLabel.text = teamMember.lastName;
    cell.imageView.image = teamMember.photo;
    
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
        [KYTTeamMemberPersistence writeArray:self.teamMemberList ToFilePath:@"TeamMember.plist"];
    }
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
            [KYTTeamMemberPersistence writeArray:self.teamMemberList ToFilePath:@"TeamMember.plist"];
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
    self.teamMemberList = [KYTTeamMemberPersistence readFileToArray:@"TeamMember.plist"];
    //If plist is blank, fill project with temp user data
    if ([self.teamMemberList count] <= 0 ){
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" WithLastName:@"Landry" WithPhoto:[UIImage imageNamed:@"PersonImage"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Luke" WithLastName:@"Romero" WithPhoto:[UIImage imageNamed:@"PersonImage"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Mark" WithLastName:@"Shen" WithPhoto:[UIImage imageNamed:@"PersonImage"]]];
    }
    
}


@end
