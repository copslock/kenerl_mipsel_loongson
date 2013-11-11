Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Nov 2013 20:59:21 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:56391 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827340Ab3KKT7SAa-P4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Nov 2013 20:59:18 +0100
Received: by mail-ie0-f171.google.com with SMTP id at1so2502585iec.2
        for <linux-mips@linux-mips.org>; Mon, 11 Nov 2013 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=nA5jmUHVwmN1fdLP1L8HpUmCupYIqfK1dkTL/4pS2rs=;
        b=LdBM0TKAGH+GB0+3GXjp+FU1iupg7UJHm+cErD5DYm164f0sBwcCPcuzl/Xku+kt6S
         nOMK6OgYL7LxKBfwFyb7kbp1wrM7MNIFDaLJOEiP2Ms7m5w3PhWeQbfumKBw3EdIJAkP
         PgUWnU0vwqHQGszrHCSdB9BNT+3L+dxEgAtqtjJvcprX1WhyYa8OmNuGWlbaBEOZaXxp
         d9b9qc9HYRbgWdr4jaVDSvUNXeGqHCBZA6UvDs/+IhzHOrXBhG86uNagb80tBXrgq7d3
         jGC9xzn0BfvtllXXOPpsgHy9A21H92AZphu3PhI04EFuzT5zDS3DU9cn6wHd1tSVHvlQ
         Fsvw==
X-Received: by 10.50.30.225 with SMTP id v1mr13769771igh.28.1384199951271;
        Mon, 11 Nov 2013 11:59:11 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id c14sm16875913ign.0.2013.11.11.11.59.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 11:59:10 -0800 (PST)
Message-ID: <5281370C.8040707@gmail.com>
Date:   Mon, 11 Nov 2013 11:59:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 3/6] MIPS: Add support for the proAptiv cores
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com> <1383844120-29601-4-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1383844120-29601-4-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 11/07/2013 09:08 AM, Markos Chandras wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> The proAptiv Multiprocessing System is a power efficient multi-core
> microprocessor for use in system-on-chip (SoC) applications.
> The proAptiv Multiprocessing System combines a deep pipeline
> with multi-issue out of order execution for improved computational
> throughput. The proAptiv Multiprocessing System can contain one to
> six MIPS32r3 proAptiv cores, system level coherence
> manager with L2 cache, optional coherent I/O port, and optional
> floating point unit.
>
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>


This patch is a big collection of small unrelated changes.

Can you break it up so that there is one patch per change?

o Add new identifiers
o Probe for them.
o Add new cpu-features.
o tlb.h change.
o All the places you add 'case CPU_PROAPTIV'

Plus...
> ---
>   arch/mips/include/asm/cpu-features.h |  3 +++
>   arch/mips/include/asm/cpu-type.h     |  1 +
>   arch/mips/include/asm/cpu.h          |  5 ++++-
>   arch/mips/include/asm/tlb.h          |  4 +++-
>   arch/mips/kernel/cpu-probe.c         | 15 +++++++++++++++
>   arch/mips/kernel/idle.c              |  1 +
>   arch/mips/kernel/spram.c             |  1 +
>   arch/mips/kernel/traps.c             |  1 +
>   arch/mips/mm/c-r4k.c                 |  1 +
>   arch/mips/mm/sc-mips.c               |  1 +
>   arch/mips/mm/tlbex.c                 |  1 +
>   arch/mips/oprofile/op_model_mipsxx.c |  4 ++++
>   12 files changed, 36 insertions(+), 2 deletions(-)
>
[...]
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index c814287..8168e29 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -286,6 +286,13 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
>   	    && cpu_has_tlb)
>   		c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
>
> +	if (cpu_has_tlb) {
> +		if (((config4 & MIPS_CONF4_IE) >> 29) == 2) {
> +			c->options |= MIPS_CPU_TLBINV;
> +			pr_info("TLBINV/F supported, config4=0x%0x\n", config4);

... The probing functions don't print messages, so don't add this pr_info().


> +		}
> +	}
> +
