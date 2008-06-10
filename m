Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2008 02:05:19 +0100 (BST)
Received: from mga02.intel.com ([134.134.136.20]:34153 "EHLO mga02.intel.com")
	by ftp.linux-mips.org with ESMTP id S20033495AbYFJBFQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jun 2008 02:05:16 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 09 Jun 2008 18:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.27,615,1204531200"; 
   d="scan'208";a="392776074"
Received: from fmsmsx334.amr.corp.intel.com ([132.233.42.1])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2008 18:04:58 -0700
Received: from pdsmsx411.ccr.corp.intel.com ([172.16.12.89]) by fmsmsx334.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 9 Jun 2008 18:05:08 -0700
Received: from pdsmsx415.ccr.corp.intel.com ([172.16.12.184]) by pdsmsx411.ccr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 10 Jun 2008 09:05:05 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: RE: [patch]modify the MIPS CPU classfication
Date:	Tue, 10 Jun 2008 09:05:08 +0800
Message-ID: <42DFA526FC41B1429CE7279EF83C6BDC01404431@pdsmsx415.ccr.corp.intel.com>
In-Reply-To: <Pine.LNX.4.55.0806091330560.26593@cliff.in.clinika.pl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch]modify the MIPS CPU classfication
Thread-Index: AcjKLQ3t3yNX5I2dSn6iZ6hMyMZZswAaL/6g
References: <42DFA526FC41B1429CE7279EF83C6BDC01404341@pdsmsx415.ccr.corp.intel.com> <Pine.LNX.4.55.0806091330560.26593@cliff.in.clinika.pl>
From:	"Chen, Huacai" <huacai.chen@intel.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jun 2008 01:05:05.0973 (UTC) FILETIME=[051CAE50:01C8CA96]
Return-Path: <huacai.chen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: huacai.chen@intel.com
Precedence: bulk
X-list: linux-mips

This is the new patch sorted numerically.

Signed-off-by: Huacai Chen <huacai.chen@intel.com>

----
diff --git a/include/asm-mips/cpu.h b/include/asm-mips/cpu.h
index 1c35cac..229a786 100644
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -66,8 +66,10 @@
 #define PRID_IMP_RM7000		0x2700
 #define PRID_IMP_NEVADA		0x2800		/* RM5260 ??? */
 #define PRID_IMP_RM9000		0x3400
+#define PRID_IMP_LOONGSON1	0x4200
 #define PRID_IMP_R5432		0x5400
 #define PRID_IMP_R5500		0x5500
+#define PRID_IMP_LOONGSON2	0x6300
 
 #define PRID_IMP_UNKNOWN	0xff00
 
@@ -90,8 +92,6 @@
 #define PRID_IMP_24KE		0x9600
 #define PRID_IMP_74K		0x9700
 #define PRID_IMP_1004K		0x9900
-#define PRID_IMP_LOONGSON1      0x4200
-#define PRID_IMP_LOONGSON2      0x6300
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
----

-----Original Message-----
From: macro@cliff.in.clinika.pl [mailto:macro@cliff.in.clinika.pl] On Behalf Of Maciej W. Rozycki
Sent: 2008年6月9日 20:33
To: Chen, Huacai
Cc: linux-mips@linux-mips.org; linux-kernel@vger.kernel.org
Subject: Re: [patch]modify the MIPS CPU classfication

On Mon, 9 Jun 2008, Chen, Huacai wrote:

> The company ID of Loongson1/Loongson2 is PRID_COMP_LEGACY, but they were
> classified in the list whoes company ID is  PRID_COMP_MIPS. This patch
> move them to the right place.

 Note the list is currently sorted numerically and meant to stay such.  
Please update your patch accordingly.

  Maciej
