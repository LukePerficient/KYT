//
//  ViewController.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/6/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTTeamMemberListViewController.h"
#import "KYTTeamMember.h"
#import "KYTTeamMemberViewCell.h"
#import "KYTMemberViewController.h"
#import "KYTTeamMemberPersistence.h"
#import "KYTPageInitViewController.h"
#import "KYTConstants.h"
#import "KYTTeamMemberListTableViewDelegate.h"
#import <QuartzCore/CALayer.h>

@interface KYTTeamMemberListViewController ()


@end

@implementation KYTTeamMemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Class and Instance Members
    [self initialzeMembers];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Mark: TableView Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    KYTTeamMemberViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    KYTTeamMember *teamMember = self.teamMemberList[indexPath.row];
    
    // Rounded Rect for cell image
    CALayer *cellImageLayer = cell.imageViewTable.layer;
    [cellImageLayer setCornerRadius:25];
    [cellImageLayer setMasksToBounds:YES];

    
    cell.firstNameLabel.text = teamMember.firstName;
    cell.lastNameLabel.text = teamMember.lastName;
    cell.titleLabel.text = teamMember.title;
    cell.imageViewTable.image = teamMember.photo;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teamMemberList count];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete){
        [_teamMemberList removeObjectAtIndex:indexPath.row];
        [_teamMemberTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
        [KYTTeamMemberPersistence writeArray:self.teamMemberList toFilePath:TEAM_MEMBER_FILE_NAME];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return TABLE_HEADER_NAME;
}

// Mark: Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:SHOW_PAGE_VIEW_SEGUE])
    {
        KYTPageInitViewController *vc = [segue destinationViewController];
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
    
    // Load member data from plist file
    [self loadMemberData];
    
    // Assign instance of self as tableview's delegate and datasource
    _tableViewDelegate = [[KYTTeamMemberListTableViewDelegate alloc] initWithViewController:(UIViewController<KYTListViewController> *)self];
    
    self.teamMemberTableView.dataSource = self;
    self.teamMemberTableView.delegate = _tableViewDelegate;
}

- (void)loadMemberData
{
    //Load data from plist
    self.teamMemberList = [KYTTeamMemberPersistence readFileToArray:TEAM_MEMBER_FILE_NAME];
    //If plist is blank, fill project with temp user data
    if ([self.teamMemberList count] <= 0 ){
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" withLastName:@"Landry" withTitle:@"Technical Consultant" withPhoto:[UIImage imageNamed:@"DustinLandry.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Luke" withLastName:@"Romero" withTitle:@"Senior Technical Consultant" withPhoto:[UIImage imageNamed:@"LukeRomero.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Mark" withLastName:@"Shen" withTitle:@"Senior Technical Consultant" withPhoto:[UIImage imageNamed:@"MarkShen.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Ben" withLastName:@"Rodrigue" withTitle:@"Senior Technical Consultant" withPhoto:[UIImage imageNamed:@"BenRodrigue.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Chris" withLastName:@"Parich" withTitle:@"Senior Technical Consultant" withPhoto:[UIImage imageNamed:@"ChrisParich.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Erasto" withLastName:@"Padron" withTitle:@"Associate Technical Consultant" withPhoto:[UIImage imageNamed:@"ErastoPadron.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"MaryBeth" withLastName:@"Ostasz" withTitle:@"General Manager" withPhoto:[UIImage imageNamed:@"MaryBethOstasz.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Moony" withLastName:@"Chen" withTitle:@"Lead Technical Consultant" withPhoto:[UIImage imageNamed:@"MoonyChen.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Roy" withLastName:@"Condrey" withTitle:@"Senior Business Consultant" withPhoto:[UIImage imageNamed:@"RoyCondrey.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Ruth" withLastName:@"Miller" withTitle:@"Lead Business Consultant" withPhoto:[UIImage imageNamed:@"RuthMiller.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Tim" withLastName:@"Porter" withTitle:@"Director" withPhoto:[UIImage imageNamed:@"TimPorter.jpeg"]]];
        [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Titus" withLastName:@"Treme" withTitle:@"Associate Technical Consultant" withPhoto:[UIImage imageNamed:@"TitusTreme.jpeg"]]];
        
        //Save initial member list
        [KYTTeamMemberPersistence writeArray:self.teamMemberList toFilePath:TEAM_MEMBER_FILE_NAME];
        }
}

-(void)dealloc
{
    NSLog(@"TeamMemberListViewController is being deallocated");
}


@end
