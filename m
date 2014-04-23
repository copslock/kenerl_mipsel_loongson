Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 13:40:27 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56955 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819447AbaDWLkYRLcDe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 13:40:24 +0200
Received: by mail-oa0-f49.google.com with SMTP id o6so854275oag.36
        for <linux-mips@linux-mips.org>; Wed, 23 Apr 2014 04:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lwcWICQ9q/8CuOrhGjwJd8k7fotcD3hI1QPtKdpRkMI=;
        b=fi4KCVUzUDjPNrM56hWjfd1SaECM3nrbjZpdajXUB6RxuQ1iX8sXCOgNaMnrQIZHUo
         rUGYYZeoJ6USWojngGSGAWaSnhsL5o3r5+yHloqRO2FCRI70eSAxTzskbVVy5KaDfJgA
         OkqXzyyhnTw9T7KsxLCuW1XdOctWKckITvuPehUvlqW8Adtrqol/QgEPvC8/gGHx5g/A
         W8WsbEDkHItLMS8/h/Rtat+2HjflaTHQE7BwQDBA3QnPA34zSvx17STetqfJKPeuKBED
         QiZkw05N/Zv9ERHGQpIavaG+8EXTxwRlq+CH6v+FtHUm+4LSukVJL+FhvnrXIWz/KmtB
         OBiQ==
X-Gm-Message-State: ALoCoQnd2PYAV0xG3FGvBPV7KeOPFcHHNNRK9focBCC9IyDEqLovijp7YDc/o+6ClrM2m6AFOMJT
MIME-Version: 1.0
X-Received: by 10.182.126.137 with SMTP id my9mr1443042obb.61.1398253216006;
 Wed, 23 Apr 2014 04:40:16 -0700 (PDT)
Received: by 10.76.124.165 with HTTP; Wed, 23 Apr 2014 04:40:15 -0700 (PDT)
X-Originating-IP: [217.156.156.35]
In-Reply-To: <1397211951-20549-8-git-send-email-miklos@szeredi.hu>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
        <1397211951-20549-8-git-send-email-miklos@szeredi.hu>
Date:   Wed, 23 Apr 2014 12:40:15 +0100
Message-ID: <CAAG0J9-jgw5FVrOnqnTwVdK8XxbTZx6X2zvjWXjXiELeEuFQ9w@mail.gmail.com>
Subject: Re: [PATCH 07/15] mips: add renameat2 syscall
From:   James Hogan <james@albanarts.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james@albanarts.com
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

(cc'ing linux-mips list)

On 11 April 2014 11:25, Miklos Szeredi <miklos@szeredi.hu> wrote:
> From: Miklos Szeredi <mszeredi@suse.cz>
>
> Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Identical to the patch I just sent to linux-mips, so:
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
>  arch/mips/kernel/scall32-o32.S      |  1 +
>  arch/mips/kernel/scall64-64.S       |  1 +
>  arch/mips/kernel/scall64-n32.S      |  1 +
>  arch/mips/kernel/scall64-o32.S      |  1 +
>  5 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
> index d6e154a9e6a5..5805414777e0 100644
> --- a/arch/mips/include/uapi/asm/unistd.h
> +++ b/arch/mips/include/uapi/asm/unistd.h
> @@ -371,16 +371,17 @@
>  #define __NR_finit_module              (__NR_Linux + 348)
>  #define __NR_sched_setattr             (__NR_Linux + 349)
>  #define __NR_sched_getattr             (__NR_Linux + 350)
> +#define __NR_renameat2                 (__NR_Linux + 351)
>
>  /*
>   * Offset of the last Linux o32 flavoured syscall
>   */
> -#define __NR_Linux_syscalls            350
> +#define __NR_Linux_syscalls            351
>
>  #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
>
>  #define __NR_O32_Linux                 4000
> -#define __NR_O32_Linux_syscalls                350
> +#define __NR_O32_Linux_syscalls                351
>
>  #if _MIPS_SIM == _MIPS_SIM_ABI64
>
> @@ -699,16 +700,17 @@
>  #define __NR_getdents64                        (__NR_Linux + 308)
>  #define __NR_sched_setattr             (__NR_Linux + 309)
>  #define __NR_sched_getattr             (__NR_Linux + 310)
> +#define __NR_renameat2                 (__NR_Linux + 311)
>
>  /*
>   * Offset of the last Linux 64-bit flavoured syscall
>   */
> -#define __NR_Linux_syscalls            310
> +#define __NR_Linux_syscalls            311
>
>  #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
>
>  #define __NR_64_Linux                  5000
> -#define __NR_64_Linux_syscalls         310
> +#define __NR_64_Linux_syscalls         311
>
>  #if _MIPS_SIM == _MIPS_SIM_NABI32
>
> @@ -1031,15 +1033,16 @@
>  #define __NR_finit_module              (__NR_Linux + 312)
>  #define __NR_sched_setattr             (__NR_Linux + 313)
>  #define __NR_sched_getattr             (__NR_Linux + 314)
> +#define __NR_renameat2                 (__NR_Linux + 315)
>
>  /*
>   * Offset of the last N32 flavoured syscall
>   */
> -#define __NR_Linux_syscalls            314
> +#define __NR_Linux_syscalls            315
>
>  #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
>
>  #define __NR_N32_Linux                 6000
> -#define __NR_N32_Linux_syscalls                314
> +#define __NR_N32_Linux_syscalls                315
>
>  #endif /* _UAPI_ASM_UNISTD_H */
> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> index fdc70b400442..3245474f19d5 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -577,3 +577,4 @@ EXPORT(sys_call_table)
>         PTR     sys_finit_module
>         PTR     sys_sched_setattr
>         PTR     sys_sched_getattr               /* 4350 */
> +       PTR     sys_renameat2
> diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
> index dd99c3285aea..be2fedd4ae33 100644
> --- a/arch/mips/kernel/scall64-64.S
> +++ b/arch/mips/kernel/scall64-64.S
> @@ -430,4 +430,5 @@ EXPORT(sys_call_table)
>         PTR     sys_getdents64
>         PTR     sys_sched_setattr
>         PTR     sys_sched_getattr               /* 5310 */
> +       PTR     sys_renameat2
>         .size   sys_call_table,.-sys_call_table
> diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
> index f68d2f4f0090..c1dbcda4b816 100644
> --- a/arch/mips/kernel/scall64-n32.S
> +++ b/arch/mips/kernel/scall64-n32.S
> @@ -423,4 +423,5 @@ EXPORT(sysn32_call_table)
>         PTR     sys_finit_module
>         PTR     sys_sched_setattr
>         PTR     sys_sched_getattr
> +       PTR     sys_renameat2                   /* 6315 */
>         .size   sysn32_call_table,.-sysn32_call_table
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
> index 70f6acecd928..f1343ccd7ed7 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -556,4 +556,5 @@ EXPORT(sys32_call_table)
>         PTR     sys_finit_module
>         PTR     sys_sched_setattr
>         PTR     sys_sched_getattr               /* 4350 */
> +       PTR     sys_renameat2
>         .size   sys32_call_table,.-sys32_call_table
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
James Hogan
