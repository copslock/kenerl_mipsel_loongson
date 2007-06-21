Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 07:07:14 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:18957 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024948AbXFUGHM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2007 07:07:12 +0100
Received: by mo.po.2iij.net (mo30) id l5L65sOX055622; Thu, 21 Jun 2007 15:05:54 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id l5L65qEp025466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Jun 2007 15:05:52 +0900
Date:	Thu, 21 Jun 2007 15:05:52 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove mips_mach setup on WRPPMC
Message-Id: <20070621150552.2040333d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed mips_mach setup on WRPPMC.
It is not used.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

---

remove mips_mach setup on WRPPMC

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/setup.c mips/arch/mips/gt64120/wrppmc/setup.c
--- mips-orig/arch/mips/gt64120/wrppmc/setup.c	2007-06-21 13:55:13.629849500 +0900
+++ mips/arch/mips/gt64120/wrppmc/setup.c	2007-06-21 14:03:32.567346000 +0900
@@ -158,9 +158,6 @@ const char *get_system_type(void)
  */
 void __init prom_init(void)
 {
-	mips_machgroup = MACH_GROUP_GALILEO;
-	mips_machtype = MACH_EV64120A;
-
 	add_memory_region(WRPPMC_SDRAM_SCS0_BASE, WRPPMC_SDRAM_SCS0_SIZE, BOOT_MEM_RAM);
 	add_memory_region(WRPPMC_BOOTROM_BASE, WRPPMC_BOOTROM_SIZE, BOOT_MEM_ROM_DATA);
 
