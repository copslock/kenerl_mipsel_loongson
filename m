Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 18:59:03 +0200 (CEST)
Received: from mail-it1-x141.google.com ([IPv6:2607:f8b0:4864:20::141]:39324
        "EHLO mail-it1-x141.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992891AbeIZQ67FLhwu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 18:58:59 +0200
Received: by mail-it1-x141.google.com with SMTP id w200-v6so3827836itc.4
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2018 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sk4phsQMsWm/uLqtYjyTCCVZkWmOftfD6xEiXH8xJ4U=;
        b=oHraBigdw5BEX0LUXs9GlUBIE7zHK53SIga1HWIx81sxIHv+NoQQonTbfj0UDv0Z+J
         EQSG24+ZrTq2bjXRoMcoLR9rgJsgajjfUmZPLqE2bDOYvYgnz360+UkBGbEDzcJnF0tq
         6K5wSTz3jRyehlYV6yPMPvwuOsdYapx5l6cpXY8Mkbi6V3d1SE8CtJm9K5lGwAdAUrlN
         acztf9YRzQth69K5a8XlkVNbBBuLDtkA07DrDWyTfFom8LBLIbsW7dzc+R1LcNm7lpk9
         76Exn3TO6BvTde5ueWmipdKNRWdyh+ywfJROOPd3cOVszLtHI3cLSo+bqjdR/FhrC/tH
         cEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sk4phsQMsWm/uLqtYjyTCCVZkWmOftfD6xEiXH8xJ4U=;
        b=X4ahc/y1LijquR0nXl8oyI11CIRogcQFAAWxMCD1w+9qXUH5ANswO6L+UfjzoegD48
         98WWJyVaVShpW2cuNoF805z8yTmbFH9/zr/yXan9dUjN7i6pPqmc7NegrKM23IyoeoXd
         JiR7HItvP1qr6rSdh3zKms3DSxj8fz8ZFuWmv5VXT17H6XJN56AE9wnuTZDMil9+cnyM
         YsRRqnF1GwUMR9trjVrjnBNXCrvL4Cn/yHiNLysmlitsazPcUQoJVWlBlzXe6jaf3BzM
         tzUUZOePIPdJmAxM9fauyBmSJgShaYv37FLfDIgLmEgr+F6/wTab+KsVW1LALRc0IQmn
         EBBQ==
X-Gm-Message-State: ABuFfoizD2Ad9KhKqzbal87LIIQ/C/8fKYrJ1RZ70GB6qD21MA/y199S
        3XVQCm94zgbXo9cDG6FXJGL/WDjR2r1aKBLu0RQ=
X-Google-Smtp-Source: ACcGV61r76+3aUI+rvs9VbR2N0bAv7M/QbDxsEezQCK5N1Ftrt8LN0aVWm4RPYDKt2cA/F5iz5Vl4HGEmxZqV8pRXgw=
X-Received: by 2002:a24:9a83:: with SMTP id l125-v6mr6225072ite.76.1537981132489;
 Wed, 26 Sep 2018 09:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com> <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 26 Sep 2018 09:58:41 -0700
Message-ID: <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com>
Subject: Re: [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
To:     rppt@linux.vnet.ibm.com
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, chris@zankel.net,
        David Miller <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>, green.hu@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>, gxt@pku.edu.cn,
        Ingo Molnar <mingo@redhat.com>, jejb@parisc-linux.org,
        jonas@southpole.se, Jonathan Corbet <corbet@lwn.net>,
        lftan@altera.com, msalter@redhat.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        mattst88@gmail.com, mpe@ellerman.id.au,
        Michal Hocko <mhocko@suse.com>, monstr@monstr.eu,
        palmer@sifive.com, paul.burton@mips.com, rkuo@codeaurora.org,
        richard@nod.at, dalias@libc.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        fancer.lancer@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, vgupta@synopsys.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Return-Path: <alexander.duyck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.duyck@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Sep 14, 2018 at 5:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> All architecures use memblock for early memory management. There is no need
> for the CONFIG_HAVE_MEMBLOCK configuration option.
>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

<snip>

> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 5169205..4ae91fc 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -2,7 +2,6 @@
>  #define _LINUX_MEMBLOCK_H
>  #ifdef __KERNEL__
>
> -#ifdef CONFIG_HAVE_MEMBLOCK
>  /*
>   * Logical memory blocks.
>   *
> @@ -460,7 +459,6 @@ static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
>  {
>         return 0;
>  }
> -#endif /* CONFIG_HAVE_MEMBLOCK */
>
>  #endif /* __KERNEL__ */

There was an #else above this section and I believe it and the code
after it needs to be stripped as well.
