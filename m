Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 13:14:16 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:32266
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225569AbTIWMON>; Tue, 23 Sep 2003 13:14:13 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1m3X-0006X3-00; Tue, 23 Sep 2003 14:14:11 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1m3W-000676-00; Tue, 23 Sep 2003 14:14:10 +0200
Date: Tue, 23 Sep 2003 14:14:10 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix character loss in drivers/tc/zs.c
Message-ID: <20030923121410.GW13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030923084005.GU13578@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030923132357.22133B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030923132357.22133B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 23 Sep 2003, Thiemo Seufer wrote:
> 
> > >  Can you please elaborate?  tty is expected to be NULL if info->hook is
> > > not, so the code after the change should not differ effectively -- only a
> > > useless check is added at the end.  Am I missing anything?
> > 
> > AFAICS the
> > 
> >         while ((read_zsreg(info->zs_channel, R0) & Rx_CH_AV) != 0) {
> > 
> > loops over the FIFO contents and 'return' discards the remaining
> > part. The patch made a visible difference for me with some noisy
> > debug printk()'s in the kernel.
> 
>  Hmm, a coincidence?  Without your patch the execution goes as follows:

Well, the code suggests so. But thinking about it again, it should
probably read (untested):


--- linux-orig/drivers/tc/zs.c	Tue Aug 12 04:11:58 2003
+++ linux/drivers/tc/zs.c	Tue Sep 23 14:09:34 2003
@@ -456,7 +456,7 @@ static _INLINE_ void receive_chars(struc
 
 		if (info->hook && info->hook->rx_char) {
 			(*info->hook->rx_char)(ch, flag);
-			return;
+			continue;
   		}
 
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {

[snip]
> and tty is NULL.  And I fail to see how it can it make any difference for
> printk() output -- the code in question is only ever executed for input
> from an LK201-type keyboard.

I found this on Karsten's 5000/150. We can try it out again soon. :-)


Thiemo
