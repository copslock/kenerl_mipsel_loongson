Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2017 23:20:33 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:33461
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993457AbdHYVU1Va0e7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2017 23:20:27 +0200
Received: by mail-wm0-x242.google.com with SMTP id e67so1001157wmd.0;
        Fri, 25 Aug 2017 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qbIGU1RVONbETkiRi5RgEzEBPHZ7SMPS9LlF2jlwdzg=;
        b=FWVNJ0dcah/jHBGdv6zVCbsd1o5tlcqG0YwyUcz9dJGacr82Gw0tmWsHPWpIh3QwRS
         fYR3+TNdrpqzLB9IYbQFnMO6iuosifWFTBADfI/F8UADd1v9JVBW3rIO3uWU48EnZxnQ
         IvBcw3qYgK+EBHTPbEbz/6x3yY0ADUzoo02yBRWy4VNzlz56Zpdj/xLJOzkuyl+l1xO6
         dJCwvnNv4bulgcwn4Ym0n+rYhpm9vmR0CRw8B9uSpaDksm2xNRFVDkfVbyyitRIsOqDC
         KQqabvH41ia1Wku7Uc9edJsxvbWrUFdqL/MSOKs6wWrsCS2quNYBJlnYornsRO+fBgGR
         nSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbIGU1RVONbETkiRi5RgEzEBPHZ7SMPS9LlF2jlwdzg=;
        b=uauqcfeJWMagQBztaueawC9r8A9rvJflZRVbBPDPScIvREVkf8PiHrj/tZBt28kjnV
         xvRox2BtSaP0TtJIttNoXiiRaX/q7/BWvQR+zi9vmvoIcQUq5+wvbiWbnrbSWFpgKrIo
         6W0AOHjVvvrHjwGHaWK7UD8sVcJS8UlBdHmKKnylV5T6QGQ76TNEtvN1KGTjtyZG/tYG
         3o7ANSeVB5d/cYDD2s3SAxXti+hRCNebi8JN2VGyeBsjYiqdaJKG8J3nJCCp2+vybz0D
         8PAmrKwm/4UvZOplh+n08XcSMGIiL+w/Wpi1FYcYwOmRBlo25UmJk0vFb1GcX5JnDD6O
         nhuw==
X-Gm-Message-State: AHYfb5hnqMShhN18uJDbp62/iEY37UUNczd//D2H5+5NmophIixOtB72
        9gEB1r4LvI/6Ag==
X-Received: by 10.28.51.200 with SMTP id z191mr308780wmz.193.1503696021903;
        Fri, 25 Aug 2017 14:20:21 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id f145sm1337830wmf.13.2017.08.25.14.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Aug 2017 14:20:21 -0700 (PDT)
Subject: Re: [PATCH 00/11] MIPS: Fix various sparse warnings
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, trivial@kernel.org
References: <20170823181754.24044-1-paul.burton@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <878b21e3-d119-e653-3875-154655f4b22f@gmail.com>
Date:   Fri, 25 Aug 2017 14:20:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823181754.24044-1-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 08/23/2017 11:17 AM, Paul Burton wrote:
> This series fixes various sparse warnings, mostly low hanging fruit.
> 
> Patches 1-7 include headers providing declarations of functions or
> variables in files which provide their definitions. This clears up
> sparse warnings & ensures that the prototypes of declarations &
> definitions match.
> 
> Patch 8 fixes the type of a fault_addr argument used in the FPU
> emulation code to be correct & avoid a lot of sparse warnings.
> 
> Patches 9 & 10 remove some dead code.
> 
> Patch 11 declares a bunch of things which we don't use outside of the
> translation unit that defines them static.
> 
> Applies atop v4.13-rc6.

FWIW:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> Paul Burton (11):
>   MIPS: generic: Include asm/bootinfo.h for plat_fdt_relocated()
>   MIPS: generic: Include asm/time.h for get_c0_*_int()
>   MIPS: Include asm/setup.h for cpu_cache_init()
>   MIPS: Include linux/cpu.h for arch_cpu_idle()
>   MIPS: Include asm/delay.h for __{,n,u}delay()
>   MIPS: Include elf-randomize.h for arch_mmap_rnd() &
>     arch_randomize_brk()
>   MIPS: Include linux/initrd.h for free_initrd_mem()
>   MIPS: math-emu: Correct user fault_addr type
>   MIPS: Remove __invalidate_kernel_vmap_range
>   MIPS: Remove plat_timer_setup()
>   MIPS: Declare various variables & functions static
> 
>  arch/mips/generic/init.c              |  5 +++++
>  arch/mips/generic/irq.c               |  1 +
>  arch/mips/include/asm/fpu_emulator.h  |  2 +-
>  arch/mips/kernel/cpu-probe.c          |  2 +-
>  arch/mips/kernel/idle.c               |  1 +
>  arch/mips/kernel/mips-r2-to-r6-emul.c |  6 +++---
>  arch/mips/kernel/pm-cps.c             |  2 +-
>  arch/mips/kernel/time.c               | 14 --------------
>  arch/mips/kernel/unaligned.c          |  2 +-
>  arch/mips/lib/delay.c                 |  1 +
>  arch/mips/math-emu/cp1emu.c           |  8 ++++----
>  arch/mips/mm/cache.c                  |  2 +-
>  arch/mips/mm/dma-default.c            |  4 ++--
>  arch/mips/mm/init.c                   |  1 +
>  arch/mips/mm/mmap.c                   |  1 +
>  15 files changed, 24 insertions(+), 28 deletions(-)
> 


-- 
Florian
