Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 10:58:52 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:13793 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133455AbWFWJ6i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 10:58:38 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id AB9A6C05F;
	Fri, 23 Jun 2006 11:58:27 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 9FC2C1BC086;
	Fri, 23 Jun 2006 11:58:29 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 949D31A18AF;
	Fri, 23 Jun 2006 11:58:29 +0200 (CEST)
Date:	Fri, 23 Jun 2006 11:58:31 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 1/8] au1xxx: psc fixes + add au1200 adresses
Message-ID: <20060623095831.GA31017@domen.ultra.si>
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
X-archive-position: 11813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Based on Jordan Crusoe's i2c patch:
- fix PSC3_BASE_ADDR to match au1550 databook
- fix PSC_SMBTXRX_RSR
- add PSC addresses for au1200


Signed-off-by: Domen Puncer <domen.puncer@ultra.si>


Index: linux-mailed/include/asm-mips/mach-au1x00/au1xxx_psc.h
===================================================================
--- linux-mailed.orig/include/asm-mips/mach-au1x00/au1xxx_psc.h
+++ linux-mailed/include/asm-mips/mach-au1x00/au1xxx_psc.h
@@ -40,7 +40,12 @@
 #define PSC0_BASE_ADDR		0xb1a00000
 #define PSC1_BASE_ADDR		0xb1b00000
 #define PSC2_BASE_ADDR		0xb0a00000
-#define PSC3_BASE_ADDR		0xb0d00000
+#define PSC3_BASE_ADDR		0xb0b00000
+#endif
+
+#ifdef CONFIG_SOC_AU1200
+#define PSC0_BASE_ADDR		0xb1a00000
+#define PSC1_BASE_ADDR		0xb1b00000
 #endif
 
 /* The PSC select and control registers are common to
@@ -506,7 +511,7 @@ typedef struct	psc_smb {
 
 /* Transmit register control.
 */
-#define PSC_SMBTXRX_RSR		(1 << 30)
+#define PSC_SMBTXRX_RSR		(1 << 28)
 #define PSC_SMBTXRX_STP		(1 << 29)
 #define PSC_SMBTXRX_DATAMASK	(0xff)
 
