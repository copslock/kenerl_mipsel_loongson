Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2RM4Oh11930
	for linux-mips-outgoing; Tue, 27 Mar 2001 14:04:24 -0800
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.29.174.40])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2RM4NM11927
	for <linux-mips@oss.sgi.com>; Tue, 27 Mar 2001 14:04:24 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 1A756802F; Tue, 27 Mar 2001 23:04:23 +0100 (BST)
Date: Tue, 27 Mar 2001 23:04:22 +0100
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Cc: linux-mips@oss.sgi.com
Subject: Vino Video / Indycam  (was Re: indy's hardware watchdog)
Message-ID: <20010327230422.A4071@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20010327185423.B3617@woody.ichilton.co.uk> <Pine.BSF.4.33.0103272154440.97074-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <Pine.BSF.4.33.0103272154440.97074-100000@fest.stud.fee.vutbr.cz>; from xmichl03@stud.fee.vutbr.cz on Tue, Mar 27, 2001 at 09:57:25PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

> > If you look in any kernel tree, under drivers/char/ you will find
> > vino.c and vino.h

> well, i found them under drivers/media/video/

Seems they have been moved in 2.4.

In 2.2.18:

[ian@buzz:/usr/src/linux/drivers/char]$ ls vino*
vino.c  vino.h


In 2.4.2:

[ian@dipsy:/usr/src/linux/drivers/media/video]$ ls vino*
vino.c
[ian@dipsy:/usr/src/linux/drivers/char]$ ls vino*
vino.h


> but haven't any hw docs.

Yes, they are in:
ftp://oss.sgi.com/pub/linux/mips/doc/indy/


Bye for Now,

Ian
