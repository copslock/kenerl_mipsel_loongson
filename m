Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 02:41:50 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:24327
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224989AbUKUClp>; Sun, 21 Nov 2004 02:41:45 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CVhfc-0004dS-00; Sun, 21 Nov 2004 03:41:44 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CVhfc-0004iz-00; Sun, 21 Nov 2004 03:41:44 +0100
Date: Sun, 21 Nov 2004 03:41:44 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] ip32 build fix
Message-ID: <20041121024144.GK20986@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

a simple build fix for the ip32 framebuffer.


Thiemo


Index: drivers/video/gbefb.c
===================================================================
RCS file: /home/cvs/linux/drivers/video/gbefb.c,v
retrieving revision 1.11
diff -u -p -r1.11 gbefb.c
--- drivers/video/gbefb.c	16 Nov 2004 16:20:39 -0000	1.11
+++ drivers/video/gbefb.c	20 Nov 2004 16:46:58 -0000
@@ -1122,7 +1122,7 @@ static int __init gbefb_probe(struct dev
 
 	if (fb_get_options("gbefb", &option))
 		return -ENODEV;
-	gbefb_setup(options);
+	gbefb_setup(option);
 #endif
 
 	if (!request_mem_region(GBE_BASE, sizeof(struct sgi_gbe), "GBE")) {
