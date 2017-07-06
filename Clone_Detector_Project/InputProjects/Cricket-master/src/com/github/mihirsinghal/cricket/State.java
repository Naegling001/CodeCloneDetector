package com.github.mihirsinghal.cricket;

public enum State {
	// USED IN SELECT TEAM/PLAYER VIEW
	EDIT_TEAM, // Selecting a team to edit
	VIEW_STATS_SELECTING_TEAM, // Selecting team to view stats for
	VIEW_STATS_SELECTING_PLR, // Selecting player to view stats for
	SELECTING_PLR_TO_SWITCH_OUT, // Selecting player to switch out of a team
	SELECTING_PLR_TO_SWITCH_IN, // Selecting player to switch in to a team
	SELECTING_PLR_TO_REMOVE, // Selecting player to remove from a team
	SELECTING_FIRST_TEAM, // Selecting first team for T20/ODI
	SELECTING_SECOND_TEAM, // Selecting second team for T20/ODI
	SELECTING_WKTKEEPER, // Selecting wicketkeeper for T20/ODI
	SELECTING_FIRST_BATSMAN, SELECTING_SECOND_BATSMAN, SELECTING_FIRST_BOWLER,
	SELECTING_NEW_BATSMAN,

	// USED IN CONFIRM DIALOG VIEW
	CONFIRM_ADDING_PLR, // Adding a player to team
	CONFIRM_CREATING_TEAM, // Creating a new team
	CONFIRM_SWITCHING_PLRS, // Switching players
	CONFIRM_REMOVE_PLR, // Remove a player
	HEADS_OR_TAILS, // Asking for coin flip choice
	BAT_OR_FIELD, // Asking toss winner whether to bat or field
	CONFIRM_CHANGE_BOWLER,

	// USED IN ENTER PASSWORD VIEW
	PSWD_EDIT_TEAM, // Enter password to edit team
	PSWD_FIRST_TEAM, // Entering password for first team for T20/ODI
	PSWD_SECOND_TEAM, // Entering password for second team for T20/ODI

	// USED IN SHOW MESSAGE VIEW
	SQUAD_EMPTY_ERROR, // Error message showing that the squad is empty
	SHOWING_BALL_RESULT, // Showing the result of a ball
	SHOWING_NOTIFICATION, // Showing notification for events such as a century, etc.
	END_OF_GAME,

}
