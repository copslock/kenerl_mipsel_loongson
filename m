Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2003 22:31:07 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:50749
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225508AbTIUVbF>; Sun, 21 Sep 2003 22:31:05 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1BnM-0007Y7-00; Sun, 21 Sep 2003 23:31:04 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1BnM-0006t0-00; Sun, 21 Sep 2003 23:31:04 +0200
Date: Sun, 21 Sep 2003 23:31:04 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: [PATCH] Fix character loss in drivers/tc/zs.c
Message-ID: <20030921213104.GO13578@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello Maciej,

this patch reduces the zs driver's character lossage.


Thiemo


diff -abdpruNPX /bigdisk/src/dontdiff linux-orig/drivers/tc/zs.c linux/drivers/tc/zs.c
--- linux-orig/drivers/tc/zs.c	Tue Aug 12 04:11:58 2003
+++ linux/drivers/tc/zs.c	Sun Sep 21 22:28:40 2003
@@ -456,7 +456,7 @@ static _INLINE_ void receive_chars(struc
 
 		if (info->hook && info->hook->rx_char) {
 			(*info->hook->rx_char)(ch, flag);
-			return;
+			break;
   		}
 
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
