Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 01:18:53 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:33357 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006895AbbDCXSvHdh8- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 01:18:51 +0200
Received: by lajy8 with SMTP id y8so87181600laj.0
        for <linux-mips@linux-mips.org>; Fri, 03 Apr 2015 16:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=3CtcVJrCY8JVYOcqDLE3ZXwGjgEKtyB5JVrf1A0lsQs=;
        b=cbfXMvH3/Roe58hD5c4ea9arLBVm1OYSV7qlPtNH4i9scr6YvQcCQbv3gvyRrzG6p1
         e/kJXqVgDK0NcgqQNQLAlUCgHLkD5cjJUFSh/2lRbeeI1TK0c/zpv+9jpc+eccTCAnVx
         dfOTsn54joslinsKDwaQKQ8nWcL0Z9Ar7LkV9N/ZAtCQ91Z8khoM1hECII12xmTW6tB/
         ShcgvJBTCQLd6+zjFcBJ/cDLRCswsONYt9871D+jFCVEdTXtCoQcFJIrPe7FKPAK0KK+
         aqUZl1yLC5+cEj3EEoG3/c5rLAdadeYHNdSNaKM4yURr14IlCO4Q+0tviLcaBR6wmfpp
         j0EQ==
X-Gm-Message-State: ALoCoQkutd80S4mVQSWULEuEAffbLznXRlMyY9ASlJ8M4zJwbS5lpWEWyHVbL7xlc48PWuhn6KZx
X-Received: by 10.112.218.5 with SMTP id pc5mr4089421lbc.32.1428103126910;
        Fri, 03 Apr 2015 16:18:46 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp24-62.pppoe.mtu-net.ru. [81.195.24.62])
        by mx.google.com with ESMTPSA id j6sm1842610laf.5.2015.04.03.16.18.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 16:18:45 -0700 (PDT)
Message-ID: <551F1FD4.9000903@cogentembedded.com>
Date:   Sat, 04 Apr 2015 02:18:44 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 43/48] MIPS: math-emu: Set FIR feature flags for full
 emulation
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504032103180.21028@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1504032103180.21028@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 04/04/2015 01:27 AM, Maciej W. Rozycki wrote:

> Implement FIR feature flags in the FPU emulator according to features
> supported and architecture level requirements.  The W, L and F64 bits
> have only been added at level #2 even though the features they refer to
> were also included with the MIPS64r1 ISA and the W fixed-point format
> also with the MIPS32r1 ISA.

> This is only relevant for the full emulation mode and the emulated CFC1
> instruction as well as ptrace(2) accesses.

> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> linux-mips-emu-fir.diff
> Index: linux/arch/mips/kernel/cpu-probe.c
> ===================================================================
> --- linux.orig/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:58.700229000 +0100
> +++ linux/arch/mips/kernel/cpu-probe.c	2015-04-02 20:27:58.890231000 +0100
[...]
> @@ -31,11 +32,30 @@
>   #include <asm/spram.h>
>   #include <asm/uaccess.h>
>
> +/*
> + * Set the FIR feature flags for the FPU emulator.
> + */
> +static void cpu_set_nofpu_id(struct cpuinfo_mips *c)
> +{
> +	u32 value;
> +
> +	value = 0;

    Why not just do it in an initializer?

> +	if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M64R1 |
> +			    MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
> +			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6))
> +		value |= MIPS_FPIR_D | MIPS_FPIR_S;
> +	if (c->isa_level & (MIPS_CPU_ISA_M32R2 | MIPS_CPU_ISA_M64R2 |
> +			    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R6))
> +		value |= MIPS_FPIR_F64 | MIPS_FPIR_L | MIPS_FPIR_W;
> +	c->fpu_id = value;
> +}
> +
>   static int mips_fpu_disabled;
>
>   static int __init fpu_disable(char *s)
>   {
> -	cpu_data[0].options &= ~MIPS_CPU_FPU;
> +	boot_cpu_data.options &= ~MIPS_CPU_FPU;
> +	cpu_set_nofpu_id(&boot_cpu_data);
>   	mips_fpu_disabled = 1;
>
>   	return 1;
> @@ -1375,7 +1395,8 @@ void cpu_probe(void)
>   			if (c->fpu_id & MIPS_FPIR_FREP)
>   				c->options |= MIPS_CPU_FRE;
>   		}
> -	}
> +	} else
> +		cpu_set_nofpu_id(c);

    CodingStyle: need {} in the *else* branch as well.

[...]

WBR, Sergei
