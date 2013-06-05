Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 22:53:33 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:53258 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823037Ab3FEUx3GDc6k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 22:53:29 +0200
Received: by mail-pd0-f180.google.com with SMTP id 10so2354607pdi.25
        for <multiple recipients>; Wed, 05 Jun 2013 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BaEI9EOhxOOOUGGUkegKMIe7DK8cssLhHvv94AJ6z+g=;
        b=1GLLOM0JY/GMvMHpp2T46Pe9JvQxGRuz4MLntSj9eZmL1CHhj3O+ryRblYyKNsg1ab
         r2aGloCQM7oitCsINB0DapyT7HtDbROirWXNpUX5FoYV1uijM1O75Ub34Y0jxRudeu/u
         aBghnR/L9Nz2ZJ6GSD9GaXaX6GYtjUJK7WczavLME8gOrv0U/bOJ59chPEDgMJz82nWl
         RNuSKW4hmLqBoTvfwngCfssspKDKO5s1H/hVyQT0HpYE/pha9irGvaJ8TjJ/zVJndqPi
         CgOcf0b3D41mBOiWnIqFsxs+/LoZpRTDqdYSDr2tQl7skCKyh1PaqKwzLlKxUNMyiYME
         loNg==
X-Received: by 10.68.176.197 with SMTP id ck5mr34371911pbc.165.1370465602530;
        Wed, 05 Jun 2013 13:53:22 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vz8sm74149899pac.20.2013.06.05.13.53.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 13:53:21 -0700 (PDT)
Message-ID: <51AFA540.5010207@gmail.com>
Date:   Wed, 05 Jun 2013 13:53:20 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v6] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36706
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

On 06/05/2013 12:49 PM, Steven J. Hill wrote:
> The ISA exception bit selects whether exceptions are taken in classic
> or microMIPS mode. This bit is Config3.ISAOnExc and was improperly
> defined as bits 16 and 17 instead of just bit 16. A new function was
> added so that platforms could set this bit when running a kernel
> compiled with only microMIPS instructions.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
> Changes from v5:
> * Make 'set_micromips_exception_mode' function to always be called.

Version 5 was better in my opinion...


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

You can only manipulate this bit if you know microMIPS is supported.  So 
I think you should either not touch it for the non-microMIPS case, or 
make the write conditional on the presence of microMIPS support in the CPU.

David Daney


> +}
> +
> +/*
