Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2005 17:36:04 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:216.31.210.18]:46861 "EHLO
	MMS2.broadcom.com") by linux-mips.org with ESMTP
	id <S8226020AbVHRQfn>; Thu, 18 Aug 2005 17:35:43 +0100
Received: from 10.10.64.121 by MMS2.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Thu, 18 Aug 2005 09:40:20 -0700
X-Server-Uuid: 1F20ACF3-9CAF-44F7-AB47-F294E2D5B4EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Thu, 18 Aug 2005 09:40:18 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BPP15244; Thu, 18 Aug 2005 09:40:17 -0700 (PDT)
Received: from nt-sjca-0740.brcm.ad.broadcom.com (
 nt-sjca-0740.sj.broadcom.com [10.16.192.49]) by
 mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP id JAA06769 for
 <linux-mips@linux-mips.org>; Thu, 18 Aug 2005 09:40:16 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com ([10.16.192.220]) by
 nt-sjca-0740.brcm.ad.broadcom.com with Microsoft SMTPSVC(6.0.3790.211);
 Thu, 18 Aug 2005 09:40:16 -0700
Received: from [10.240.253.79] ([10.240.253.79]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft SMTPSVC(6.0.3790.211);
 Thu, 18 Aug 2005 09:40:16 -0700
Message-ID: <4304B9D4.4030804@broadcom.com>
Date:	Thu, 18 Aug 2005 09:39:48 -0700
From:	"Mark Mason" <mason@broadcom.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: A patch for arch/mips/mm/cache.c
X-OriginalArrivalTime: 18 Aug 2005 16:40:16.0588 (UTC)
 FILETIME=[8367D0C0:01C5A413]
X-WSS-ID: 6F1A667E29O4867814-01-01
Content-Type: multipart/mixed;
 boundary=------------090108060601040505090701
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090108060601040505090701
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

The following patch to cache.c rearranges the logic in cpu_cache_init() 
somewhat to make the detection of the processor via the 
current_cpu_data.cputype take precedence over the cpu_has_4ktlb test.  
This seems to make sense, as the cputype test is significantly more 
specific than the 4ktlb test.  It also arranges for the panic() to 
happen if the 4ktlb test fails as well (the old version would fail 
silently).

It also happens to fix things so that the SB1/swarm starts booting 
again....  ;)

Please consider this for inclusion.

Thanks,
Mark



--------------090108060601040505090701
Content-Type: text/x-patch;
 name=cpu_cache_init.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=cpu_cache_init.patch

Index: cache.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/cache.c,v
retrieving revision 1.21
diff -u -r1.21 cache.c
--- cache.c	6 Jul 2005 12:08:14 -0000	1.21
+++ cache.c	18 Aug 2005 16:33:31 -0000
@@ -114,16 +114,7 @@
 
 void __init cpu_cache_init(void)
 {
-	if (cpu_has_4ktlb) {
-#if defined(CONFIG_CPU_R4X00)  || defined(CONFIG_CPU_VR41XX) || \
-    defined(CONFIG_CPU_R4300)  || defined(CONFIG_CPU_R5000)  || \
-    defined(CONFIG_CPU_NEVADA) || defined(CONFIG_CPU_R5432)  || \
-    defined(CONFIG_CPU_R5500)  || defined(CONFIG_CPU_MIPS32_R1) || \
-    defined(CONFIG_CPU_MIPS64_R1) || defined(CONFIG_CPU_TX49XX) || \
-    defined(CONFIG_CPU_RM7000) || defined(CONFIG_CPU_RM9000)
-		ld_mmu_r4xx0();
-#endif
-	} else switch (current_cpu_data.cputype) {
+	switch (current_cpu_data.cputype) {
 #ifdef CONFIG_CPU_R3000
 	case CPU_R2000:
 	case CPU_R3000:
@@ -156,6 +147,17 @@
 		break;
 
 	default:
+		if (cpu_has_4ktlb) {
+#if defined(CONFIG_CPU_R4X00)  || defined(CONFIG_CPU_VR41XX) || \
+    defined(CONFIG_CPU_R4300)  || defined(CONFIG_CPU_R5000)  || \
+    defined(CONFIG_CPU_NEVADA) || defined(CONFIG_CPU_R5432)  || \
+    defined(CONFIG_CPU_R5500)  || defined(CONFIG_CPU_MIPS32_R1) || \
+    defined(CONFIG_CPU_MIPS64_R1) || defined(CONFIG_CPU_TX49XX) || \
+    defined(CONFIG_CPU_RM7000) || defined(CONFIG_CPU_RM9000)
+			ld_mmu_r4xx0();
+			break;
+#endif
+		}
 		panic("Yeee, unsupported cache architecture.");
 	}
 }

--------------090108060601040505090701--
