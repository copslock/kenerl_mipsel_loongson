Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDLk0F00981
	for linux-mips-outgoing; Thu, 13 Dec 2001 13:46:00 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBDLjvo00978
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 13:45:57 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBDKjga09826;
	Thu, 13 Dec 2001 18:45:42 -0200
Date: Thu, 13 Dec 2001 18:45:42 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Kip Walker <kwalker@broadcom.com>, linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
Message-ID: <20011213184541.A7171@dea.linux-mips.net>
References: <20011209221835.A11737@dea.linux-mips.net> <Pine.GSO.3.96.1011210165719.24010A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011210165719.24010A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Dec 10, 2001 at 05:03:41PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 10, 2001 at 05:03:41PM +0100, Maciej W. Rozycki wrote:

> > Certainly not.  The problem is known and so far I've just hacked around
> > it more or less elegant.  But it's a trap and so I think we've got good
> > reasons to force people to upgrade to a newer assembler than the current
> > minimal version.  The question is which - I don't like frequent tool
> > upgrades.
> 
>  There are no working released binutils for a modern MIPS/Linux system,
> AFAIK.  However, version 2.11.92 from the CVS seems to work reasonably
> well now, so chances are the next release will do as well.  Maybe 2.12
> will be a good candidate then, once it is released and tested a bit. 

What is the schedule for 2.12?

  Ralf
