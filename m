Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UMOQd13967
	for linux-mips-outgoing; Mon, 30 Jul 2001 15:24:26 -0700
Received: from dvmwest.gt.owl.de (postfix@dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UMONV13964
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 15:24:24 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id D48E3C4FE; Tue, 31 Jul 2001 00:24:21 +0200 (CEST)
Date: Tue, 31 Jul 2001 00:24:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dave Airlie <airlied@csn.ul.ie>, SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
Message-ID: <20010731002421.A19713@lug-owl.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dave Airlie <airlied@csn.ul.ie>,
	SGI MIPS list <linux-mips@oss.sgi.com>,
	Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
References: <Pine.LNX.4.32.0107291413510.11630-100000@skynet> <Pine.GSO.3.96.1010730220512.19618B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010730220512.19618B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 30, 2001 at 10:06:45PM +0200
X-Operating-System: Linux mail 2.4.5 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 30, 2001 at 10:06:45PM +0200, Maciej W. Rozycki wrote:
> On Sun, 29 Jul 2001, Dave Airlie wrote:
> > You really should read around before hacking :-)
> > 
> > http://www.skynet.ie/~airlied/mips/declance_2_3_48.c
> > 
> > is the declance driver for the DS5000/200, I'm not sure it still works but
> > it did the last time I looked at it .. the declance.c in the same dir is
> > for 2.2 kernel.. I must rename them someday..
> 
>  How about merging it into official sources?  This way your work won't get
> lost and others won't try to reinvent the wheel.

Of course. I wouldn't even *try* to do sth other. In fact, I'm looking
around for various specs of various implementations (as seen from
the bus) of the LANCE chip to see if I could manage the job to
unify them all together:

Driver file				      | Mentioned Chip
----------------------------------------------+--------------------
./drivers/net/declance.c
./xxx/declance.c	# as for DS5k/200
./drivers/net/bagetlance.c			none mentioned
./drivers/net/sk_g16.c				Am7990
./drivers/net/ni65.c				ni6510 aka Am7990
./drivers/net/ewk3.c				Am7990
./drivers/net/sk_mca.c				Am7990
./drivers/net/sunlance.c			NCR92c990
	`-> Father of declance.c as I think
./drivers/net/sunhme.c				none mentioned
	`-> *some* cards seem to be compatible?!
./drivers/net/a2065.c				Am7990
./drivers/net/ariadne.c				Am79c960
./drivers/net/atarilance.c			none mentioned
./drivers/net/sunqu.c				"looks like LANCE"
./drivers/net/atari_pamsnet.c			none mentioned
./drivers/net/lance.c				Am7990, Am79c970A
./drivers/net/pcnet32.c				none mentioned
./drivers/net/sgiseeq.c				Seeq8003 (different buffer
						layout for speed)
./drivers/net/am79c961a.c			Am79c961A
./drivers/net/sun3lance.c			none mentioned, but adopted from sunlance.c
./drivers/net/pcmcia/nmclan_cs.c		Am79c90
./drivers/net/ibmlana.c				"start of LANCE"
./drivers/net/7990.c		*** GENERIC ROUTINES!!! ***
./drivers/net/hplance.c				Uses 7990.c!
./drivers/net/mvme147.c				Uses 7990.c!

I really *hate* to see so many different implementations. That counts
to about 21..25 pieces of code, always written for the same thing.
Well, I'll start off in merging in those two declance drivers. But
this will come no earlier that in two weeks or so. I'll first do
the serial keyboard with dz.c.

MfG, JBG
PS: Looking at ~23 Am7990 and ~5 Z8530 drivers I think I should go to
    *BSD :-) Who will ever attempt to clean up?
	
