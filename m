Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA9JiT616156
	for linux-mips-outgoing; Fri, 9 Nov 2001 11:44:29 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA9JiP016153;
	Fri, 9 Nov 2001 11:44:25 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fA9JiLY30238;
	Fri, 9 Nov 2001 14:44:21 -0500
Date: Fri, 9 Nov 2001 14:44:21 -0500
From: Jim Paris <jim@jtan.com>
To: Jun Sun <jsun@mvista.com>
Cc: James Simmons <jsimmons@transvirtual.com>, Ralf Baechle <ralf@oss.sgi.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
Message-ID: <20011109144421.A30230@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <Pine.LNX.4.10.10111081348000.13456-100000@transvirtual.com> <3BEC20D5.AD6ABBA6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEC20D5.AD6ABBA6@mvista.com>; from jsun@mvista.com on Fri, Nov 09, 2001 at 10:30:45AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> You are probably referring to isa_slot_offset?
> 
> isa_slot_offset is an obselete garbage.  Can someone do Ralf's a favor and
> send him a patch to get rid of it (as if he can't do it himself :-0) ?

How should it be properly done?

-jim
