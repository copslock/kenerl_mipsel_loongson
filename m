Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2015 05:18:23 +0200 (CEST)
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36015 "EHLO
        mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006156AbbJTDSVx2e-l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2015 05:18:21 +0200
Received: by obcqt19 with SMTP id qt19so3811519obc.3;
        Mon, 19 Oct 2015 20:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=kJxhLFCp5PAGiRA1L/wl5UG3oj1hOG4JgmzFvdxg9A4=;
        b=UwSiXAVGBRQjwCmFASk0kZ4yaci9/4zcSrw8r/OMFsna7Rd3HDEsKyGTVdULJswC8k
         4m/Ey8fda9LcrH5eVl4WyeygHyu9U+EGabfPffEvMfEUqiIboTJo5r3gO1E1k01GzB1M
         h3oxleZwiTL9g7kdDp/uEY/sDx83s69eOf+fjDwcj8/iMkmYjLXYsXscrFRgNJwmSGTy
         IKpxKTv+/vwSEayu4oko7KKhsnOkC7CmgvNqTAX06MoVfDrtSIckNgfQKt8RiA5kXepX
         b2JWB4pxMaF0QfT5gLF/ZRQGIpGUnUv4RPbBoSWoz6P/Mp1X0COcaj1h7z3395QLQlT5
         xtZQ==
X-Received: by 10.60.47.199 with SMTP id f7mr470684oen.54.1445311094907;
        Mon, 19 Oct 2015 20:18:14 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:91ab:8784:cff4:d4c5? ([2001:470:d:73f:91ab:8784:cff4:d4c5])
        by smtp.googlemail.com with ESMTPSA id o8sm484634obi.6.2015.10.19.20.18.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2015 20:18:13 -0700 (PDT)
Subject: Re: [PATCH] MIPS: switch BMIPS5000 to use r4k_wait_irqoff()
To:     Petri Gynther <pgynther@google.com>, linux-mips@linux-mips.org
References: <1445280264-42016-1-git-send-email-pgynther@google.com>
Cc:     ralf@linux-mips.org, cernekee@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5625B274.4010800@gmail.com>
Date:   Mon, 19 Oct 2015 20:18:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445280264-42016-1-git-send-email-pgynther@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49602
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

Le 19/10/2015 11:44, Petri Gynther a écrit :
> BCM7425 CPU Interface Zephyr Processor, pages 5-309 and 5-310
> BCM7428B0 CPU Interface Zephyr Processor, pages 5-337 and 5-338
> 
> WAIT instruction:
> Thread enters wait state. No instructions are executed until an
> interrupt occurs. The processor's clocks are stopped if both threads
> are in idle mode.
> 
> Description:
> Execution of this instruction puts the thread into wait state, an idle
> mode in which no instructions are fetched or executed. The thread remains
> in wait state until an interrupt occurs that is not masked by the
> interrupt mask field in the Status register. Then, if interrupts are
> enabled by the IE bit in the Status register, the interrupt is serviced.
> The ERET instruction returns to the instruction following the WAIT
> instruction. If interrupts are disabled, the processor resumes executing
> instructions with the next sequential instruction.
> 
> Programming notes:
> The WAIT instruction should be executed while interrupts are disabled
> by the IE bit in the Status register. This avoids a potential timing
> hazard, which occurs if an interrupt is taken between testing the counter
> and executing the WAIT instruction. In this hazard case, the interrupt
> will have been completed before the WAIT instruction is executed, so
> the processor will remain indefinitely in wait state until the next
> interrupt.
> 
> Signed-off-by: Petri Gynther <pgynther@google.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  arch/mips/kernel/idle.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
> index ab1478d..d636c70 100644
> --- a/arch/mips/kernel/idle.c
> +++ b/arch/mips/kernel/idle.c
> @@ -160,7 +160,6 @@ void __init check_wait(void)
>  	case CPU_BMIPS3300:
>  	case CPU_BMIPS4350:
>  	case CPU_BMIPS4380:
> -	case CPU_BMIPS5000:
>  	case CPU_CAVIUM_OCTEON:
>  	case CPU_CAVIUM_OCTEON_PLUS:
>  	case CPU_CAVIUM_OCTEON2:
> @@ -171,7 +170,9 @@ void __init check_wait(void)
>  	case CPU_XLP:
>  		cpu_wait = r4k_wait;
>  		break;
> -
> +	case CPU_BMIPS5000:
> +		cpu_wait = r4k_wait_irqoff;
> +		break;
>  	case CPU_RM7000:
>  		cpu_wait = rm7k_wait_irqoff;
>  		break;
> 


-- 
Florian
