Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 15:33:27 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:39952 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023920AbXHXOdT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 15:33:19 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 27E32D8C9; Fri, 24 Aug 2007 14:32:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 946FC5437A; Fri, 24 Aug 2007 16:32:22 +0200 (CEST)
Date:	Fri, 24 Aug 2007 16:32:22 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] bcm1480 serial build fix
Message-ID: <20070824143222.GA5662@deprecation.cyrius.com>
References: <20070722075515.GB23747@networkno.de> <Pine.LNX.4.64N.0707231353030.13557@blysk.ds.pg.gda.pl> <20070723134431.GB18207@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070723134431.GB18207@networkno.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thiemo Seufer <ths@networkno.de> [2007-07-23 14:44]:
> >  These headers are a horrible mess anyway -- a single definition should be 
> > enough to access the two DUARTs the BCM1480 seems to have...
> Indeed. I just took the path of least resistance to make it work again.

Maybe Ralf can apply it (at least for now).  BCM1480 in git is
currently broken because of this.

From: Thiemo Seufer <ths@networkno.de>

Restore serial functionality for the bcm1480.

I glued this together without reading documentation, so I'm not sure if
it is fully correct. It is good enough to build a kernel and have a
working serial console.


Signed-Off-By: Thiemo Seufer <ths@networkno.de>

diff --git a/drivers/serial/sb1250-duart.c b/drivers/serial/sb1250-duart.c
index 1d9d728..e7f5c0e 100644
--- a/drivers/serial/sb1250-duart.c
+++ b/drivers/serial/sb1250-duart.c
@@ -57,6 +57,12 @@
 #define SBD_CTRLREGS(line)	A_BCM1480_DUART_CTRLREG((line), 0)
 #define SBD_INT(line)		(K_BCM1480_INT_UART_0 + (line))
 
+#define DUART_CHANREG_SPACING	BCM1480_DUART_CHANREG_SPACING
+
+#define R_DUART_IMRREG(line)	R_BCM1480_DUART_IMRREG(line)
+#define R_DUART_INCHREG(line)	R_BCM1480_DUART_INCHREG(line)
+#define R_DUART_ISRREG(line)	R_BCM1480_DUART_ISRREG(line)
+
 #elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_int.h>
diff --git a/include/asm-mips/sibyte/bcm1480_regs.h b/include/asm-mips/sibyte/bcm1480_regs.h
index 2738c13..c34d36b 100644
--- a/include/asm-mips/sibyte/bcm1480_regs.h
+++ b/include/asm-mips/sibyte/bcm1480_regs.h
@@ -227,10 +227,15 @@
 	(A_BCM1480_DUART(chan) +					\
 	 BCM1480_DUART_CHANREG_SPACING * 3 + (reg))
 
+#define DUART_IMRISR_SPACING	    0x20
+#define DUART_INCHNG_SPACING	    0x10
+
 #define R_BCM1480_DUART_IMRREG(chan)					\
 	(R_DUART_IMR_A + ((chan) & 1) * DUART_IMRISR_SPACING)
 #define R_BCM1480_DUART_ISRREG(chan)					\
 	(R_DUART_ISR_A + ((chan) & 1) * DUART_IMRISR_SPACING)
+#define R_BCM1480_DUART_INCHREG(chan)					\
+	(R_DUART_IN_CHNG_A + ((chan) & 1) * DUART_INCHNG_SPACING)
 
 #define A_BCM1480_DUART_IMRREG(chan)					\
 	(A_BCM1480_DUART_CTRLREG((chan), R_BCM1480_DUART_IMRREG(chan)))

-- 
Martin Michlmayr
http://www.cyrius.com/
