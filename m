Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jul 2013 13:36:27 +0200 (CEST)
Received: from mail-wg0-f53.google.com ([74.125.82.53]:38331 "EHLO
        mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816822Ab3GSLgWacqMU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jul 2013 13:36:22 +0200
Received: by mail-wg0-f53.google.com with SMTP id y10so3866941wgg.8
        for <multiple recipients>; Fri, 19 Jul 2013 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=kJ2Y/S5S7AHnlHGK8tAJ/0OanKF1ZjC7GrFTcuEm3gQ=;
        b=0Ri8pgg1AlyDq3NEPgSvtxecWYGu51uHbra7nn3NgozegARjJAthKCy23avkRsAgrt
         hfI/s/2NQ9qILFwqOJ6YseVmy3owGWNvoGnSyPo8PYAuvNM/OiKzanFm8q1WnCs+RZr6
         BT9wqzXb0y5bFgPIfD7PfQE0ZQKkxbx5fj4JOubvkZ7dKhY0+RfoCj8ptTAIOn7/OBwm
         uwaxBjVsWmH2xktjkL0hX0uWpXEj4AtKc2E9hFaOOGdX82nR7N0T5QX+J2zKYivkLFWx
         j7/tg/+1C3xZkuFZrtRKej46P81wNXiCRYwXmy/WPSQzUd4zB9kOwh1OLbx1CpcS1Qvn
         IZfQ==
X-Received: by 10.194.8.72 with SMTP id p8mr11957323wja.71.1374233776837; Fri,
 19 Jul 2013 04:36:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.163.138 with HTTP; Fri, 19 Jul 2013 04:35:36 -0700 (PDT)
In-Reply-To: <20130719182611.41aeb79b5711b3c9f849d594@linux-mips.org>
References: <20130719182611.41aeb79b5711b3c9f849d594@linux-mips.org>
From:   Markos Chandras <hwoarang@gentoo.org>
Date:   Fri, 19 Jul 2013 12:35:36 +0100
X-Google-Sender-Auth: 9YN29yFa3EcTX5ZDlFDrJqEC8Xw
Message-ID: <CAG2jQ8hCwqtrw=Av6ZG2h19Z_HRuDmPn+LqpSJyQGhUSM=8=Pg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ar7: fix redefined UNCAC_BASE and IO_BASE
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <markos.chandras@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hwoarang@gentoo.org
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

On 19 July 2013 10:26, Yoichi Yuasa <yuasa@linux-mips.org> wrote:
> In file included from arch/mips/include/asm/mach-ar7/spaces.h:23:0,
>                  from arch/mips/include/asm/addrspace.h:13,
>                  from arch/mips/include/asm/barrier.h:11,
>                  from arch/mips/include/asm/bitops.h:18,
>                  from include/linux/bitops.h:22,
>                  from include/linux/kernel.h:10,
>                  from include/asm-generic/bug.h:13,
>                  from arch/mips/include/asm/bug.h:41,
>                  from include/linux/bug.h:4,
>                  from include/linux/page-flags.h:9,
>                  from kernel/bounds.c:9:
> arch/mips/include/asm/mach-generic/spaces.h:28:0: warning: "IO_BASE" redefined [enabled by default]
> In file included from arch/mips/include/asm/addrspace.h:13:0,
>                  from arch/mips/include/asm/barrier.h:11,
>                  from arch/mips/include/asm/bitops.h:18,
>                  from include/linux/bitops.h:22,
>                  from include/linux/kernel.h:10,
>                  from include/asm-generic/bug.h:13,
>                  from arch/mips/include/asm/bug.h:41,
>                  from include/linux/bug.h:4,
>                  from include/linux/page-flags.h:9,
>                  from kernel/bounds.c:9:
> arch/mips/include/asm/mach-ar7/spaces.h:21:0: note: this is the location of the previous definition
> In file included from arch/mips/include/asm/mach-ar7/spaces.h:23:0,
>                  from arch/mips/include/asm/addrspace.h:13,
>                  from arch/mips/include/asm/barrier.h:11,
>                  from arch/mips/include/asm/bitops.h:18,
>                  from include/linux/bitops.h:22,
>                  from include/linux/kernel.h:10,
>                  from include/asm-generic/bug.h:13,
>                  from arch/mips/include/asm/bug.h:41,
>                  from include/linux/bug.h:4,
>                  from include/linux/page-flags.h:9,
>                  from kernel/bounds.c:9:
> arch/mips/include/asm/mach-generic/spaces.h:29:0: warning: "UNCAC_BASE" redefined [enabled by default]
> In file included from arch/mips/include/asm/addrspace.h:13:0,
>                  from arch/mips/include/asm/barrier.h:11,
>                  from arch/mips/include/asm/bitops.h:18,
>                  from include/linux/bitops.h:22,
>                  from include/linux/kernel.h:10,
>                  from include/asm-generic/bug.h:13,
>                  from arch/mips/include/asm/bug.h:41,
>                  from include/linux/bug.h:4,
>                  from include/linux/page-flags.h:9,
>                  from kernel/bounds.c:9:
> arch/mips/include/asm/mach-ar7/spaces.h:20:0: note: this is the location of the previous definition
> In file included from arch/mips/include/asm/mach-ar7/spaces.h:23:0,
>
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/mips/include/asm/mach-generic/spaces.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
> index 5b2f2e6..c5d12b4 100644
> --- a/arch/mips/include/asm/mach-generic/spaces.h
> +++ b/arch/mips/include/asm/mach-generic/spaces.h
> @@ -20,13 +20,22 @@
>  #endif
>
>  #ifdef CONFIG_32BIT
> +
> +#ifndef CAC_BASE
>  #ifdef CONFIG_KVM_GUEST
>  #define CAC_BASE               _AC(0x40000000, UL)
>  #else
>  #define CAC_BASE               _AC(0x80000000, UL)
>  #endif
> +#endif
> +
> +#ifndef IO_BASE
>  #define IO_BASE                        _AC(0xa0000000, UL)
> +#endif
> +
> +#ifndef UNCAC_BASE
>  #define UNCAC_BASE             _AC(0xa0000000, UL)
> +#endif
>
>  #ifndef MAP_BASE
>  #ifdef CONFIG_KVM_GUEST
> --
> 1.7.9.5
>
>

Hi,

Isn't this similar to http://patchwork.linux-mips.org/patch/5583/ ?

--
Regards,
Markos Chandras - Gentoo Linux Developer
http://dev.gentoo.org/~hwoarang
