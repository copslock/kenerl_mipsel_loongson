Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 20:35:22 +0100 (CET)
Received: from mail-qg0-f44.google.com ([209.85.192.44]:38654 "EHLO
        mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011712AbbASTfUwZdog (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 20:35:20 +0100
Received: by mail-qg0-f44.google.com with SMTP id l89so17673679qgf.3;
        Mon, 19 Jan 2015 11:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HGS28UkgutZeUdkMVLL22h4BMLbvMmpEbUNBB3GsE5E=;
        b=QeLcUJ5LwZD2VUV+RdHz+YR+Y/SHeOl/ShtD399p3jGbx8YbOkovhg9y/KZ3fU4qbQ
         nu0mqEhXepyX8lCfhAtKInyUOM9VvlIhJZRD6IY0x2DUGjmqPOthhcKZD1yC7IbkiLgf
         Mcp4oQVxNZi0vqtNGER/adZdrmNqBuJBs+/V0qPEpPAPdeSRxj0FZP0693f0Wga8/mpW
         2R9eGIHpFMFrBMO1XdYNigukTGTMAiW3na4X1HG/hcD/z49tojN9ZVYMCa7KBXjaTU8x
         CPwXamOxB98NI0YEsCWYjKGUsnAtAG6cO8g9eIJbgLMkk1aqJ3H71KCQDBPOb0Rqf6GF
         DhIQ==
X-Received: by 10.140.89.177 with SMTP id v46mr19969157qgd.58.1421696111769;
 Mon, 19 Jan 2015 11:35:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.188.138 with HTTP; Mon, 19 Jan 2015 11:34:51 -0800 (PST)
In-Reply-To: <54BC5E43.8060606@gentoo.org>
References: <54BC5E43.8060606@gentoo.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 19 Jan 2015 11:34:51 -0800
Message-ID: <CAEdQ38H=bHCYm21LrA=EoENRj8jwKU2jk3u36s+hqfzU0VYQSQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add R16000 detection
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Sun, Jan 18, 2015 at 5:30 PM, Joshua Kinard <kumba@gentoo.org> wrote:
> From: Joshua Kinard <kumba@gentoo.org>
>
> This allows the kernel to correctly detect an R16000 MIPS CPU on systems that
> have those.  Otherwise, such systems will detect the CPU as an R14000, due to
> similarities in the CPU PRId value.
>
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/include/asm/cpu-type.h     |    1 +
>  arch/mips/include/asm/cpu.h          |    6 +++---
>  arch/mips/kernel/cpu-probe.c         |    9 +++++++--
>  arch/mips/kernel/perf_event_mipsxx.c |    1 +
>  arch/mips/mm/c-r4k.c                 |    4 ++++
>  arch/mips/mm/page.c                  |    1 +
>  arch/mips/mm/tlb-r4k.c               |    3 ++-
>  arch/mips/mm/tlbex.c                 |    1 +
>  arch/mips/oprofile/common.c          |    1 +
>  arch/mips/oprofile/op_model_mipsxx.c |    1 +
>  10 files changed, 22 insertions(+), 6 deletions(-)
>
> linux-mips-add-r16000-detection.patch
> diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
> index b4e2bd8..d85fc26 100644
> --- a/arch/mips/include/asm/cpu-type.h
> +++ b/arch/mips/include/asm/cpu-type.h
> @@ -150,6 +150,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
>         case CPU_R10000:
>         case CPU_R12000:
>         case CPU_R14000:
> +       case CPU_R16000:
>  #endif
>  #ifdef CONFIG_SYS_HAS_CPU_RM7000
>         case CPU_RM7000:
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 33866fc..53acfce 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -67,7 +67,7 @@
>  #define PRID_IMP_R4300         0x0b00
>  #define PRID_IMP_VR41XX                0x0c00
>  #define PRID_IMP_R12000                0x0e00
> -#define PRID_IMP_R14000                0x0f00
> +#define PRID_IMP_R14000                0x0f00          /* R14K && R16K */
>  #define PRID_IMP_R8000         0x1000
>  #define PRID_IMP_PR4450                0x1200
>  #define PRID_IMP_R4600         0x2000
> @@ -283,8 +283,8 @@ enum cpu_type_enum {
>         CPU_R4000PC, CPU_R4000SC, CPU_R4000MC, CPU_R4200, CPU_R4300, CPU_R4310,
>         CPU_R4400PC, CPU_R4400SC, CPU_R4400MC, CPU_R4600, CPU_R4640, CPU_R4650,
>         CPU_R4700, CPU_R5000, CPU_R5500, CPU_NEVADA, CPU_R5432, CPU_R10000,
> -       CPU_R12000, CPU_R14000, CPU_VR41XX, CPU_VR4111, CPU_VR4121, CPU_VR4122,
> -       CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
> +       CPU_R12000, CPU_R14000, CPU_R16000, CPU_VR41XX, CPU_VR4111, CPU_VR4121,
> +       CPU_VR4122, CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
>         CPU_SR71000, CPU_TX49XX,
>
>         /*
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 5342674..3f334a8 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -833,8 +833,13 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>                 c->tlbsize = 64;
>                 break;
>         case PRID_IMP_R14000:
> -               c->cputype = CPU_R14000;
> -               __cpu_name[cpu] = "R14000";
> +               if (((c->processor_id >> 4) & 0x0f) > 2) {
> +                       c->cputype = CPU_R16000;
> +                       __cpu_name[cpu] = "R16000";
> +               } else {
> +                       c->cputype = CPU_R14000;
> +                       __cpu_name[cpu] = "R14000";
> +               }

It looks like this is the only hunk that has a functional change, and
that is simply setting __cpu_name[cpu] to "R16000"

You can do that without adding CPU_R16000 to the enumeration. I don't
see that adding it accomplishes anything.
