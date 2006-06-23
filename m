Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 11:03:48 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:30433 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133501AbWFWKBA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 11:01:00 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 5FBCDC051;
	Fri, 23 Jun 2006 12:00:49 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 78B9F1BC092;
	Fri, 23 Jun 2006 12:00:51 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 70D8E1A18A8;
	Fri, 23 Jun 2006 12:00:51 +0200 (CEST)
Date:	Fri, 23 Jun 2006 12:00:53 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 6/8] au1xxx: oss sound support for au1200
Message-ID: <20060623100053.GF31017@domen.ultra.si>
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
X-archive-position: 11818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

au1550 ac97 driver works fine on au1200 too.

Comments at the top of file state this code is GPL, so lets
mark it as GPL too.

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-mailed/sound/oss/Kconfig
===================================================================
--- linux-mailed.orig/sound/oss/Kconfig
+++ linux-mailed/sound/oss/Kconfig
@@ -114,8 +114,9 @@ config SOUND_VRC5477
 	  with the AC97 codec.
 
 config SOUND_AU1550_AC97
-	tristate "Au1550 AC97 Sound"
-	depends on SOUND_PRIME && SOC_AU1550
+	tristate "Au1550/Au1200 AC97 Sound"
+	select SND_AC97_CODEC
+	depends on SOUND_PRIME && (SOC_AU1550 || SOC_AU1200)
 
 config SOUND_AU1550_I2S
 	tristate "Au1550 I2S Sound"
Index: linux-mailed/sound/oss/au1550_ac97.c
===================================================================
--- linux-mailed.orig/sound/oss/au1550_ac97.c
+++ linux-mailed/sound/oss/au1550_ac97.c
@@ -1893,6 +1893,8 @@ static /*const */ struct file_operations
 
 MODULE_AUTHOR("Advanced Micro Devices (AMD), dan@embeddededge.com");
 MODULE_DESCRIPTION("Au1550 AC97 Audio Driver");
+MODULE_LICENSE("GPL");
+
 
 static int __devinit
 au1550_probe(void)
