Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:46:00 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:56048 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492553Ab0AVTpc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2010 20:45:32 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 21 Jan 2010 21:51:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.49,322,1262592000"; 
   d="scan'208";a="533534828"
Received: from wfg-t61.sh.intel.com (HELO localhost.localdomain) ([10.239.22.67])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2010 21:52:07 -0800
Received: from wfg by localhost.localdomain with local (Exim 4.69)
        (envelope-from <fengguang.wu@intel.com>)
        id 1NYCRN-0002B2-Tm; Fri, 22 Jan 2010 13:52:17 +0800
Date:   Fri, 22 Jan 2010 13:52:17 +0800
From:   Wu Fengguang <fengguang.wu@intel.com>
To:     Xiaotian Feng <xtfeng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [PATCH 1/3] resources: introduce generic page_is_ram()
Message-ID: <20100122055217.GA8358@localhost>
References: <20100122032102.137106635@intel.com> <20100122033004.193166010@intel.com> <7b6bb4a51001212115j741e91c4p61f3f1d6e2ec1de4@mail.gmail.com> <20100122053711.GB3761@localhost> <7b6bb4a51001212150h32f62e53ga230b381ce5da126@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b6bb4a51001212150h32f62e53ga230b381ce5da126@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14904

On Thu, Jan 21, 2010 at 09:50:01PM -0800, Xiaotian Feng wrote:
> On Fri, Jan 22, 2010 at 1:37 PM, Wu Fengguang <fengguang.wu@intel.com> wrote:
> > On Thu, Jan 21, 2010 at 10:15:50PM -0700, Xiaotian Feng wrote:
> >> On Fri, Jan 22, 2010 at 11:21 AM, Wu Fengguang <fengguang.wu@intel.com> wrote:
> >> > It's based on walk_system_ram_range(), for archs that don't have
> >> > their own page_is_ram().
> >> >
> >> > The static verions in MIPS and SCORE are also made global.
> >> >
> >> > CC: Chen Liqin <liqin.chen@sunplusct.com>
> >> > CC: Lennox Wu <lennox.wu@gmail.com>
> >> > CC: Ralf Baechle <ralf@linux-mips.org>
> >> > CC: Américo Wang <xiyou.wangcong@gmail.com>
> >> > CC: linux-mips@linux-mips.org
> >> > CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> >> > CC: Yinghai Lu <yinghai@kernel.org>
> >> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> >> > ---
> >> >  arch/mips/mm/init.c    |    2 +-
> >> >  arch/score/mm/init.c   |    2 +-
> >> >  include/linux/ioport.h |    2 ++
> >> >  kernel/resource.c      |   11 +++++++++++
> >> >  4 files changed, 15 insertions(+), 2 deletions(-)
> >> >
> >> > --- linux-mm.orig/kernel/resource.c     2010-01-22 11:20:34.000000000 +0800
> >> > +++ linux-mm/kernel/resource.c  2010-01-22 11:20:35.000000000 +0800
> >> > @@ -327,6 +327,17 @@ int walk_system_ram_range(unsigned long
> >> >
> >> >  #endif
> >> >
> >> > +#define PAGE_IS_RAM    24
> >> > +static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
> >> > +{
> >> > +       return PAGE_IS_RAM;
> >> > +}
> >> > +int __attribute__((weak)) page_is_ram(unsigned long pfn)
> >> > +{
> >> > +       return PAGE_IS_RAM == walk_system_ram_range(pfn, 1, NULL, __is_ram);
> >> > +}
> >> > +#undef PAGE_IS_RAM
> >> > +
> >>
> >> I'm not sure, but any build test for powerpc/mips/score?
> >
> > Sorry, no build tests yet:
> >
> >        /bin/sh: score-linux-gcc: command not found
> >
> > I just make the mips/score page_is_ram() non-static and assume that
> > will make it compile.
> >
> >> walk_system_ram_range is defined when CONFIG_ARCH_HAS_WALK_MEMORY is not set.
> >> Is it safe when CONFIG_ARCH_HAS_WALK_MEMORY is set for some powerpc archs?
> >
> > Good question. Grep shows that CONFIG_ARCH_HAS_WALK_MEMORY is only
> > defined for powerpc, and it has its own page_is_ram() as well as
> > walk_system_ram_range().
> >
> > walk_system_ram_range() must be defined somewhere because it is
> > expected to be generic routine: exported and called from both
> > in-kernel and out-of-tree code.
> >
> 
> Yes, powerpc has its own walk_system_ram_range() and page_is_ram() ;-)
> 
> Would it be better if moving the weak attribute page_is_ram() into #if
> !defined(CONFIG_ARCH_HAS_WALK_MEMORY) ?

Only several archs defined page_is_ram(), so that would not be feasible
for doing a _generic_ page_is_ram().

Thanks,
Fengguang
