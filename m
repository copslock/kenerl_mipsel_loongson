Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2006 12:57:14 +0100 (BST)
Received: from mail04.hansenet.de ([213.191.73.12]:20730 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037893AbWH0L4r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 27 Aug 2006 12:56:47 +0100
Received: from [213.39.141.67] (213.39.141.67) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 44EC4423000F6381; Sun, 27 Aug 2006 13:56:40 +0200
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by sarkovy.koeller.dyndns.org (Postfix) with ESMTP id 691051770BF;
	Sun, 27 Aug 2006 13:56:40 +0200 (CEST)
X-Mailbox-Line:	From 2d1b307b9d04def7e4fcf2205b8f5cf76ac4eea2 Mon Sep 17 00:00:00 2001
From:	thomas@koeller.dyndns.org
Date:	Sun, 27 Aug 2006 13:53:16 +0200
Subject: [PATCH] Suppress compiler warnings
Organization: Basler AG
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas =?iso-8859-15?q?K=F6ller?= <thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608271353.16681.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

The excite platform exports hardware resources for device drivers to use.
Any driver wanting to use these resources will look up them by their names.
Since these resources are declared to have static linkage, but are not used
in the source file defining them, the compiler used to emit an 'unused'
warning, which this patch suppresses.

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>
---
 arch/mips/basler/excite/excite_device.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/basler/excite/excite_device.c 
b/arch/mips/basler/excite/excite_device.c
index bbb4ea4..cc1ce77 100644
--- a/arch/mips/basler/excite/excite_device.c
+++ b/arch/mips/basler/excite/excite_device.c
@@ -68,7 +68,7 @@ enum {
 
 
 static struct resource
-	excite_ctr_resource = {
+	excite_ctr_resource __attribute__((unused)) = {
 		.name		= "GPI counters",
 		.start		= 0,
 		.end		= 5,
@@ -77,7 +77,7 @@ static struct resource
 		.sibling	= NULL,
 		.child		= NULL
 	},
-	excite_gpislice_resource = {
+	excite_gpislice_resource __attribute__((unused)) = {
 		.name		= "GPI slices",
 		.start		= 0,
 		.end		= 1,
@@ -86,7 +86,7 @@ static struct resource
 		.sibling	= NULL,
 		.child		= NULL
 	},
-	excite_mdio_channel_resource = {
+	excite_mdio_channel_resource __attribute__((unused)) = {
 		.name		= "MDIO channels",
 		.start		= 0,
 		.end		= 1,
@@ -95,7 +95,7 @@ static struct resource
 		.sibling	= NULL,
 		.child		= NULL
 	},
-	excite_fifomem_resource = {
+	excite_fifomem_resource __attribute__((unused)) = {
 		.name		= "FIFO memory",
 		.start		= 0,
 		.end		= 767,
@@ -104,7 +104,7 @@ static struct resource
 		.sibling	= NULL,
 		.child		= NULL
 	},
-	excite_scram_resource = {
+	excite_scram_resource __attribute__((unused)) = {
 		.name		= "Scratch RAM",
 		.start		= EXCITE_PHYS_SCRAM,
 		.end		= EXCITE_PHYS_SCRAM + EXCITE_SIZE_SCRAM - 1,
@@ -113,7 +113,7 @@ static struct resource
 		.sibling	= NULL,
 		.child		= NULL
 	},
-	excite_fpga_resource = {
+	excite_fpga_resource __attribute__((unused)) = {
 		.name		= "System FPGA",
 		.start		= EXCITE_PHYS_FPGA,
 		.end		= EXCITE_PHYS_FPGA + EXCITE_SIZE_FPGA - 1,
@@ -122,7 +122,7 @@ static struct resource
 		.sibling	= NULL,
 		.child		= NULL
 	},
-	excite_nand_resource = {
+	excite_nand_resource __attribute__((unused)) = {
 		.name		= "NAND flash control",
 		.start		= EXCITE_PHYS_NAND,
 		.end		= EXCITE_PHYS_NAND + EXCITE_SIZE_NAND - 1,
@@ -131,7 +131,7 @@ static struct resource
 		.sibling	= NULL,
 		.child		= NULL
 	},
-	excite_titan_resource = {
+	excite_titan_resource __attribute__((unused)) = {
 		.name		= "TITAN registers",
 		.start		= EXCITE_PHYS_TITAN,
 		.end		= EXCITE_PHYS_TITAN + EXCITE_SIZE_TITAN - 1,
-- 
1.4.0


-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
