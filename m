Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 10:59:44 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:15585 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133504AbWFWJ7E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 10:59:04 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 3BE2AC03E;
	Fri, 23 Jun 2006 11:58:54 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 882911BC08C;
	Fri, 23 Jun 2006 11:58:56 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 8398D1A18A8;
	Fri, 23 Jun 2006 11:58:56 +0200 (CEST)
Date:	Fri, 23 Jun 2006 11:58:58 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 2/8] au1xxx: I2C fixes
Message-ID: <20060623095858.GB31017@domen.ultra.si>
References: <20060623095703.GA30980@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623095703.GA30980@domen.ultra.si>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

- I2C fixes from Jordan Crusoe
- add SMBUS functionality flags

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-mailed/drivers/i2c/busses/i2c-au1550.c
===================================================================
--- linux-mailed.orig/drivers/i2c/busses/i2c-au1550.c
+++ linux-mailed/drivers/i2c/busses/i2c-au1550.c
@@ -35,7 +35,7 @@
 #include <linux/i2c.h>
 
 #include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-pb1x00/pb1550.h>
+#include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
 #include "i2c-au1550.h"
@@ -118,13 +118,19 @@ do_address(struct i2c_au1550_data *adap,
 
 	/* Reset the FIFOs, clear events.
 	*/
-	sp->psc_smbpcr = PSC_SMBPCR_DC;
+	stat = sp->psc_smbstat;
 	sp->psc_smbevnt = PSC_SMBEVNT_ALLCLR;
 	au_sync();
-	do {
-		stat = sp->psc_smbpcr;
+
+	if (!(stat & PSC_SMBSTAT_TE) || !(stat & PSC_SMBSTAT_RE)) {
+		sp->psc_smbpcr = PSC_SMBPCR_DC;
 		au_sync();
-	} while ((stat & PSC_SMBPCR_DC) != 0);
+		do {
+			stat = sp->psc_smbpcr;
+			au_sync();
+		} while ((stat & PSC_SMBPCR_DC) != 0);
+		udelay(50);
+	}
 
 	/* Write out the i2c chip address and specify operation
 	*/
@@ -279,7 +285,7 @@ au1550_xfer(struct i2c_adapter *i2c_adap
 static u32
 au1550_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static struct i2c_algorithm au1550_algo = {
