Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2012 11:31:04 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:50667 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903878Ab2BCKa6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2012 11:30:58 +0100
Received: by bke5 with SMTP id 5so3712740bke.36
        for <multiple recipients>; Fri, 03 Feb 2012 02:30:52 -0800 (PST)
Received: by 10.204.136.220 with SMTP id s28mr3154982bkt.59.1328265052467;
        Fri, 03 Feb 2012 02:30:52 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-86-184.pppoe.mtu-net.ru. [91.79.86.184])
        by mx.google.com with ESMTPS id bw9sm15575186bkb.8.2012.02.03.02.30.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 02:30:51 -0800 (PST)
Message-ID: <4F2BB715.8090803@mvista.com>
Date:   Fri, 03 Feb 2012 14:29:41 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
MIME-Version: 1.0
To:     Cong Wang <xiyou.wangcong@gmail.com>
CC:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Hillf Danton <dhillf@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [Patch] mips: do not redefine BUILD_BUG()
References: <1328255503-17575-1-git-send-email-xiyou.wangcong@gmail.com>
In-Reply-To: <1328255503-17575-1-git-send-email-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 03-02-2012 11:51, Cong Wang wrote:

> On mips, we got

> include/linux/kernel.h:717:1: error: "BUILD_BUG" redefined
> arch/mips/include/asm/page.h:43:1: error: this is the location of the previous definition
> make[3]: *** [arch/mips/sgi-ip27/ip27-console.o] Error 1
> make[2]: *** [arch/mips/sgi-ip27] Error 2
> make[1]: *** [arch/mips] Error 2
> make: *** [sub-make] Error 2

> use generic BUILD_BUG() instead of re-defining one.

> Signed-off-by: WANG Cong<xiyou.wangcong@gmail.com>

> ---
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index d417909..e14121a 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -39,9 +39,7 @@
>   #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
>   #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
>   #else /* !CONFIG_HUGETLB_PAGE */
> -# ifndef BUILD_BUG

    Not clear why we get the error if we're protected with #ifndef...

> -#  define BUILD_BUG() do { extern void __build_bug(void); __build_bug(); } while (0)
> -# endif
> +#include<linux/kernel.h>

    Do not do #include among the #define's...

>   #define HPAGE_SHIFT	({BUILD_BUG(); 0; })
>   #define HPAGE_SIZE	({BUILD_BUG(); 0; })
>   #define HPAGE_MASK	({BUILD_BUG(); 0; })

WBR, Sergei
