Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 11:00:46 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:19937 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133455AbWFWJ7j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 10:59:39 +0100
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id D0CCDC026;
	Fri, 23 Jun 2006 11:59:25 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 61E491BC094;
	Fri, 23 Jun 2006 11:59:26 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 6C5AE1A18B7;
	Fri, 23 Jun 2006 11:59:26 +0200 (CEST)
Date:	Fri, 23 Jun 2006 11:59:28 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 3/8] au1xxx: I2C support for au1200
Message-ID: <20060623095928.GC31017@domen.ultra.si>
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
X-archive-position: 11815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Add I2C support for au1200.

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-mailed/drivers/i2c/busses/Kconfig
===================================================================
--- linux-mailed.orig/drivers/i2c/busses/Kconfig
+++ linux-mailed/drivers/i2c/busses/Kconfig
@@ -75,11 +75,11 @@ config I2C_AMD8111
 	  will be called i2c-amd8111.
 
 config I2C_AU1550
-	tristate "Au1550 SMBus interface"
-	depends on I2C && SOC_AU1550
+	tristate "Au1550/Au1200 SMBus interface"
+	depends on I2C && (SOC_AU1550 || SOC_AU1200)
 	help
 	  If you say yes to this option, support will be included for the
-	  Au1550 SMBus interface.
+	  Au1550 and Au1200 SMBus interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
