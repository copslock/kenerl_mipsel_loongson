Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 17:41:48 +0200 (CEST)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36542 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026710AbbEMPlqa0qVY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 17:41:46 +0200
Received: by wgbhc8 with SMTP id hc8so14334705wgb.3
        for <linux-mips@linux-mips.org>; Wed, 13 May 2015 08:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=z9cTQn8mkP93XdGuRLjQl39kdLR2HjwDcyRLLfvnyI0=;
        b=TB6XAWZPzYouuR6sQMW6zAZoHjsrqwa703oYrfcPKp7RXzMU0/A8zICzVDZ/5su25M
         LFDCQPOvY8VeulKE3I46mW0GZNK7MwHKUi71hhZjEVWC3hWncU2WmPdv+2qiqy41pcnU
         Q6YRrI+hI2wP7yHaxUhkM3PEDIQmarjAn+j2b/1s8B/0vJ6gNmNkWOb73GZdRq/cLHoE
         LlmvgnUi4xnvnjDQN7ChzjBvNUVdBaDi4N08JfFoH+jQ3BATgCXuTSLy9eq+mo8HQCZO
         TC7fehbfWUrAZMtuTA9yJHqNLHLZCrMS3D94/92l/DrSf+gh/fFyAlFf0OEhDTurnnip
         tdig==
X-Gm-Message-State: ALoCoQlKgx5+Nwf1tCl4uDBZW8TtxKJ8mTDaijheUeV52vsFuPMdCq2m3Oj6k7dcs5RhNnUKEsRT
X-Received: by 10.180.73.198 with SMTP id n6mr40917988wiv.3.1431531703291;
        Wed, 13 May 2015 08:41:43 -0700 (PDT)
Received: from [192.168.0.45] ([190.2.108.156])
        by mx.google.com with ESMTPSA id i13sm8675690wic.13.2015.05.13.08.41.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 08:41:42 -0700 (PDT)
Message-ID: <55536FFA.2040801@vanguardiasur.com.ar>
Date:   Wed, 13 May 2015 12:38:34 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Organization: VanguardiaSur
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: cpu: Convert MIPS_CPU_* defs to (1ull << x)
References: <1431530234-32460-1-git-send-email-james.hogan@imgtec.com> <1431530234-32460-3-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1431530234-32460-3-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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



On 05/13/2015 12:17 PM, James Hogan wrote:
> The MIPS_CPU_* definitions have now filled the first 32-bits, and are
> getting longer since they're written in hex without zero padding. Adding
> my 8 extra MIPS_CPU_* definitions which I haven't upstreamed yet this is
> getting increasingly ugly as the comments get shifted progressively to
> the right. Its also error prone, and I've seen this cause mistakes on 3
> separate occasions now, not helped by it being a conflict hotspot.
> 
> Convert all the MIPS_CPU_* definitions to the form (1ull << x). Humans
> are better at incrementing than shifting.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/cpu.h | 70 ++++++++++++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index c45c20db460d..a80819c50e88 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -344,41 +344,41 @@ enum cpu_type_enum {
>  /*
>   * CPU Option encodings
>   */
> -#define MIPS_CPU_TLB		0x00000001ull /* CPU has TLB */
> -#define MIPS_CPU_4KEX		0x00000002ull /* "R4K" exception model */
> -#define MIPS_CPU_3K_CACHE	0x00000004ull /* R3000-style caches */
> -#define MIPS_CPU_4K_CACHE	0x00000008ull /* R4000-style caches */
> -#define MIPS_CPU_TX39_CACHE	0x00000010ull /* TX3900-style caches */
> -#define MIPS_CPU_FPU		0x00000020ull /* CPU has FPU */
> -#define MIPS_CPU_32FPR		0x00000040ull /* 32 dbl. prec. FP registers */
> -#define MIPS_CPU_COUNTER	0x00000080ull /* Cycle count/compare */
> -#define MIPS_CPU_WATCH		0x00000100ull /* watchpoint registers */
> -#define MIPS_CPU_DIVEC		0x00000200ull /* dedicated interrupt vector */
> -#define MIPS_CPU_VCE		0x00000400ull /* virt. coherence conflict possible */
> -#define MIPS_CPU_CACHE_CDEX_P	0x00000800ull /* Create_Dirty_Exclusive CACHE op */
> -#define MIPS_CPU_CACHE_CDEX_S	0x00001000ull /* ... same for seconary cache ... */
> -#define MIPS_CPU_MCHECK		0x00002000ull /* Machine check exception */
> -#define MIPS_CPU_EJTAG		0x00004000ull /* EJTAG exception */
> -#define MIPS_CPU_NOFPUEX	0x00008000ull /* no FPU exception */
> -#define MIPS_CPU_LLSC		0x00010000ull /* CPU has ll/sc instructions */
> -#define MIPS_CPU_INCLUSIVE_CACHES	0x00020000ull /* P-cache subset enforced */
> -#define MIPS_CPU_PREFETCH	0x00040000ull /* CPU has usable prefetch */
> -#define MIPS_CPU_VINT		0x00080000ull /* CPU supports MIPSR2 vectored interrupts */
> -#define MIPS_CPU_VEIC		0x00100000ull /* CPU supports MIPSR2 external interrupt controller mode */
> -#define MIPS_CPU_ULRI		0x00200000ull /* CPU has ULRI feature */
> -#define MIPS_CPU_PCI		0x00400000ull /* CPU has Perf Ctr Int indicator */
> -#define MIPS_CPU_RIXI		0x00800000ull /* CPU has TLB Read/eXec Inhibit */
> -#define MIPS_CPU_MICROMIPS	0x01000000ull /* CPU has microMIPS capability */
> -#define MIPS_CPU_TLBINV		0x02000000ull /* CPU supports TLBINV/F */
> -#define MIPS_CPU_SEGMENTS	0x04000000ull /* CPU supports Segmentation Control registers */
> -#define MIPS_CPU_EVA		0x08000000ull /* CPU supports Enhanced Virtual Addressing */
> -#define MIPS_CPU_HTW		0x10000000ull /* CPU support Hardware Page Table Walker */
> -#define MIPS_CPU_RIXIEX		0x20000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
> -#define MIPS_CPU_MAAR		0x40000000ull /* MAAR(I) registers are present */
> -#define MIPS_CPU_FRE		0x80000000ull /* FRE & UFE bits implemented */
> -#define MIPS_CPU_RW_LLB		0x100000000ull /* LLADDR/LLB writes are allowed */
> -#define MIPS_CPU_XPA		0x200000000ull /* CPU supports Extended Physical Addressing */
> -#define MIPS_CPU_CDMM		0x400000000ull	/* CPU has Common Device Memory Map */
> +#define MIPS_CPU_TLB		(1ull <<  0) /* CPU has TLB */
> +#define MIPS_CPU_4KEX		(1ull <<  1) /* "R4K" exception model */
> +#define MIPS_CPU_3K_CACHE	(1ull <<  2) /* R3000-style caches */
> +#define MIPS_CPU_4K_CACHE	(1ull <<  3) /* R4000-style caches */
> +#define MIPS_CPU_TX39_CACHE	(1ull <<  4) /* TX3900-style caches */
> +#define MIPS_CPU_FPU		(1ull <<  5) /* CPU has FPU */
> +#define MIPS_CPU_32FPR		(1ull <<  6) /* 32 dbl. prec. FP registers */
> +#define MIPS_CPU_COUNTER	(1ull <<  7) /* Cycle count/compare */
> +#define MIPS_CPU_WATCH		(1ull <<  8) /* watchpoint registers */
> +#define MIPS_CPU_DIVEC		(1ull <<  9) /* dedicated interrupt vector */
> +#define MIPS_CPU_VCE		(1ull << 10) /* virt. coherence conflict possible */
> +#define MIPS_CPU_CACHE_CDEX_P	(1ull << 11) /* Create_Dirty_Exclusive CACHE op */
> +#define MIPS_CPU_CACHE_CDEX_S	(1ull << 12) /* ... same for seconary cache ... */
> +#define MIPS_CPU_MCHECK		(1ull << 13) /* Machine check exception */
> +#define MIPS_CPU_EJTAG		(1ull << 14) /* EJTAG exception */
> +#define MIPS_CPU_NOFPUEX	(1ull << 15) /* no FPU exception */
> +#define MIPS_CPU_LLSC		(1ull << 16) /* CPU has ll/sc instructions */
> +#define MIPS_CPU_INCLUSIVE_CACHES (1ull << 17) /* P-cache subset enforced */
> +#define MIPS_CPU_PREFETCH	(1ull << 18) /* CPU has usable prefetch */
> +#define MIPS_CPU_VINT		(1ull << 19) /* CPU supports MIPSR2 vectored interrupts */
> +#define MIPS_CPU_VEIC		(1ull << 20) /* CPU supports MIPSR2 external interrupt controller mode */
> +#define MIPS_CPU_ULRI		(1ull << 21) /* CPU has ULRI feature */
> +#define MIPS_CPU_PCI		(1ull << 22) /* CPU has Perf Ctr Int indicator */
> +#define MIPS_CPU_RIXI		(1ull << 23) /* CPU has TLB Read/eXec Inhibit */
> +#define MIPS_CPU_MICROMIPS	(1ull << 24) /* CPU has microMIPS capability */
> +#define MIPS_CPU_TLBINV		(1ull << 25) /* CPU supports TLBINV/F */
> +#define MIPS_CPU_SEGMENTS	(1ull << 26) /* CPU supports Segmentation Control registers */
> +#define MIPS_CPU_EVA		(1ull << 27) /* CPU supports Enhanced Virtual Addressing */
> +#define MIPS_CPU_HTW		(1ull << 28) /* CPU support Hardware Page Table Walker */
> +#define MIPS_CPU_RIXIEX		(1ull << 29) /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
> +#define MIPS_CPU_MAAR		(1ull << 30) /* MAAR(I) registers are present */
> +#define MIPS_CPU_FRE		(1ull << 31) /* FRE & UFE bits implemented */
> +#define MIPS_CPU_RW_LLB		(1ull << 32) /* LLADDR/LLB writes are allowed */
> +#define MIPS_CPU_XPA		(1ull << 33) /* CPU supports Extended Physical Addressing */
> +#define MIPS_CPU_CDMM		(1ull << 34) /* CPU has Common Device Memory Map */
>  

Isn't more readable to use BIT_ULL ?

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
