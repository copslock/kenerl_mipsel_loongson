Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Apr 2018 00:51:40 +0200 (CEST)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:35566
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990418AbeDTWveLMyL- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Apr 2018 00:51:34 +0200
Received: by mail-qk0-x242.google.com with SMTP id b131so6024267qkg.2;
        Fri, 20 Apr 2018 15:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=35o9di8S5zWUmDY8dj/xDgMD1QcG3gkwuWeoTI80AqQ=;
        b=aSt4bL1TlbJIfDd0OGK+lORF77/vgro4JI8IcX8DSofUTzA1eA4VlCeSDWJJsnzCQa
         9dWF2H7wEBVSmr4lTmtm2T5zVax5EAdpVV30Fai06YJZh1vNhlgGYm7tzkz4OM5EXJqf
         CLrFzNeYirtQME15a0z4VPZIP4WnpoY76OVpib+yVX0tigV+LhQz/5bjVbB84yLq8QKq
         sWUUkQLYDeTPdC2pEA9GHNoVPsE+LWX+mye2afzz+pxj9MftyNf74RwBvLFpxRR9AsJn
         QBiWyjN3KNbOX9f7RyJmIn99HKBOcNHrbWHtPqy4iHSI2sPfNbvv3CheUr3i70CMtGq+
         E1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=35o9di8S5zWUmDY8dj/xDgMD1QcG3gkwuWeoTI80AqQ=;
        b=mjD7nENfCHGoyHaeAK9Pek/WRbce+EyoKoD6H7dPl0ks6QUgSQx5dMuLwAiB6jSbFD
         J0mmbCxhdB0HBDxXFYdIa1PEev8il5WQoQcYwwizdmdZPU3GKgNYKkxua6stwynGuhDZ
         VX8i6NXXxJAO6Zlr4RqPSFeVjKBp2EyV26SJn2gxvYJJq6kkBDZ2KTibeaTwGnJa6wjT
         nUiEosclHMgplLK5eTFLxpbSjqJCgF2Er1Q7e0BmQ+FdLKL4x2OtwqMdIyV9TZwTR1wg
         +U5wvXVL9QlpLoHmMGBCOJrGZLbQmj1RzqCTFWmqpBTRlR4Es0Usf3ZQ5E6IzsYE+LY8
         MtFQ==
X-Gm-Message-State: ALQs6tCDNQj2Q2ByxKdULfyTFxM/3iAGOyT/GydcgP1/dcjc6qX/exic
        LfWN+spanEe7HOPXHVqhyuI=
X-Google-Smtp-Source: AB8JxZor5D0iBIqI+8jBGCYU3kSL93bKb6Rk3LZ32nJsT/V5/9WohknmqlnIyUaknURUQJXNRYJhHQ==
X-Received: by 10.55.6.145 with SMTP id 139mr12148993qkg.232.1524264687684;
        Fri, 20 Apr 2018 15:51:27 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id i45-v6sm1222372qta.12.2018.04.20.15.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 15:51:26 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] MIPS: perf: MT fixes and improvements
To:     Matt Redfearn <matt.redfearn@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Peter Zijlstra <peterz@infradead.org>,
        oprofile-list@lists.sf.net, Huacai Chen <chenhc@lemote.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <c3ee1ba4-3458-33a7-4c1f-700936a57bfa@gmail.com>
Date:   Fri, 20 Apr 2018 15:51:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63649
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

On 04/20/2018 03:23 AM, Matt Redfearn wrote:
> This series addresses a few issues with how the MIPS performance
> counters code supports the hardware multithreading MT ASE.
> 
> Firstly, implementations of the MT ASE may implement performance
> counters
> per core or per thread(TC). MIPS Techologies implementations signal this
> via a bit in the implmentation specific CONFIG7 register. Since this
> register is implementation specific, checking it should be guarded by a
> PRID check. This also replaces a bit defined by a magic number.
> 
> Secondly, the code currently uses vpe_id(), defined as
> smp_processor_id(), divided by 2, to share core performance counters
> between VPEs. This relies on a couple of assumptions of the hardware
> implementation to function correctly (always 2 VPEs per core, and the
> hardware reading only the least significant bit).
> 
> Finally, the method of sharing core performance counters between VPEs is
> suboptimal since it does not allow one process running on a VPE to use
> all of the performance counters available to it, because the kernel will
> reserve half of the coutners for the other VPE even if it may never use
> them. This reservation at counter probe is replaced with an allocation
> on use strategy.
> 
> Tested on a MIPS Creator CI40 (2C2T MIPS InterAptiv with per-TC
> counters, though for the purposes of testing the per-TC availability was
> hardcoded to allow testing both paths).
> 
> Series applies to v4.16

Sorry it took so long to get that tested.

Sounds like you need to build test this on a BMIPS5000 configuration
(bmips_stb_defconfig should provide that):

In file included from ./arch/mips/include/asm/mach-generic/spaces.h:15:0,
                 from ./arch/mips/include/asm/mach-bmips/spaces.h:16,
                 from ./arch/mips/include/asm/addrspace.h:13,
                 from ./arch/mips/include/asm/barrier.h:11,
                 from ./include/linux/compiler.h:245,
                 from ./include/linux/kernel.h:10,
                 from ./include/linux/cpumask.h:10,
                 from arch/mips/kernel/perf_event_mipsxx.c:18:
arch/mips/kernel/perf_event_mipsxx.c: In function 'mipsxx_pmu_enable_event':
./arch/mips/include/asm/mipsregs.h:738:52: error: suggest parentheses
around '+' in operand of '&' [-Werror=parentheses]
 #define BRCM_PERFCTRL_VPEID(v) (_ULCAST_(1) << (12 + v))

arch/mips/kernel/perf_event_mipsxx.c:385:10: note: in expansion of macro
'BRCM_PERFCTRL_VPEID'
   ctrl = BRCM_PERFCTRL_VPEID(cpu & MIPS_CPUID_TO_COUNTER_MASK);
          ^~~~~~~~~~~~~~~~~~~
  CC      drivers/of/fdt_addres

after fixing that, I tried the following to see whether this would be a
good test case to exercise against:

perf record -a -C 0 taskset -c 1 /bin/true
perf record -a -C 1 taskset -c 0 /bin/true

and would not see anything related to /bin/true running in either case,
which seems like it does the right thing?

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

BTW, for some reason not specifying -a -C <cpu> does lead to lockups,
consistently and for pretty much any perf command, this could be BMIPS
specific, did not get a chance to cross test on a different machine.

> 
> 
> Changes in v3:
> New patch to detect feature presence in cpu-probe.c
> Use flag in cpu_data set by cpu_probe.c to indicate feature presence.
> - rebase on new feature detection
> 
> Changes in v2:
> Fix mipsxx_pmu_enable_event for !#ifdef CONFIG_MIPS_MT_SMP
> - Fix !#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS build
> - re-use cpuc variable in mipsxx_pmu_alloc_counter,
>   mipsxx_pmu_free_counter rather than having sibling_ version.
> Since BMIPS5000 does not implement per TC counters, we can remove the
> check on cpu_has_mipsmt_pertccounters.
> New patch to fix BMIPS5000 system mode perf.
> 
> Matt Redfearn (7):
>   MIPS: Probe for MIPS MT perf counters per TC
>   MIPS: perf: More robustly probe for the presence of per-tc counters
>   MIPS: perf: Use correct VPE ID when setting up VPE tracing
>   MIPS: perf: Fix perf with MT counting other threads
>   MIPS: perf: Allocate per-core counters on demand
>   MIPS: perf: Fold vpe_id() macro into it's one last usage
>   MIPS: perf: Fix BMIPS5000 system mode counting
> 
>  arch/mips/include/asm/cpu-features.h |   7 ++
>  arch/mips/include/asm/cpu.h          |   2 +
>  arch/mips/include/asm/mipsregs.h     |   6 +
>  arch/mips/kernel/cpu-probe.c         |  12 ++
>  arch/mips/kernel/perf_event_mipsxx.c | 232 +++++++++++++++++++----------------
>  arch/mips/oprofile/op_model_mipsxx.c |   2 -
>  6 files changed, 150 insertions(+), 111 deletions(-)
> 


-- 
Florian
