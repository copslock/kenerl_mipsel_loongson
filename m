Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBA1Ilw30435
	for linux-mips-outgoing; Sun, 9 Dec 2001 17:18:47 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBA1Iho30432
	for <linux-mips@oss.sgi.com>; Sun, 9 Dec 2001 17:18:43 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBA0IZZ14056;
	Sun, 9 Dec 2001 22:18:35 -0200
Date: Sun, 9 Dec 2001 22:18:35 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
Message-ID: <20011209221835.A11737@dea.linux-mips.net>
References: <3C1104D4.F700768A@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1104D4.F700768A@broadcom.com>; from kwalker@broadcom.com on Fri, Dec 07, 2001 at 10:05:08AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Dec 07, 2001 at 10:05:08AM -0800, Kip Walker wrote:

> I just investigated assembler warnings coming from
> arch/mips/kernel/entry.S (checked out as of 12/07 00:00 UTC), and
> noticed the following.  After expanding macros, you get something like:
> 
> 	.text
> 
> 	.section ".text.init"   (from __INIT)
> 
> 	.data			(from PANIC)
> 	.previous		(from PANIC)
> 	--> section is now .text.init
> 
> 	.previous		(from __FINIT)
> 	--> section is now .data, not .text as intended.
> 
> Perhaps .pushsection and .popsection should be used in some or all
> macros like this?
> 
> Or am I smoking crack?

Certainly not.  The problem is known and so far I've just hacked around
it more or less elegant.  But it's a trap and so I think we've got good
reasons to force people to upgrade to a newer assembler than the current
minimal version.  The question is which - I don't like frequent tool
upgrades.

  Ralf
