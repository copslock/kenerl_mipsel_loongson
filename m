Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1GLtRM32343
	for linux-mips-outgoing; Sat, 16 Feb 2002 13:55:27 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1GLtO932338
	for <linux-mips@oss.sgi.com>; Sat, 16 Feb 2002 13:55:24 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id g1GKtIU19243;
	Sat, 16 Feb 2002 15:55:18 -0500
Date: Sat, 16 Feb 2002 15:55:18 -0500
From: Jim Paris <jim@jtan.com>
To: "Andrew R. Baker" <andrewb@snort.org>
Cc: Mat Withers <mat@minus-9.com>, Timothy Daly <remote_bob@yahoo.com>,
   linux-mips@oss.sgi.com
Subject: Re: indigo2 video
Message-ID: <20020216155518.A19235@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20020216105239.5160.qmail@web10208.mail.yahoo.com> <20020216112058.C8787@minus-9.com> <3C6E9764.31A271D8@snort.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6E9764.31A271D8@snort.org>; from andrewb@snort.org on Sat, Feb 16, 2002 at 09:31:16AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > I was also wondering this. On the intel architecture EISA slots also
> > supported ISA cards. Is this also the case on the Indigo 2 ? or are the 
> > EISA slots a bit more "non-standard".
> 
> The EISA slots on the Indigo2 do support ISA cards.  I was running an
> old 3Com Etherlink III card in a Linux Indigo2 several years ago. 
> Running a video card on one of them may be a bit more tricky, but should
> be possible.

You're going to have a problem initializing the card because you won't
be able to execute the BIOS.  Solutions would be to disassemble the
ROM on your particular card and see what it's doing (all cards I've
seen are initialized slightly differently); or perhaps some cool
solution involving an x86 emulator like Bochs.

-jim
