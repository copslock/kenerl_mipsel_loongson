Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:57:26 +0100 (CET)
Received: from fgwmail8.fujitsu.co.jp ([192.51.44.38]:60288 "EHLO
        fgwmail8.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492736Ab0AVT5V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2010 20:57:21 +0100
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
        by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id o0M4DrP6027715
        (envelope-from kamezawa.hiroyu@jp.fujitsu.com);
        Fri, 22 Jan 2010 13:13:53 +0900
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
        by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id o0M4DoaH014259
        (envelope-from kamezawa.hiroyu@jp.fujitsu.com);
        Fri, 22 Jan 2010 13:13:51 +0900
Received: from smail (m5 [127.0.0.1])
        by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 343D045DE53;
        Fri, 22 Jan 2010 13:13:50 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
        by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id A853545DE56;
        Fri, 22 Jan 2010 13:13:49 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
        by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id F0AD61DB805A;
        Fri, 22 Jan 2010 13:13:48 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
        by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 5201BE38001;
        Fri, 22 Jan 2010 13:13:47 +0900 (JST)
Received: from m105.css.fujitsu.com (m105 [127.0.0.1])
        by m105.s.css.fujitsu.com (Postfix) with ESMTP id 021595E800E;
        Fri, 22 Jan 2010 13:13:47 +0900 (JST)
Received: from WIN-WAU6SZB64RR (unknown [10.124.100.143])
        by m105.s.css.fujitsu.com (Postfix) with SMTP id E34715E800B;
        Fri, 22 Jan 2010 13:13:45 +0900 (JST)
X-SecurityPolicyCheck-FJ: OK by FujitsuOutboundMailChecker v1.3.1
Received: from WIN-WAU6SZB64RR[10.124.100.143] by WIN-WAU6SZB64RR (FujitsuOutboundMailChecker v1.3.1/9992[10.124.100.143]); Fri, 22 Jan 2010 13:10:37 +0900 (JST)
Date:   Fri, 22 Jan 2010 13:10:17 +0900
From:   KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To:     Wu Fengguang <fengguang.wu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?QW3DqXJpY28=?= Wang <xiyou.wangcong@gmail.com>,
        linux-mips@linux-mips.org, Yinghai Lu <yinghai@kernel.org>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>, shaohui.zheng@intel.com
Subject: Re: [PATCH 1/3] resources: introduce generic page_is_ram()
Message-Id: <20100122131017.544dd91b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20100122033004.193166010@intel.com>
References: <20100122032102.137106635@intel.com>
        <20100122033004.193166010@intel.com>
Organization: FUJITSU Co. LTD.
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.10.14; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-archive-position: 25637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamezawa.hiroyu@jp.fujitsu.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14920

On Fri, 22 Jan 2010 11:21:03 +0800
Wu Fengguang <fengguang.wu@intel.com> wrote:

> It's based on walk_system_ram_range(), for archs that don't have
> their own page_is_ram().
> 
> The static verions in MIPS and SCORE are also made global.
> 
> CC: Chen Liqin <liqin.chen@sunplusct.com>
> CC: Lennox Wu <lennox.wu@gmail.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: Am辿rico Wang <xiyou.wangcong@gmail.com>
> CC: linux-mips@linux-mips.org
> CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> 
> CC: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Maybe adding comment like this is good for reviewers..

"This page_is_ram() returns true if specified address is registered
 as System RAM in io_resource list."

AFAIK, this "System RAM" information has been used for kdump to grab valid
memory area and seems good for the kernel itself.

Thanks,
-Kame

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> ---
>  arch/mips/mm/init.c    |    2 +-
>  arch/score/mm/init.c   |    2 +-
>  include/linux/ioport.h |    2 ++
>  kernel/resource.c      |   11 +++++++++++
>  4 files changed, 15 insertions(+), 2 deletions(-)
> 
> --- linux-mm.orig/kernel/resource.c	2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/kernel/resource.c	2010-01-22 11:20:35.000000000 +0800
> @@ -327,6 +327,17 @@ int walk_system_ram_range(unsigned long 
>  
>  #endif
>  
> +#define PAGE_IS_RAM	24
> +static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
> +{
> +	return PAGE_IS_RAM;
> +}
> +int __attribute__((weak)) page_is_ram(unsigned long pfn)
> +{
> +	return PAGE_IS_RAM == walk_system_ram_range(pfn, 1, NULL, __is_ram);
> +}
> +#undef PAGE_IS_RAM
> +
>  /*
>   * Find empty slot in the resource tree given range and alignment.
>   */
> --- linux-mm.orig/include/linux/ioport.h	2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/include/linux/ioport.h	2010-01-22 11:20:35.000000000 +0800
> @@ -191,5 +191,7 @@ extern int
>  walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>  		void *arg, int (*func)(unsigned long, unsigned long, void *));
>  
> +extern int page_is_ram(unsigned long pfn);
> +
>  #endif /* __ASSEMBLY__ */
>  #endif	/* _LINUX_IOPORT_H */
> --- linux-mm.orig/arch/score/mm/init.c	2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/arch/score/mm/init.c	2010-01-22 11:20:35.000000000 +0800
> @@ -59,7 +59,7 @@ static unsigned long setup_zero_page(voi
>  }
>  
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
> -static int __init page_is_ram(unsigned long pagenr)
> +int page_is_ram(unsigned long pagenr)
>  {
>  	if (pagenr >= min_low_pfn && pagenr < max_low_pfn)
>  		return 1;
> --- linux-mm.orig/arch/mips/mm/init.c	2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/arch/mips/mm/init.c	2010-01-22 11:20:35.000000000 +0800
> @@ -298,7 +298,7 @@ void __init fixrange_init(unsigned long 
>  }
>  
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
> -static int __init page_is_ram(unsigned long pagenr)
> +int page_is_ram(unsigned long pagenr)
>  {
>  	int i;
>  
> 
> 
> 
