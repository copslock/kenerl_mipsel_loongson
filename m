Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UMjxo14442
	for linux-mips-outgoing; Mon, 30 Jul 2001 15:45:59 -0700
Received: from dvmwest.gt.owl.de (postfix@dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UMjwV14439
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 15:45:58 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id B5B84C4FE; Tue, 31 Jul 2001 00:45:56 +0200 (CEST)
Date: Tue, 31 Jul 2001 00:45:56 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dave Airlie <airlied@csn.ul.ie>, SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
Subject: Re: [long] Lance on DS5k/200
Message-ID: <20010731004556.C19713@lug-owl.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dave Airlie <airlied@csn.ul.ie>,
	SGI MIPS list <linux-mips@oss.sgi.com>,
	Debian MIPS list <debian-mips@lists.debian.org>, engel@unix-ag.org
References: <20010731002421.A19713@lug-owl.de> <Pine.GSO.3.96.1010731003328.19618F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010731003328.19618F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jul 31, 2001 at 12:45:10AM +0200
X-Operating-System: Linux mail 2.4.5 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 31, 2001 at 12:45:10AM +0200, Maciej W. Rozycki wrote:
> On Tue, 31 Jul 2001, Jan-Benedict Glaw wrote:
> > PS: Looking at ~23 Am7990 and ~5 Z8530 drivers I think I should go to
> >     *BSD :-) Who will ever attempt to clean up?
> 
>  Z8530 is on my to-do list.  Our driver really sucks: neither DMA (the I/O
> ASIC again) nor sychronous mode, just basic asynchronous support.  I'm
> going to look at LANCE one day, too, but it's lower on the list.

You you facing towards all those Z8530 implementation or only to
"ours"?

MfG, JBG (who can't even *believe* that there are *23* LANCE drivers)
