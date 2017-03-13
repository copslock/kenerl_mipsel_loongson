Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 18:09:13 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:36557
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993974AbdCMRJGY2dXI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 18:09:06 +0100
Received: by mail-qt0-x244.google.com with SMTP id n37so6994054qtb.3;
        Mon, 13 Mar 2017 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0Di68Hgyu33pfpKKWeLrgH2ZFfbX+q3VoVrTUFhdSCY=;
        b=FeElQy1pCXe64JjgsNYXpwbrqUK/ll53HZth+yWmog4ifhqx/oLE7P6OWWbEwsTIwt
         hjtpXrNgUM9kilhc/uS5uvt3nU0h/3Hk4RQQJkYuxzXuuWzrws1GLVhGHpy8pDhp4sdY
         4q8t8YBOEBVobpvXp97f2eMcrFg2a/u3BIZe46Pcy3U55osSirlwJRWycWw9EO1TlKCl
         zJOTOGY8MIIF7GVDE4gJ0Bjye/kJtd89e1sRHYlAdeGVTIjlbnNidneaq4uhxG1Uit6B
         LhhnPOXNoug2xlLucpxvmYWgviJ7NiGdP2tkMcbwrYSv/tN1q8WGpDwHGu/tLgb6QaNV
         PyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0Di68Hgyu33pfpKKWeLrgH2ZFfbX+q3VoVrTUFhdSCY=;
        b=n1Yx4ud+p0x8U/rWl+M5mNKqUxknvCEzeKEfere1YnWM5lqg5h+l2FyXnzebF5Te6I
         oa/XLFATFGZjqDEz4Ajve6W/8fbhYzQfY9+Z6CyhrmHSIOCZkUeqYM0SgD3guQOy7/xd
         t3FaJW9LCL3XxY2KmDBz7GLxtSHHmeWPvNbasEzBRATUOVBiHoZQueBvcvoHI3lr82dR
         rto4JMzA6WSNQgnZiS0I+dCKMZkyhZ0ZRbcKQcS8UWkWM1uxMhAQlIXEGCBlvk5ajAFV
         jpZvAknQ0+D3r5LiDDs1VzpVnrIn3tVNy3WjOQzu9xzM2tLt1HMA8ENcoT8FpDsy7AuN
         5YzQ==
X-Gm-Message-State: AMke39mHmPhu6l8yXhMFJGC++NqZoxJv1NSK7+2jCCN18Q6yP/S0X5BWh78k5dhRTDX5nA==
X-Received: by 10.237.37.41 with SMTP id v38mr33302864qtc.24.1489424940284;
        Mon, 13 Mar 2017 10:09:00 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id 143sm12546861qki.59.2017.03.13.10.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 10:08:59 -0700 (PDT)
Subject: Re: [PATCH 0/2] cpu-features.h rename
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        ralf@linux-mips.org
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
Cc:     linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
Date:   Mon, 13 Mar 2017 10:08:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57159
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

On 03/13/2017 06:33 AM, Marcin Nowakowski wrote:
> Since the introduction of GENERIC_CPU_AUTOPROBE
> (https://patchwork.linux-mips.org/patch/15395/) we've got 2 very similarily
> named headers: cpu-features.h and cpufeature.h.
> Since the latter is used by all platforms that implement
> GENERIC_CPU_AUTOPROBE functionality, it's better to rename the MIPS-specific
> cpu-features.h.
> 
> Marcin Nowakowski (2):
>   MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h
>   MIPS: rename cpu-features.h -> cpucaps.h

That's a lot of churn that could cause some good headaches in
backporting stable changes affecting cpu-feature-overrides.h.

Can we just do the cpu-features.h -> cpucaps.h rename and keep
cpu-feature-overrides.h around?

> 
>  arch/mips/dec/setup.c                                             | 2 +-
>  arch/mips/dec/time.c                                              | 2 +-
>  arch/mips/include/asm/atomic.h                                    | 2 +-
>  arch/mips/include/asm/bitops.h                                    | 2 +-
>  arch/mips/include/asm/branch.h                                    | 2 +-
>  arch/mips/include/asm/cacheflush.h                                | 2 +-
>  arch/mips/include/asm/{cpu-features.h => cpucaps.h}               | 8 ++++----
>  arch/mips/include/asm/dsp.h                                       | 2 +-
>  arch/mips/include/asm/fpu.h                                       | 2 +-
>  arch/mips/include/asm/highmem.h                                   | 2 +-
>  arch/mips/include/asm/io.h                                        | 2 +-
>  .../mach-ath25/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 8 ++++----
>  .../mach-ath79/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 8 ++++----
>  .../mach-au1x00/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
>  .../mach-bcm47xx/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
>  .../mach-bcm63xx/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
>  .../mach-bmips/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 4 ++--
>  .../mach-cobalt/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
>  .../asm/mach-dec/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
>  .../mach-generic/{cpu-feature-overrides.h => cpucaps-overrides.h} | 6 +++---
>  .../mach-ip22/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
>  .../mach-ip27/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
>  .../mach-ip28/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
>  .../mach-ip32/{cpu-feature-overrides.h => cpucaps-overrides.h}    | 6 +++---
>  .../mach-jz4740/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 4 ++--
>  .../falcon/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
>  .../mach-malta/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
>  .../mach-pic32/{cpu-feature-overrides.h => cpucaps-overrides.h}   | 6 +++---
>  .../{cpu-feature-overrides.h => cpucaps-overrides.h}              | 6 +++---
>  .../mt7620/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>  .../mt7621/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>  .../rt288x/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>  .../rt305x/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>  .../rt3883/{cpu-feature-overrides.h => cpucaps-overrides.h}       | 8 ++++----
>  .../mach-rc32434/{cpu-feature-overrides.h => cpucaps-overrides.h} | 8 ++++----
>  .../asm/mach-rm/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 8 +++-----
>  .../mach-sibyte/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
>  .../mach-tx49xx/{cpu-feature-overrides.h => cpucaps-overrides.h}  | 6 +++---
>  arch/mips/include/asm/r4kcache.h                                  | 2 +-
>  arch/mips/include/asm/switch_to.h                                 | 2 +-
>  arch/mips/include/asm/timex.h                                     | 2 +-
>  arch/mips/include/asm/tlb.h                                       | 2 +-
>  arch/mips/kernel/branch.c                                         | 2 +-
>  arch/mips/kernel/cpu-probe.c                                      | 2 +-
>  arch/mips/kernel/elf.c                                            | 2 +-
>  arch/mips/kernel/proc.c                                           | 2 +-
>  arch/mips/kernel/signal.c                                         | 2 +-
>  arch/mips/kernel/signal_n32.c                                     | 2 +-
>  arch/mips/kernel/smp-bmips.c                                      | 2 +-
>  arch/mips/kernel/sysrq.c                                          | 2 +-
>  arch/mips/kernel/time.c                                           | 2 +-
>  arch/mips/kernel/uprobes.c                                        | 2 +-
>  arch/mips/mm/c-octeon.c                                           | 2 +-
>  arch/mips/mm/c-r4k.c                                              | 2 +-
>  arch/mips/mm/cache.c                                              | 2 +-
>  arch/mips/mm/gup.c                                                | 2 +-
>  arch/mips/net/bpf_jit.c                                           | 2 +-
>  arch/mips/netlogic/common/time.c                                  | 2 +-
>  arch/mips/pistachio/irq.c                                         | 2 +-
>  63 files changed, 135 insertions(+), 137 deletions(-)
>  rename arch/mips/include/asm/{cpu-features.h => cpucaps.h} (99%)
>  rename arch/mips/include/asm/mach-ath25/{cpu-feature-overrides.h => cpucaps-overrides.h} (86%)
>  rename arch/mips/include/asm/mach-ath79/{cpu-feature-overrides.h => cpucaps-overrides.h} (85%)
>  rename arch/mips/include/asm/mach-au1x00/{cpu-feature-overrides.h => cpucaps-overrides.h} (91%)
>  rename arch/mips/include/asm/mach-bcm47xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (93%)
>  rename arch/mips/include/asm/mach-bcm63xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>  rename arch/mips/include/asm/mach-bmips/{cpu-feature-overrides.h => cpucaps-overrides.h} (64%)
>  rename arch/mips/include/asm/mach-cavium-octeon/{cpu-feature-overrides.h => cpucaps-overrides.h} (94%)
>  rename arch/mips/include/asm/mach-cobalt/{cpu-feature-overrides.h => cpucaps-overrides.h} (90%)
>  rename arch/mips/include/asm/mach-dec/{cpu-feature-overrides.h => cpucaps-overrides.h} (95%)
>  rename arch/mips/include/asm/mach-generic/{cpu-feature-overrides.h => cpucaps-overrides.h} (61%)
>  rename arch/mips/include/asm/mach-ip22/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
>  rename arch/mips/include/asm/mach-ip27/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
>  rename arch/mips/include/asm/mach-ip28/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
>  rename arch/mips/include/asm/mach-ip32/{cpu-feature-overrides.h => cpucaps-overrides.h} (89%)
>  rename arch/mips/include/asm/mach-jz4740/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
>  rename arch/mips/include/asm/mach-lantiq/falcon/{cpu-feature-overrides.h => cpucaps-overrides.h} (85%)
>  rename arch/mips/include/asm/mach-loongson64/{cpu-feature-overrides.h => cpucaps-overrides.h} (89%)
>  rename arch/mips/include/asm/mach-malta/{cpu-feature-overrides.h => cpucaps-overrides.h} (92%)
>  rename arch/mips/include/asm/mach-netlogic/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
>  rename arch/mips/include/asm/mach-paravirt/{cpu-feature-overrides.h => cpucaps-overrides.h} (83%)
>  rename arch/mips/include/asm/mach-pic32/{cpu-feature-overrides.h => cpucaps-overrides.h} (82%)
>  rename arch/mips/include/asm/mach-pmcs-msp71xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (76%)
>  rename arch/mips/include/asm/mach-ralink/mt7620/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>  rename arch/mips/include/asm/mach-ralink/mt7621/{cpu-feature-overrides.h => cpucaps-overrides.h} (88%)
>  rename arch/mips/include/asm/mach-ralink/rt288x/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>  rename arch/mips/include/asm/mach-ralink/rt305x/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>  rename arch/mips/include/asm/mach-ralink/rt3883/{cpu-feature-overrides.h => cpucaps-overrides.h} (86%)
>  rename arch/mips/include/asm/mach-rc32434/{cpu-feature-overrides.h => cpucaps-overrides.h} (90%)
>  rename arch/mips/include/asm/mach-rm/{cpu-feature-overrides.h => cpucaps-overrides.h} (84%)
>  rename arch/mips/include/asm/mach-sibyte/{cpu-feature-overrides.h => cpucaps-overrides.h} (87%)
>  rename arch/mips/include/asm/mach-tx49xx/{cpu-feature-overrides.h => cpucaps-overrides.h} (74%)
> 


-- 
Florian
