Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f72Dlf524367
	for linux-mips-outgoing; Thu, 2 Aug 2001 06:47:41 -0700
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f72DldV24360
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 06:47:39 -0700
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id 2979C2B6FE; Thu,  2 Aug 2001 14:45:47 +0100 (IST)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 884C1A8A5; Thu,  2 Aug 2001 14:45:46 +0100 (IST)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id 8477EA8A4; Thu,  2 Aug 2001 14:45:46 +0100 (IST)
Date: Thu, 2 Aug 2001 14:45:46 +0100 (IST)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender:  <airlied@skynet>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, <engel@unix-ag.org>
Subject: Re: [long] Lance on DS5k/200
In-Reply-To: <20010731002421.A19713@lug-owl.de>
Message-ID: <Pine.LNX.4.32.0108021442080.2764-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I really *hate* to see so many different implementations. That counts
> to about 21..25 pieces of code, always written for the same thing.
> Well, I'll start off in merging in those two declance drivers. But
> this will come no earlier that in two weeks or so. I'll first do
> the serial keyboard with dz.c.

I sent this earlier but attached some large files.. so in case people on
the list didn't get it ..

http://www.skynet.ie/~airlied/mips/dz.c and dec_dz_keyb.c

are my initial attempts at dz keyboard support for DS5000/200, they
required the access.bus keyboard supprt (or at least lk201 stuff)....

just in case the are usefull.. they worked for lowercase, but the shift
state stuff is all wrong... I lost my monitor soon afterwards which
stopped my development.. I think someone else is working on this
maybe Karsten Merker...

Dave.

>
> MfG, JBG
> PS: Looking at ~23 Am7990 and ~5 Z8530 drivers I think I should go to
>     *BSD :-) Who will ever attempt to clean up?
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
