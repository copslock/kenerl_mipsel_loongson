Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2003 22:35:51 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:53309
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225508AbTIUVft>; Sun, 21 Sep 2003 22:35:49 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1Brv-0007aK-00; Sun, 21 Sep 2003 23:35:47 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1Brv-0006tH-00; Sun, 21 Sep 2003 23:35:47 +0200
Date: Sun, 21 Sep 2003 23:35:47 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: [PATCH] Fix unused variable warning in drivers/char/dz.c
Message-ID: <20030921213547.GP13578@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello Maciej,

this fixes an unused variable warning.


Thiemo


diff -abdpruNPX /bigdisk/src/dontdiff linux-orig/drivers/char/dz.c linux/drivers/char/dz.c
--- linux-orig/drivers/char/dz.c	Wed Apr 23 19:17:01 2003
+++ linux/drivers/char/dz.c	Sun Sep 21 22:28:40 2003
@@ -1299,9 +1299,12 @@ static void show_serial_version(void)
 
 int __init dz_init(void)
 {
-	int i, tmp;
+	int i;
 	long flags;
 	struct dz_serial *info;
+#ifndef CONFIG_SERIAL_DEC_CONSOLE
+	int tmp;
+#endif
 
 	/* Setup base handler, and timer table. */
 	init_bh(SERIAL_BH, do_serial_bh);
