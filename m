Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 13:36:46 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:13255 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225572AbTIWMgg>; Tue, 23 Sep 2003 13:36:36 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA24054;
	Tue, 23 Sep 2003 14:36:26 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 23 Sep 2003 14:36:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix character loss in drivers/tc/zs.c
In-Reply-To: <20030923121410.GW13578@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030923142023.22133F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 23 Sep 2003, Thiemo Seufer wrote:

> Well, the code suggests so. But thinking about it again, it should
> probably read (untested):
> 
> 
> --- linux-orig/drivers/tc/zs.c	Tue Aug 12 04:11:58 2003
> +++ linux/drivers/tc/zs.c	Tue Sep 23 14:09:34 2003
> @@ -456,7 +456,7 @@ static _INLINE_ void receive_chars(struc
>  
>  		if (info->hook && info->hook->rx_char) {
>  			(*info->hook->rx_char)(ch, flag);
> -			return;
> +			continue;
>    		}
>  
>  		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {

 That might make some sense performance-wise, but it still doesn't make a
big difference -- continuing with the loop will let following pending
codes from the keyboard to be fetched immediately, while returning defers
that to the next SCC interrupt.

 Actually, I'm not that keen on making revolutionary changes to
drivers/tc/zs, just fixing bugs (of course, this might be one).  The
driver should be rewritten to become a front-end to
drivers/net/wan/z85230.c (the path seems unfortunate).  Then more
interesting stuff, like DMA and synchronous operation, will become
available. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
