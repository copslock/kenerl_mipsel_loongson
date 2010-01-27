Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 01:32:28 +0100 (CET)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36039 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493504Ab0A0AcX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2010 01:32:23 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0R0V0Zq001427
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 26 Jan 2010 16:31:01 -0800
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
        by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id o0R0UwSX032181;
        Tue, 26 Jan 2010 16:30:58 -0800
Date:   Tue, 26 Jan 2010 16:30:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wu Fengguang <fengguang.wu@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        "Zheng, Shaohui" <shaohui.zheng@intel.com>
Subject: Re: [PATCH 1/3 v4] resources: introduce generic page_is_ram()
Message-Id: <20100126163058.1f2f6582.akpm@linux-foundation.org>
In-Reply-To: <20100122081619.GA6431@localhost>
References: <20100122032102.137106635@intel.com>
        <20100122033004.193166010@intel.com>
        <4B595904.4000202@zytor.com>
        <20100122081619.GA6431@localhost>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
X-archive-position: 25694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17201

On Fri, 22 Jan 2010 16:16:19 +0800
Wu Fengguang <fengguang.wu@intel.com> wrote:

> 
> It's based on walk_system_ram_range(), for archs that don't have
> their own page_is_ram().
> 
> The static verions in MIPS and SCORE are also made global.
> 
> v4: prefer plain 1 instead of PAGE_IS_RAM (H. Peter Anvin)
> v3: add comment (KAMEZAWA Hiroyuki)
>     "AFAIK, this "System RAM" information has been used for kdump to
>     grab valid memory area and seems good for the kernel itself."
> v2: add PAGE_IS_RAM macro (Am__rico Wang)
> 
> CC: Chen Liqin <liqin.chen@sunplusct.com>
> CC: Lennox Wu <lennox.wu@gmail.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: Am__rico Wang <xiyou.wangcong@gmail.com>
> CC: linux-mips@linux-mips.org
> CC: Yinghai Lu <yinghai@kernel.org>
> Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> 
> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> ---
>  arch/mips/mm/init.c    |    2 +-
>  arch/score/mm/init.c   |    2 +-
>  include/linux/ioport.h |    2 ++
>  kernel/resource.c      |   13 +++++++++++++
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> --- linux-mm.orig/kernel/resource.c	2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/kernel/resource.c	2010-01-22 16:12:55.000000000 +0800
> @@ -327,6 +327,19 @@ int walk_system_ram_range(unsigned long 
>  
>  #endif
>  
> +static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
> +{
> +	return 1;
> +}
> +/*
> + * This generic page_is_ram() returns true if specified address is
> + * registered as "System RAM" in iomem_resource list.
> + */
> +int __attribute__((weak)) page_is_ram(unsigned long pfn)
> +{
> +	return walk_system_ram_range(pfn, 1, NULL, __is_ram) == 1;
> +}

I'll switch this to use __weak.

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

Is it appropriate that this function be declared in ioport.h?  It's a
pretty general function.  Dunno.

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

hm, so we lose the __init.
