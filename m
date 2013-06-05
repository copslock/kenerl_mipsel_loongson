Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 22:01:46 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:59650 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827572Ab3FEUBlUR5bC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 22:01:41 +0200
Received: by mail-la0-f49.google.com with SMTP id fp12so1216550lab.22
        for <linux-mips@linux-mips.org>; Wed, 05 Jun 2013 13:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=hsC0yR+LsXb2WQ2GtgEaWhwbxT/2u1HDwUHHa1ohxEA=;
        b=n4P8sTs/A7UHUmxujtNAUy2yTXRdJsUlzR+bogGUbmM82Oxu2qPoWosf99csjcu9cp
         aRkxzqSg13xjjqAGBdxehPrMmK3eon+/SduFmy6eCCpN5G2alQwI7uwiw5tz0QqC0q/P
         8kzWENhD+2ADAEZJjqD+9fGmt6bD08eUX7C8mQ/Zof8aes/jAX5wMYbN1Nt06oQxnRYs
         jW93PQAbjEiJyB+mVxilE4xIVpxFRQYg0Qu0DyI9SiLaQ6VbOmubXeM/1worktZYeo6z
         5pz3zVS431v3HMhubZBMF6ImPHVwnitjUIH+93KxEQFMQwAmXNnjnTg7EmYwJA86hsDa
         Lcgg==
X-Received: by 10.112.14.36 with SMTP id m4mr6313454lbc.63.1370462495483;
        Wed, 05 Jun 2013 13:01:35 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-88-205.pppoe.mtu-net.ru. [91.76.88.205])
        by mx.google.com with ESMTPSA id p16sm917580lbi.13.2013.06.05.13.01.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 13:01:34 -0700 (PDT)
Message-ID: <51AF9923.7000606@cogentembedded.com>
Date:   Thu, 06 Jun 2013 00:01:39 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v6] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnr1E04yDITEkrL+wd2EO7JVew1jq5auZWE1VophRUQ7McoXPydzeryF/BaKNkgu3kQWlum
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36704
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

On 06/05/2013 11:49 PM, Steven J. Hill wrote:

> The ISA exception bit selects whether exceptions are taken in classic
> or microMIPS mode. This bit is Config3.ISAOnExc and was improperly
> defined as bits 16 and 17 instead of just bit 16. A new function was
> added so that platforms could set this bit when running a kernel
> compiled with only microMIPS instructions.

     Ahem, isn't that function a material for another patch?

> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
> Changes from v5:
> * Make 'set_micromips_exception_mode' function to always be called.
>
>   arch/mips/include/asm/mipsregs.h |   18 +++++++++++++++++-
>   arch/mips/kernel/cpu-probe.c     |    3 ---
>   arch/mips/kernel/traps.c         |    5 +++++
>   3 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 87e6207..cc0f5d7 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -596,7 +596,7 @@
>   #define MIPS_CONF3_RXI		(_ULCAST_(1) << 12)
>   #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
>   #define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
> -#define MIPS_CONF3_ISA_OE	(_ULCAST_(3) << 16)
> +#define MIPS_CONF3_ISA_OE	(_ULCAST_(1) << 16)
>   #define MIPS_CONF3_VZ		(_ULCAST_(1) << 23)
>   
>   #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
> @@ -1161,6 +1161,22 @@ do {									\
>   #define write_c0_brcm_sleepcount(val)	__write_32bit_c0_register($22, 7, val)
>   
>   /*
> + * Set exceptions to be taken in microMIPS mode only, otherwise
> + * set for classic exceptions.
> + */
> +static inline void set_micromips_exception_mode(void)
> +{
> +	unsigned int config3 = read_c0_config3();
> +
> +#ifdef CONFIG_CPU_MICROMIPS
> +	if (config3 & MIPS_CONF3_ISA)
> +		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
> +	else
> +#endif
> +		write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
> +}
> +
> +/*
>    * Macros to access the floating point coprocessor control registers
>    */
>   #define read_32bit_cp1_register(source)					\
[...]
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index a75ae40..151ed59 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1837,6 +1837,11 @@ void __init trap_init(void)
>   			ebase += (read_c0_ebase() & 0x3ffff000);
>   	}
>   
> +	/*
> +	 * Set microMIPS exceptions for platforms that support it.
> +	 */
> +	set_micromips_exception_mode();

     If we have reduced the call sites to 1, do we still need the 
function? :-)

WBR, Sergei
