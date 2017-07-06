package com.github.mihirsinghal.cricket;

import java.io.*;
import java.util.*;

public class DataLoader {

	static List<Ball> allBalls;
	static Random rand;

	static void init() {
		try {
			rand = new Random();
			BufferedReader f = new BufferedReader(new FileReader("allballs.txt"));
			String line = f.readLine();
			allBalls = new ArrayList<Ball>();
			while (line != null) {
				int n = Integer.parseInt(line);
				String e = f.readLine();
				String sf = f.readLine();
				String lf = f.readLine();
				String c = f.readLine();
				String ms = f.readLine();
				if (n == 5) {
					allBalls.add(new Ball(e, sf, lf, c, ms));
				} else {
					String mth = f.readLine();
					if (n == 6) {
						allBalls.add(new Ball(e, sf, lf, c, ms, mth));
					} else {
						String fhe = f.readLine();
						String fhsf = f.readLine();
						String fhlf = f.readLine();
						String fhc = f.readLine();
						String fhms = f.readLine();
						allBalls.add(new Ball(e, sf, lf, c, ms, mth, new Ball(fhe, fhsf, fhlf, fhc,
								fhms)));
					}
				}
				line = f.readLine();
			}
			f.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	static Ball randomBall() {
		
		return allBalls.get(rand.nextInt(allBalls.size()));
		
	}
	
	static void writeAllTeams(List<Team> teams) {
		PrintWriter out = null;
		try {
			out = new PrintWriter(new BufferedWriter(new FileWriter("teamdata.txt")));
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(teams.size());
		for (Team team: teams) {
			writeTeam(team, out);
		}
		out.close();
	}

	private static void writeTeam(Team team, PrintWriter out) {

		out.println(team.name);
		out.println(team.password);

		for (Player plr: team.players) {
			writePlayer(plr, out);
		}

		out.println(team.squad.size());

		for (Player plr: team.squad) {
			writePlayer(plr, out);
		}

	}

	private static void writePlayer(Player plr, PrintWriter out) {

		out.println(plr.name);
		for (int i = 0; i < PlayerStats.NUM_STATS; i++) {
			out.print(plr.stats.s[i]);
			if (i != PlayerStats.NUM_STATS) {
				out.print(" ");
			}
		}
		out.println();

	}

	static List<Team> readAllTeams() {

		try {
			BufferedReader f = new BufferedReader(new FileReader("teamdata.txt"));
			int numTeams = Integer.parseInt(f.readLine());
			List<Team> ans = new ArrayList<Team>();
			for (int i = 0; i < numTeams; i++) {
				ans.add(readTeam(f));
			}
			return ans;
		} catch (IOException e) {
			e.printStackTrace();
			assert false;
			return null;
		}

	}

	private static Team readTeam(BufferedReader f) {
		try {
			String name = f.readLine();
			String password = f.readLine();
			Player[] players = new Player[11];
			for (int i = 0; i < 11; i++) {
				players[i] = readPlayer(f);
			}
			int squadSize = Integer.parseInt(f.readLine());
			List<Player> squad = new ArrayList<Player>();
			for (int i = 0; i < squadSize; i++) {
				squad.add(readPlayer(f));
			}
			return new Team(name, password, players, squad);
		} catch (IOException e) {
			e.printStackTrace();
			assert false;
			return null;
		}
	}

	private static Player readPlayer(BufferedReader f) {
		try {
			String name = f.readLine();
			int[] stats = new int[PlayerStats.NUM_STATS];
			int i = 0;
			for (String stat: f.readLine().split(" ")) {
				stats[i] = Integer.parseInt(stat);
				i++;
			}
			return new Player(name, stats);
		} catch (IOException e) {
			e.printStackTrace();
			assert false;
			return null;
		}
	}

}
