Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2010 04:29:56 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:16817 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490947Ab0AND3u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jan 2010 04:29:50 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 13 Jan 2010 19:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.49,272,1262592000"; 
   d="scan'208";a="764069671"
Received: from wfg-t61.sh.intel.com (HELO localhost.localdomain) ([10.239.20.251])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2010 19:29:40 -0800
Received: from wfg by localhost.localdomain with local (Exim 4.69)
        (envelope-from <fengguang.wu@intel.com>)
        id 1NVGOw-0004uJ-Lx; Thu, 14 Jan 2010 11:29:38 +0800
Date:   Thu, 14 Jan 2010 11:29:38 +0800
From:   Wu Fengguang <fengguang.wu@intel.com>
To:     =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Andi Kleen <andi@firstfloor.org>,
        Nick Piggin <npiggin@suse.de>,
        Hugh Dickins <hugh.dickins@tiscali.co.uk>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 4/8] resources: introduce generic page_is_ram()
Message-ID: <20100114032938.GB11709@localhost>
References: <20100113135305.013124116@intel.com> <20100113135957.680223335@intel.com> <20100113142923.GB4038@hack>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20100113142923.GB4038@hack>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9095

On Wed, Jan 13, 2010 at 10:29:23PM +0800, Américo Wang wrote:
> On Wed, Jan 13, 2010 at 09:53:09PM +0800, Wu Fengguang wrote:
> >It's based on walk_system_ram_range(), for archs that don't have
> >their own page_is_ram().
> >
> >The static verions in MIPS and SCORE are also made global.
> >
> >CC: Chen Liqin <liqin.chen@sunplusct.com>
> >CC: Lennox Wu <lennox.wu@gmail.com>
> >CC: Ralf Baechle <ralf@linux-mips.org>
> >CC: linux-mips@linux-mips.org
> >CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> 
> >Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> >---
> > arch/mips/mm/init.c    |    2 +-
> > arch/score/mm/init.c   |    2 +-
> > include/linux/ioport.h |    2 ++
> > kernel/resource.c      |   10 ++++++++++
> > 4 files changed, 14 insertions(+), 2 deletions(-)
> >
> >--- linux-mm.orig/kernel/resource.c	2010-01-10 10:11:53.000000000 +0800
> >+++ linux-mm/kernel/resource.c	2010-01-10 10:15:33.000000000 +0800
> >@@ -297,6 +297,16 @@ int walk_system_ram_range(unsigned long 
> > 
> > #endif
> > 
> >+static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
> >+{
> >+	return 24;
> >+}
> >+
> >+int __attribute__((weak)) page_is_ram(unsigned long pfn)
> >+{
> >+	return 24 == walk_system_ram_range(pfn, 1, NULL, __is_ram);
> >+}
> 
> 
> Why do you choose 24 instead of using a macro expressing its meaning?

Hmm, I thought they are close enough to be obvious.
Anyway this should look better:

resources: introduce generic page_is_ram()

It's based on walk_system_ram_range(), for archs that don't have
their own page_is_ram().

The static verions in MIPS and SCORE are also made global.

CC: Chen Liqin <liqin.chen@sunplusct.com>
CC: Lennox Wu <lennox.wu@gmail.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: Américo Wang <xiyou.wangcong@gmail.com>
CC: linux-mips@linux-mips.org
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> 
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 arch/mips/mm/init.c    |    2 +-
 arch/score/mm/init.c   |    2 +-
 include/linux/ioport.h |    2 ++
 kernel/resource.c      |   11 +++++++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

--- linux-mm.orig/kernel/resource.c	2010-01-13 21:27:28.000000000 +0800
+++ linux-mm/kernel/resource.c	2010-01-14 11:28:20.000000000 +0800
@@ -297,6 +297,17 @@ int walk_system_ram_range(unsigned long 
 
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
--- linux-mm.orig/include/linux/ioport.h	2010-01-13 21:27:28.000000000 +0800
+++ linux-mm/include/linux/ioport.h	2010-01-13 21:44:50.000000000 +0800
@@ -188,5 +188,7 @@ extern int
 walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 		void *arg, int (*func)(unsigned long, unsigned long, void *));
 
+extern int page_is_ram(unsigned long pfn);
+
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
--- linux-mm.orig/arch/score/mm/init.c	2010-01-13 21:27:28.000000000 +0800
+++ linux-mm/arch/score/mm/init.c	2010-01-13 21:44:50.000000000 +0800
@@ -59,7 +59,7 @@ static unsigned long setup_zero_page(voi
 }
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-static int __init page_is_ram(unsigned long pagenr)
+int page_is_ram(unsigned long pagenr)
 {
 	if (pagenr >= min_low_pfn && pagenr < max_low_pfn)
 		return 1;
--- linux-mm.orig/arch/mips/mm/init.c	2010-01-13 21:27:28.000000000 +0800
+++ linux-mm/arch/mips/mm/init.c	2010-01-13 21:44:50.000000000 +0800
@@ -298,7 +298,7 @@ void __init fixrange_init(unsigned long 
 }
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-static int __init page_is_ram(unsigned long pagenr)
+int page_is_ram(unsigned long pagenr)
 {
 	int i;
 
