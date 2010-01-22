Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:54:44 +0100 (CET)
Received: from mga14.intel.com ([143.182.124.37]:10859 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492403Ab0AVTyk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2010 20:54:40 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 21 Jan 2010 19:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.47,316,1257148800"; 
   d="scan'208";a="235568034"
Received: from wfg-t61.sh.intel.com (HELO localhost.localdomain) ([10.239.22.67])
  by azsmga001.ch.intel.com with ESMTP; 21 Jan 2010 19:30:31 -0800
Received: from wfg by localhost.localdomain with local (Exim 4.69)
        (envelope-from <fengguang.wu@intel.com>)
        id 1NYAE9-0005F5-1P; Fri, 22 Jan 2010 11:30:29 +0800
Message-Id: <20100122033004.193166010@intel.com>
User-Agent: quilt/0.48-1
Date:   Fri, 22 Jan 2010 11:21:03 +0800
From:   Wu Fengguang <fengguang.wu@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Am=C3=A9rico=20Wang?= <xiyou.wangcong@gmail.com>,
        linux-mips@linux-mips.org,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Wu Fengguang <fengguang.wu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@redhat.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Andi Kleen <andi@firstfloor.org>, shaohui.zheng@intel.com
Subject: [PATCH 1/3] resources: introduce generic page_is_ram()
References: <20100122032102.137106635@intel.com>
Content-Disposition: inline; filename=page-is-ram.patch
X-archive-position: 25635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14916

It's based on walk_system_ram_range(), for archs that don't have
their own page_is_ram().

The static verions in MIPS and SCORE are also made global.

CC: Chen Liqin <liqin.chen@sunplusct.com>
CC: Lennox Wu <lennox.wu@gmail.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: Américo Wang <xiyou.wangcong@gmail.com>
CC: linux-mips@linux-mips.org
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> 
CC: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 arch/mips/mm/init.c    |    2 +-
 arch/score/mm/init.c   |    2 +-
 include/linux/ioport.h |    2 ++
 kernel/resource.c      |   11 +++++++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

--- linux-mm.orig/kernel/resource.c	2010-01-22 11:20:34.000000000 +0800
+++ linux-mm/kernel/resource.c	2010-01-22 11:20:35.000000000 +0800
@@ -327,6 +327,17 @@ int walk_system_ram_range(unsigned long 
 
 #endif
 
+#define PAGE_IS_RAM	24
+static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
+{
+	return PAGE_IS_RAM;
+}
+int __attribute__((weak)) page_is_ram(unsigned long pfn)
+{
+	return PAGE_IS_RAM == walk_system_ram_range(pfn, 1, NULL, __is_ram);
+}
+#undef PAGE_IS_RAM
+
 /*
  * Find empty slot in the resource tree given range and alignment.
  */
--- linux-mm.orig/include/linux/ioport.h	2010-01-22 11:20:34.000000000 +0800
+++ linux-mm/include/linux/ioport.h	2010-01-22 11:20:35.000000000 +0800
@@ -191,5 +191,7 @@ extern int
 walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 		void *arg, int (*func)(unsigned long, unsigned long, void *));
 
+extern int page_is_ram(unsigned long pfn);
+
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
--- linux-mm.orig/arch/score/mm/init.c	2010-01-22 11:20:34.000000000 +0800
+++ linux-mm/arch/score/mm/init.c	2010-01-22 11:20:35.000000000 +0800
@@ -59,7 +59,7 @@ static unsigned long setup_zero_page(voi
 }
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-static int __init page_is_ram(unsigned long pagenr)
+int page_is_ram(unsigned long pagenr)
 {
 	if (pagenr >= min_low_pfn && pagenr < max_low_pfn)
 		return 1;
--- linux-mm.orig/arch/mips/mm/init.c	2010-01-22 11:20:34.000000000 +0800
+++ linux-mm/arch/mips/mm/init.c	2010-01-22 11:20:35.000000000 +0800
@@ -298,7 +298,7 @@ void __init fixrange_init(unsigned long 
 }
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-static int __init page_is_ram(unsigned long pagenr)
+int page_is_ram(unsigned long pagenr)
 {
 	int i;
 
