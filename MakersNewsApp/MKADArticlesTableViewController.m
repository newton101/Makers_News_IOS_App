//
//  MKADArticlesTableViewController.m
//  MakersNewsApp
//
//  Created by Aouled Miguil on 16/08/2013.
//  Copyright (c) 2013 Aouled Miguil. All rights reserved.
//

#import "MKADArticlesTableViewController.h"
#import "MKADArticle.h"
#import "MKADArticleViewController.h"

@interface MKADArticlesTableViewController ()

@end

@implementation MKADArticlesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];

    [self refresh];
}

-(void)refresh
{
    NSURL *url = [NSURL URLWithString:self.articlesURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.refreshControl endRefreshing];

    NSError *error = nil;
    NSArray *jsonRecievedArray = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
    if(error)
    {
        NSLog(@"Error parsing JSON: %@", [error localizedDescription]);
    }
    else
    {
        NSMutableArray *articlesMutableArray = [NSMutableArray array];
        for (NSDictionary *jsonObject in jsonRecievedArray)
        {
            MKADArticle *article = [[MKADArticle alloc] init];
            article.numericID = jsonObject[@"id"];
            article.title = jsonObject[@"title"];
            article.body = jsonObject[@"body"];
            article.publishedDate = jsonObject[@"published"];
            article.urlPath = jsonObject[@"url"];

            [articlesMutableArray addObject:article];
        }

        self.articles = [articlesMutableArray copy];
        [self.tableView reloadData];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    MKADArticle *article = [self.articles objectAtIndex:indexPath.row];

    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = article.body;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKADArticle *article = [self.articles objectAtIndex:indexPath.row];

    MKADArticleViewController *articleViewController = [[MKADArticleViewController alloc] init];
    articleViewController.article = article;
    [self.navigationController pushViewController:articleViewController animated:YES];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//
//    cell.textLabel.text = [NSString stringWithFormat:@"%d", [indexPath row]];
//}


@end