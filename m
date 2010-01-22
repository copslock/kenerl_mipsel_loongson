Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:46:26 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:56048 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492555Ab0AVTpd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2010 20:45:33 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 22 Jan 2010 00:15:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.49,322,1262592000"; 
   d="scan'208";a="533568544"
Received: from wfg-t61.sh.intel.com (HELO localhost.localdomain) ([10.239.22.67])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jan 2010 00:16:09 -0800
Received: from wfg by localhost.localdomain with local (Exim 4.69)
        (envelope-from <fengguang.wu@intel.com>)
        id 1NYEgl-0001pf-Gx; Fri, 22 Jan 2010 16:16:19 +0800
Date:   Fri, 22 Jan 2010 16:16:19 +0800
From:   Wu Fengguang <fengguang.wu@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        "Zheng, Shaohui" <shaohui.zheng@intel.com>
Subject: [PATCH 1/3 v4] resources: introduce generic page_is_ram()
Message-ID: <20100122081619.GA6431@localhost>
References: <20100122032102.137106635@intel.com> <20100122033004.193166010@intel.com> <4B595904.4000202@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4B595904.4000202@zytor.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14905

On Fri, Jan 22, 2010 at 12:51:32AM -0700, H. Peter Anvin wrote:
> On 01/21/2010 07:21 PM, Wu Fengguang wrote:
> > --- linux-mm.orig/kernel/resource.c	2010-01-22 11:20:34.000000000 +0800
> > +++ linux-mm/kernel/resource.c	2010-01-22 11:20:35.000000000 +0800
> > @@ -327,6 +327,17 @@ int walk_system_ram_range(unsigned long 
> >  
> >  #endif
> >  
> > +#define PAGE_IS_RAM	24
> > +static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
> > +{
> > +	return PAGE_IS_RAM;
> > +}
> > +int __attribute__((weak)) page_is_ram(unsigned long pfn)
> > +{
> > +	return PAGE_IS_RAM == walk_system_ram_range(pfn, 1, NULL, __is_ram);
> > +}
> > +#undef PAGE_IS_RAM
> > +
> 
> Stylistic nitpick:
> 
> The use of the magic number "24" here is pretty ugly; it seems to imply
> that there is something peculiar with this number and that it is trying
> to avoid an overlap, whereas in fact any number but 0 and -1 would do.

Yes, exactly.

> I would rather see just returning 1 and do:
> 
> 	return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;
> 
> (walk_system_ram_range() returning -1 on error, and 0 means continue.)

Good suggestion.

> Note also that we don't write "constant == expression"; although some
> schools teach it as a way to avoid the "=" versus "==" beginner C
> mistake, it makes the code less intuitive to read.

Yeah.

> Other than that, the patchset looks good; if Ingo doesn't beat me to it
> I'll put it in tomorrow (need sleep right now.)

OK, thanks! Here is the updated patch.

---
resources: introduce generic page_is_ram()

It's based on walk_system_ram_range(), for archs that don't have
their own page_is_ram().

The static verions in MIPS and SCORE are also made global.

v4: prefer plain 1 instead of PAGE_IS_RAM (H. Peter Anvin)
v3: add comment (KAMEZAWA Hiroyuki)
    "AFAIK, this "System RAM" information has been used for kdump to
    grab valid memory area and seems good for the kernel itself."
v2: add PAGE_IS_RAM macro (Américo Wang)

CC: Chen Liqin <liqin.chen@sunplusct.com>
CC: Lennox Wu <lennox.wu@gmail.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: Américo Wang <xiyou.wangcong@gmail.com>
CC: linux-mips@linux-mips.org
CC: Yinghai Lu <yinghai@kernel.org>
Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> 
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 arch/mips/mm/init.c    |    2 +-
 arch/score/mm/init.c   |    2 +-
 include/linux/ioport.h |    2 ++
 kernel/resource.c      |   13 +++++++++++++
 4 files changed, 17 insertions(+), 2 deletions(-)

--- linux-mm.orig/kernel/resource.c	2010-01-22 11:20:34.000000000 +0800
+++ linux-mm/kernel/resource.c	2010-01-22 16:12:55.000000000 +0800
@@ -327,6 +327,19 @@ int walk_system_ram_range(unsigned long 
 
 #endif
 
+static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
+{
+	return 1;
+}
+/*
+ * This generic page_is_ram() returns true if specified address is
+ * registered as "System RAM" in iomem_resource list.
+ */
+int __attribute__((weak)) page_is_ram(unsigned long pfn)
+{
+	return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;
+}
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
 
