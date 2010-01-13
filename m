Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2010 15:00:51 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:30635 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492615Ab0AMOAq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jan 2010 15:00:46 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 13 Jan 2010 06:00:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.49,268,1262592000"; 
   d="scan'208";a="483648896"
Received: from unknown (HELO localhost.localdomain) ([10.255.12.25])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2010 06:00:17 -0800
Received: from wfg by localhost.localdomain with local (Exim 4.69)
        (envelope-from <fengguang.wu@intel.com>)
        id 1NV3lb-0004hx-EX; Wed, 13 Jan 2010 22:00:11 +0800
Message-Id: <20100113135957.680223335@intel.com>
User-Agent: quilt/0.48-1
Date:   Wed, 13 Jan 2010 21:53:09 +0800
From:   Wu Fengguang <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wu Fengguang <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC:     Andi Kleen <andi@firstfloor.org>
CC:     Nick Piggin <npiggin@suse.de>
CC:     Hugh Dickins <hugh.dickins@tiscali.co.uk>
cc:     Linux Memory Management List <linux-mm@kvack.org>
Subject: [PATCH 4/8] resources: introduce generic page_is_ram()
References: <20100113135305.013124116@intel.com>
Content-Disposition: inline; filename=page-is-ram.patch
X-archive-position: 25583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8578

It's based on walk_system_ram_range(), for archs that don't have
their own page_is_ram().

The static verions in MIPS and SCORE are also made global.

CC: Chen Liqin <liqin.chen@sunplusct.com>
CC: Lennox Wu <lennox.wu@gmail.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> 
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 arch/mips/mm/init.c    |    2 +-
 arch/score/mm/init.c   |    2 +-
 include/linux/ioport.h |    2 ++
 kernel/resource.c      |   10 ++++++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

--- linux-mm.orig/kernel/resource.c	2010-01-10 10:11:53.000000000 +0800
+++ linux-mm/kernel/resource.c	2010-01-10 10:15:33.000000000 +0800
@@ -297,6 +297,16 @@ int walk_system_ram_range(unsigned long 
 
 #endif
 
+static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
+{
+	return 24;
+}
+
+int __attribute__((weak)) page_is_ram(unsigned long pfn)
+{
+	return 24 == walk_system_ram_range(pfn, 1, NULL, __is_ram);
+}
+
 /*
  * Find empty slot in the resource tree given range and alignment.
  */
--- linux-mm.orig/include/linux/ioport.h	2010-01-10 10:11:53.000000000 +0800
+++ linux-mm/include/linux/ioport.h	2010-01-10 10:11:54.000000000 +0800
@@ -188,5 +188,7 @@ extern int
 walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 		void *arg, int (*func)(unsigned long, unsigned long, void *));
 
+extern int page_is_ram(unsigned long pfn);
+
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
--- linux-mm.orig/arch/score/mm/init.c	2010-01-10 10:35:38.000000000 +0800
+++ linux-mm/arch/score/mm/init.c	2010-01-10 10:38:04.000000000 +0800
@@ -59,7 +59,7 @@ static unsigned long setup_zero_page(voi
 }
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-static int __init page_is_ram(unsigned long pagenr)
+int page_is_ram(unsigned long pagenr)
 {
 	if (pagenr >= min_low_pfn && pagenr < max_low_pfn)
 		return 1;
--- linux-mm.orig/arch/mips/mm/init.c	2010-01-10 10:37:22.000000000 +0800
+++ linux-mm/arch/mips/mm/init.c	2010-01-10 10:37:26.000000000 +0800
@@ -298,7 +298,7 @@ void __init fixrange_init(unsigned long 
 }
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-static int __init page_is_ram(unsigned long pagenr)
+int page_is_ram(unsigned long pagenr)
 {
 	int i;
 
