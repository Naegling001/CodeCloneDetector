package com.github.mihirsinghal.cricket;

import java.util.*;

public class Team {

	String name;
	String password;
	Player[] players;
	List<Player> squad;

	// public Team(String name) {
	// this.name = name.trim();
	// password = "p";
	// players = new Player[11];
	// squad = new ArrayList<Player>();
	//
	// for (int i = 0; i < 11; i++) {
	// players[i] = new Player(name + " P" + (i + 1));
	// }
	//
	// for (int i = 0; i < 3; i++) {
	// squad.add(new Player(name + " squad P" + (i + 1)));
	// }
	// }
	// TODO remove

	public Team(String name, String password, String[] plrNames) {
		this.name = name.trim();
		this.password = password;

		players = new Player[11];
		for (int i = 0; i < 11; i++) {
			players[i] = new Player(plrNames[i].trim());
		}

		squad = new ArrayList<Player>();
	}

	public Team(String name, String password, Player[] players, List<Player> squad) {
		this.name = name;
		this.password = password;
		this.players = players;
		this.squad = squad;
	}

	public void addPlayer(String plrName) {
		squad.add(new Player(plrName.trim()));
	}

	public boolean containsPlayerWithName(String plrName) {

		plrName = plrName.toLowerCase().trim();

		for (Player plr: players) {
			if (plr.name.toLowerCase().equals(plrName)) {
				return true;
			}
		}
		for (Player plr: squad) {
			if (plr.name.toLowerCase().equals(plrName)) {
				return true;
			}
		}

		return false;

	}

	public List<Player> getAllPlrs() { // returns a list of all players in the
										// team, including squad.

		List<Player> ans = new ArrayList<Player>();

		for (Player plr: players) {
			ans.add(plr);
		}

		ans.addAll(squad);

		return ans;

	}

	public List<Player> getMainPlrsAsList() {

		List<Player> ans = new ArrayList<Player>();

		for (Player plr: players) {
			ans.add(plr);
		}

		return ans;

	}

	public void switchPlrs(Player plrOut, Player plrIn) {

		players[Functions.indexInArray(players, plrOut)] = plrIn;

		squad.set(squad.indexOf(plrIn), plrOut);

	}

	public void removePlr(Player plr) {

		squad.remove(plr);

	}

}
