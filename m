Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Dec 2002 15:32:01 +0100 (CET)
Received: from p508B5422.dip.t-dialin.net ([80.139.84.34]:11168 "EHLO
	p508B5422.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225204AbSLCOb1>; Tue, 3 Dec 2002 15:31:27 +0100
Received: from johanna5.ux.his.no ([IPv6:::ffff:152.94.1.25]:9644 "EHLO
	johanna5.ux.his.no") by ralf.linux-mips.org with ESMTP
	id <S872253AbSLCNCJ>; Tue, 3 Dec 2002 14:02:09 +0100
Received: from johanna5.ux.his.no (localhost [127.0.0.1])
	by johanna5.ux.his.no (8.12.6/8.12.6) with ESMTP id gB3D7d0o003092;
	Tue, 3 Dec 2002 14:07:40 +0100 (MET)
Received: (from erlend-a@localhost)
	by johanna5.ux.his.no (8.12.6/8.12.6/Submit) id gB3D7cSQ003091;
	Tue, 3 Dec 2002 14:07:38 +0100 (MET)
Date: Tue, 3 Dec 2002 14:07:38 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@gnu.org>,
	linux-mips@linux-mips.org
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (mips)
Message-ID: <20021203130738.GF2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
X-Scanned-By: MIMEDefang 2.24 (www . roaringpenguin . com / mimedefang)
Return-Path: <erlend-a@ux.his.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erlend-a@ux.his.no
Precedence: bulk
X-list: linux-mips

Remove CONFIG_UDF_RW from mips{,64} defconfigs, (it's not used anymore)

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/mips/defconfig linux-2.5.50-eaa/arch/mips/defconfig
--- linux-2.5.50/arch/mips/defconfig	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig	Tue Dec  3 00:48:05 2002
@@ -456,7 +456,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-atlas linux-2.5.50-eaa/arch/mips/defconfig-atlas
--- linux-2.5.50/arch/mips/defconfig-atlas	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-atlas	Tue Dec  3 00:48:05 2002
@@ -446,7 +446,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-ddb5476 linux-2.5.50-eaa/arch/mips/defconfig-ddb5476
--- linux-2.5.50/arch/mips/defconfig-ddb5476	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-ddb5476	Tue Dec  3 00:48:05 2002
@@ -480,7 +480,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-ddb5477 linux-2.5.50-eaa/arch/mips/defconfig-ddb5477
--- linux-2.5.50/arch/mips/defconfig-ddb5477	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-ddb5477	Tue Dec  3 00:48:05 2002
@@ -407,7 +407,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-decstation linux-2.5.50-eaa/arch/mips/defconfig-decstation
--- linux-2.5.50/arch/mips/defconfig-decstation	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-decstation	Tue Dec  3 00:48:05 2002
@@ -443,7 +443,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-ip22 linux-2.5.50-eaa/arch/mips/defconfig-ip22
--- linux-2.5.50/arch/mips/defconfig-ip22	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-ip22	Tue Dec  3 00:48:05 2002
@@ -456,7 +456,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-it8172 linux-2.5.50-eaa/arch/mips/defconfig-it8172
--- linux-2.5.50/arch/mips/defconfig-it8172	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-it8172	Tue Dec  3 00:48:05 2002
@@ -559,7 +559,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-malta linux-2.5.50-eaa/arch/mips/defconfig-malta
--- linux-2.5.50/arch/mips/defconfig-malta	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-malta	Tue Dec  3 00:48:05 2002
@@ -472,7 +472,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-nino linux-2.5.50-eaa/arch/mips/defconfig-nino
--- linux-2.5.50/arch/mips/defconfig-nino	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-nino	Tue Dec  3 00:48:05 2002
@@ -283,7 +283,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_NCPFS_NLS is not set
diff -urN linux-2.5.50/arch/mips/defconfig-ocelot linux-2.5.50-eaa/arch/mips/defconfig-ocelot
--- linux-2.5.50/arch/mips/defconfig-ocelot	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-ocelot	Tue Dec  3 00:48:05 2002
@@ -408,7 +408,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-pb1000 linux-2.5.50-eaa/arch/mips/defconfig-pb1000
--- linux-2.5.50/arch/mips/defconfig-pb1000	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-pb1000	Tue Dec  3 00:48:05 2002
@@ -395,7 +395,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-rm200 linux-2.5.50-eaa/arch/mips/defconfig-rm200
--- linux-2.5.50/arch/mips/defconfig-rm200	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-rm200	Tue Dec  3 00:48:05 2002
@@ -326,7 +326,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set

diff -urN linux-2.5.50/arch/mips64/defconfig linux-2.5.50-eaa/arch/mips64/defconfig
--- linux-2.5.50/arch/mips64/defconfig	Sun Oct 13 19:24:14 2002
+++ linux-2.5.50-eaa/arch/mips64/defconfig	Tue Dec  3 00:48:05 2002
@@ -414,7 +414,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips64/defconfig-ip22 linux-2.5.50-eaa/arch/mips64/defconfig-ip22
--- linux-2.5.50/arch/mips64/defconfig-ip22	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips64/defconfig-ip22	Tue Dec  3 00:48:05 2002
@@ -418,7 +418,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips64/defconfig-ip27 linux-2.5.50-eaa/arch/mips64/defconfig-ip27
--- linux-2.5.50/arch/mips64/defconfig-ip27	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips64/defconfig-ip27	Tue Dec  3 00:48:05 2002
@@ -413,7 +413,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips64/defconfig-ip32 linux-2.5.50-eaa/arch/mips64/defconfig-ip32
--- linux-2.5.50/arch/mips64/defconfig-ip32	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips64/defconfig-ip32	Tue Dec  3 00:48:05 2002
@@ -444,7 +444,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
