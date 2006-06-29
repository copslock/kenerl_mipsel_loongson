Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2006 16:42:08 +0100 (BST)
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32782 "HELO
	mailout.stusta.mhn.de") by ftp.linux-mips.org with SMTP
	id S8133730AbWF2Plz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Jun 2006 16:41:55 +0100
Received: (qmail 21184 invoked from network); 29 Jun 2006 15:41:48 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailout.stusta.mhn.de with SMTP; 29 Jun 2006 15:41:48 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id A3470103A59; Thu, 29 Jun 2006 17:41:48 +0200 (CEST)
Date:	Thu, 29 Jun 2006 17:41:48 +0200
From:	Adrian Bunk <bunk@stusta.de>
To:	Andrew Morton <akpm@osdl.org>
Cc:	Samuel.Ortiz@nokia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] fix the AU1000_FIR dependencies
Message-ID: <20060629154148.GA19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

This patch fixes the AU1000_FIR dependencies.

Spotted by Jean-Luc Leger.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 Apr 2006

--- linux-2.6.17-rc1-mm2-full/drivers/net/irda/Kconfig.old	2006-04-15 16:17:36.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/net/irda/Kconfig	2006-04-15 16:18:06.000000000 +0200
@@ -350,7 +350,7 @@
 
 config AU1000_FIR
 	tristate "Alchemy Au1000 SIR/FIR"
-	depends on MIPS_AU1000 && IRDA
+	depends on SOC_AU1000 && IRDA
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"
