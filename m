Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 20:07:31 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:43680 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493854Ab0AVTHY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2010 20:07:24 +0100
Received: by pwj1 with SMTP id 1so996317pwj.24
        for <linux-mips@linux-mips.org>; Fri, 22 Jan 2010 11:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CDx/DQN9cY/ZhhpXafLX6X87F+hNlqdP1O4eHRbLrw0=;
        b=C/qW9HoBeeXVFBk+LKtLu24QN18FkceE9+eRAV5lqeg8j8ApmMAT2rpzCB2MjYczQH
         BobYwkfgbi256jK7/ar9xrsMgrXSGpewhz2FIs04kDkCXJAvcx3O70hixmwTmCCVRBWi
         LYV1KWj4J7KtJREBkViCVDPQZV7WT4hXbes1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aXe+INnT0hA3tt76XqFC9SM0U1abVYPFeKX8rQrgdmq/VHvM//aTJxMGIpON+XUxZs
         EpdVE691N33Dsb0uePoogzjReFzby56JoEU3AJIW8gmUevKm6HfCRdsAwDcHa4MxdI7C
         8Vk0UPzP3JA7Qeynpy19RXxshcp+6hNze+Amw=
MIME-Version: 1.0
Received: by 10.140.55.5 with SMTP id d5mr1112342rva.177.1264137350073; Thu, 
        21 Jan 2010 21:15:50 -0800 (PST)
In-Reply-To: <20100122033004.193166010@intel.com>
References: <20100122032102.137106635@intel.com>
         <20100122033004.193166010@intel.com>
Date:   Fri, 22 Jan 2010 13:15:50 +0800
Message-ID: <7b6bb4a51001212115j741e91c4p61f3f1d6e2ec1de4@mail.gmail.com>
Subject: Re: [PATCH 1/3] resources: introduce generic page_is_ram()
From:   Xiaotian Feng <xtfeng@gmail.com>
To:     Wu Fengguang <fengguang.wu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>,
        linux-mips@linux-mips.org,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>, shaohui.zheng@intel.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 25626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xtfeng@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14570

On Fri, Jan 22, 2010 at 11:21 AM, Wu Fengguang <fengguang.wu@intel.com> wrote:
> It's based on walk_system_ram_range(), for archs that don't have
> their own page_is_ram().
>
> The static verions in MIPS and SCORE are also made global.
>
> CC: Chen Liqin <liqin.chen@sunplusct.com>
> CC: Lennox Wu <lennox.wu@gmail.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: Américo Wang <xiyou.wangcong@gmail.com>
> CC: linux-mips@linux-mips.org
> CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> CC: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> ---
>  arch/mips/mm/init.c    |    2 +-
>  arch/score/mm/init.c   |    2 +-
>  include/linux/ioport.h |    2 ++
>  kernel/resource.c      |   11 +++++++++++
>  4 files changed, 15 insertions(+), 2 deletions(-)
>
> --- linux-mm.orig/kernel/resource.c     2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/kernel/resource.c  2010-01-22 11:20:35.000000000 +0800
> @@ -327,6 +327,17 @@ int walk_system_ram_range(unsigned long
>
>  #endif
>
> +#define PAGE_IS_RAM    24
> +static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
> +{
> +       return PAGE_IS_RAM;
> +}
> +int __attribute__((weak)) page_is_ram(unsigned long pfn)
> +{
> +       return PAGE_IS_RAM == walk_system_ram_range(pfn, 1, NULL, __is_ram);
> +}
> +#undef PAGE_IS_RAM
> +

I'm not sure, but any build test for powerpc/mips/score?
walk_system_ram_range is defined when CONFIG_ARCH_HAS_WALK_MEMORY is not set.
Is it safe when CONFIG_ARCH_HAS_WALK_MEMORY is set for some powerpc archs?

>  /*
>  * Find empty slot in the resource tree given range and alignment.
>  */
> --- linux-mm.orig/include/linux/ioport.h        2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/include/linux/ioport.h     2010-01-22 11:20:35.000000000 +0800
> @@ -191,5 +191,7 @@ extern int
>  walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
>                void *arg, int (*func)(unsigned long, unsigned long, void *));
>
> +extern int page_is_ram(unsigned long pfn);
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* _LINUX_IOPORT_H */
> --- linux-mm.orig/arch/score/mm/init.c  2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/arch/score/mm/init.c       2010-01-22 11:20:35.000000000 +0800
> @@ -59,7 +59,7 @@ static unsigned long setup_zero_page(voi
>  }
>
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
> -static int __init page_is_ram(unsigned long pagenr)
> +int page_is_ram(unsigned long pagenr)
>  {
>        if (pagenr >= min_low_pfn && pagenr < max_low_pfn)
>                return 1;
> --- linux-mm.orig/arch/mips/mm/init.c   2010-01-22 11:20:34.000000000 +0800
> +++ linux-mm/arch/mips/mm/init.c        2010-01-22 11:20:35.000000000 +0800
> @@ -298,7 +298,7 @@ void __init fixrange_init(unsigned long
>  }
>
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
> -static int __init page_is_ram(unsigned long pagenr)
> +int page_is_ram(unsigned long pagenr)
>  {
>        int i;
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
