Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 12:16:06 +0100 (BST)
Received: from mga11.intel.com ([192.55.52.93]:63881 "EHLO mga11.intel.com")
	by ftp.linux-mips.org with ESMTP id S20030705AbYFILQE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 12:16:04 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 09 Jun 2008 04:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.27,612,1204531200"; 
   d="scan'208";a="337992158"
Received: from fmsmsx333.amr.corp.intel.com ([132.233.42.2])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2008 04:13:55 -0700
Received: from pdsmsx414.ccr.corp.intel.com ([172.16.12.95]) by fmsmsx333.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 9 Jun 2008 04:15:57 -0700
Received: from pdsmsx415.ccr.corp.intel.com ([172.16.12.184]) by pdsmsx414.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 9 Jun 2008 19:15:54 +0800
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: [patch]modify the MIPS CPU classfication
Date:	Mon, 9 Jun 2008 19:15:58 +0800
Message-ID: <42DFA526FC41B1429CE7279EF83C6BDC01404341@pdsmsx415.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch]modify the MIPS CPU classfication
Thread-Index: AcjKIjEbexxBO5k+To62Keu79ukJrg==
From:	"Chen, Huacai" <huacai.chen@intel.com>
To:	<linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jun 2008 11:15:54.0822 (UTC) FILETIME=[2F1D7E60:01C8CA22]
Return-Path: <huacai.chen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: huacai.chen@intel.com
Precedence: bulk
X-list: linux-mips

The company ID of Loongson1/Loongson2 is PRID_COMP_LEGACY, but they were
classified in the list whoes company ID is  PRID_COMP_MIPS. This patch
move them to the right place.

Signed-off-by: Huacai Chen <huacai.chen@intel.com>

-----
diff --git a/include/asm-mips/cpu.h b/include/asm-mips/cpu.h
index 1c35cac..d3ffe93 100644
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -68,6 +68,8 @@
 #define PRID_IMP_RM9000        0x3400
 #define PRID_IMP_R5432     0x5400
 #define PRID_IMP_R5500     0x5500
+#define PRID_IMP_LOONGSON1      0x4200
+#define PRID_IMP_LOONGSON2      0x6300

 #define PRID_IMP_UNKNOWN   0xff00

@@ -90,8 +92,6 @@
 #define PRID_IMP_24KE      0x9600
 #define PRID_IMP_74K       0x9700
 #define PRID_IMP_1004K     0x9900
-#define PRID_IMP_LOONGSON1      0x4200
-#define PRID_IMP_LOONGSON2      0x6300

 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
-----
