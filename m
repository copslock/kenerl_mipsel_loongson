Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 04:07:19 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:48138 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490948Ab0A0DHO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2010 04:07:14 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 26 Jan 2010 19:06:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.49,350,1262592000"; 
   d="scan'208";a="487329230"
Received: from unknown (HELO localhost.localdomain) ([10.255.12.210])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2010 19:06:36 -0800
Received: from wfg by localhost.localdomain with local (Exim 4.69)
        (envelope-from <fengguang.wu@intel.com>)
        id 1NZyEp-0003Cc-SS; Wed, 27 Jan 2010 11:06:39 +0800
Date:   Wed, 27 Jan 2010 11:06:39 +0800
From:   Wu Fengguang <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH 1/3 v4] resources: introduce generic page_is_ram()
Message-ID: <20100127030639.GD8132@localhost>
References: <20100122032102.137106635@intel.com> <20100122033004.193166010@intel.com> <4B595904.4000202@zytor.com> <20100122081619.GA6431@localhost> <20100126163058.1f2f6582.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100126163058.1f2f6582.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17264

On Tue, Jan 26, 2010 at 05:30:58PM -0700, Andrew Morton wrote:

> > +int __attribute__((weak)) page_is_ram(unsigned long pfn)
> > +{
> > +	return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;
> > +}
> 
> I'll switch this to use __weak.

Thanks.

> >  /*
> >   * Find empty slot in the resource tree given range and alignment.
> >   */
> > --- linux-mm.orig/include/linux/ioport.h	2010-01-22 11:20:34.000000000 +0800
> > +++ linux-mm/include/linux/ioport.h	2010-01-22 11:20:35.000000000 +0800
> > @@ -191,5 +191,7 @@ extern int
> >  walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
> >  		void *arg, int (*func)(unsigned long, unsigned long, void *));
> >  
> > +extern int page_is_ram(unsigned long pfn);
> 
> Is it appropriate that this function be declared in ioport.h?  It's a
> pretty general function.  Dunno.

Good suggestion. The following patch moves it to mm.h.

> >  #endif /* __ASSEMBLY__ */
> >  #endif	/* _LINUX_IOPORT_H */
> > --- linux-mm.orig/arch/score/mm/init.c	2010-01-22 11:20:34.000000000 +0800
> > +++ linux-mm/arch/score/mm/init.c	2010-01-22 11:20:35.000000000 +0800
> > @@ -59,7 +59,7 @@ static unsigned long setup_zero_page(voi
> >  }
> >  
> >  #ifndef CONFIG_NEED_MULTIPLE_NODES
> > -static int __init page_is_ram(unsigned long pagenr)
> > +int page_is_ram(unsigned long pagenr)
> >  {
> >  	if (pagenr >= min_low_pfn && pagenr < max_low_pfn)
> >  		return 1;
> > --- linux-mm.orig/arch/mips/mm/init.c	2010-01-22 11:20:34.000000000 +0800
> > +++ linux-mm/arch/mips/mm/init.c	2010-01-22 11:20:35.000000000 +0800
> > @@ -298,7 +298,7 @@ void __init fixrange_init(unsigned long 
> >  }
> >  
> >  #ifndef CONFIG_NEED_MULTIPLE_NODES
> > -static int __init page_is_ram(unsigned long pagenr)
> > +int page_is_ram(unsigned long pagenr)
> >  {
> >  	int i;
> 
> hm, so we lose the __init.

Maybe Ralf Baechle knows whether MIPS can switch to the (smaller) 
generic page_is_ram().

Thanks,
Fengguang
---
move page_is_ram() declaration to mm.h

---
 include/linux/ioport.h |    2 --
 include/linux/mm.h     |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-mm.orig/include/linux/ioport.h	2010-01-27 11:04:22.000000000 +0800
+++ linux-mm/include/linux/ioport.h	2010-01-27 11:04:38.000000000 +0800
@@ -191,7 +191,5 @@ extern int
 walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 		void *arg, int (*func)(unsigned long, unsigned long, void *));
 
-extern int page_is_ram(unsigned long pfn);
-
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
--- linux-mm.orig/include/linux/mm.h	2010-01-27 11:04:43.000000000 +0800
+++ linux-mm/include/linux/mm.h	2010-01-27 11:05:30.000000000 +0800
@@ -265,6 +265,8 @@ static inline int get_page_unless_zero(s
 	return atomic_inc_not_zero(&page->_count);
 }
 
+extern int page_is_ram(unsigned long pfn);
+
 /* Support for virtually mapped pages */
 struct page *vmalloc_to_page(const void *addr);
 unsigned long vmalloc_to_pfn(const void *addr);
