Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2RHsUP03589
	for linux-mips-outgoing; Tue, 27 Mar 2001 09:54:30 -0800
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.29.174.40])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2RHsPM03584
	for <linux-mips@oss.sgi.com>; Tue, 27 Mar 2001 09:54:25 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id DDDFF8030; Tue, 27 Mar 2001 18:54:23 +0100 (BST)
Date: Tue, 27 Mar 2001 18:54:23 +0100
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: David Jez <dave.jez@seznam.cz>
Cc: linux-mips@oss.sgi.com, guido.guenther@gmx.net
Subject: Re: indy's hardware watchdog
Message-ID: <20010327185423.B3617@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20010326184613.A20198@bilbo.physik.uni-konstanz.de> <20010327073809.B55390@stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <20010327073809.B55390@stud.fee.vutbr.cz>; from dave.jez@seznam.cz on Tue, Mar 27, 2001 at 07:38:09AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

> Btw. do you know if video input on indy is supported?

No, it isn't.

But, Ulf (grimsy) did start writing a driver for it, but never
finished.

If you look in any kernel tree, under drivers/char/ you will find
vino.c and vino.h


We just need someone to finish it  :)


Bye for Now,

Ian
