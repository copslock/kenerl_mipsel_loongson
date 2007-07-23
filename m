Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 14:00:20 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:12301 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022355AbXGWNAS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 14:00:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 33F32E1CCE;
	Mon, 23 Jul 2007 15:00:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TCHJpDdZWTPU; Mon, 23 Jul 2007 15:00:14 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 52AA1E1CCA;
	Mon, 23 Jul 2007 15:00:13 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6ND0HM4005663;
	Mon, 23 Jul 2007 15:00:18 +0200
Date:	Mon, 23 Jul 2007 14:00:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] bcm1480 serial build fix
In-Reply-To: <20070722075515.GB23747@networkno.de>
Message-ID: <Pine.LNX.4.64N.0707231353030.13557@blysk.ds.pg.gda.pl>
References: <20070722075515.GB23747@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3741/Mon Jul 23 07:50:22 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 22 Jul 2007, Thiemo Seufer wrote:

> diff --git a/include/asm-mips/sibyte/bcm1480_regs.h b/include/asm-mips/sibyte/bcm1480_regs.h
> index 2738c13..c34d36b 100644
> --- a/include/asm-mips/sibyte/bcm1480_regs.h
> +++ b/include/asm-mips/sibyte/bcm1480_regs.h
> @@ -227,10 +227,15 @@
>  	(A_BCM1480_DUART(chan) +					\
>  	 BCM1480_DUART_CHANREG_SPACING * 3 + (reg))
>  
> +#define DUART_IMRISR_SPACING	    0x20
> +#define DUART_INCHNG_SPACING	    0x10
> +

 Aren't all the bits in "bcm1480_regs.h" meant to be prefixed with 
BCM1480_DUART?  If these are to be the same as for the BCM1250, then they 
can probably be defined "in sb1250_regs.h" unconditionally.

 These headers are a horrible mess anyway -- a single definition should be 
enough to access the two DUARTs the BCM1480 seems to have...

  Maciej
