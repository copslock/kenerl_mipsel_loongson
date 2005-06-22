Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 00:05:11 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:216.31.210.19]:8717 "EHLO
	MMS3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225439AbVFVXDM>; Thu, 23 Jun 2005 00:03:12 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Wed, 22 Jun 2005 16:02:03 -0700
X-Server-Uuid: 35E76369-CF33-4172-911A-D1698BD5E887
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:01:52 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BFO30854; Wed, 22 Jun 2005 16:01:51 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id QAA02625 for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:01:51
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j5MN1pov008186 for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005
 16:01:51 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j5MN1pv17980 for linux-mips@linux-mips.org; Wed, 22 Jun 2005
 16:01:51 -0700
Date:	Wed, 22 Jun 2005 16:01:51 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch 4/5] SiByte fixes for 2.6.12
Message-ID: <20050622230151.GA17970@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20050622230003.GA17725@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6EA732612EO417714-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

If the CPU Options get out of sync with the CONFIG_CPU_ options,
cpu_cache_init() can end up being a noop.  Stop with a useful message
in that case rather than running on without cache functions.

Signed-Off-By: Andrew Isaacson <adi@broadcom.com>

Index: linux-2.6-work/arch/mips/mm/cache.c
===================================================================
--- linux-2.6-work.orig/arch/mips/mm/cache.c	2005-06-22 11:17:20.000000000 -0700
+++ linux-2.6-work/arch/mips/mm/cache.c	2005-06-22 11:17:32.000000000 -0700
@@ -122,6 +122,8 @@
     defined(CONFIG_CPU_MIPS64) || defined(CONFIG_CPU_TX49XX) || \
     defined(CONFIG_CPU_RM7000) || defined(CONFIG_CPU_RM9000)
 		ld_mmu_r4xx0();
+#else
+    		panic("Unknown CPU with r4k TLB");
 #endif
 	} else switch (current_cpu_data.cputype) {
 #ifdef CONFIG_CPU_R3000

--
