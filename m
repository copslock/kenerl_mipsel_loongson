Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 23:27:06 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:57927 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835047Ab3FEV1FPslZ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 23:27:05 +0200
Received: by mail-la0-f41.google.com with SMTP id fn20so1929939lab.28
        for <linux-mips@linux-mips.org>; Wed, 05 Jun 2013 14:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=OQalkzcYinn+tr2WW2BmoVUjFuG4NSJ2MEeqdPeMu/k=;
        b=A92EQa3D7f5e6/CBI8EpZNk/pTuqeA1D5kx8G3VMwAb94kTJCFOXxa4tVSYCo6w9oa
         FSf3X9pCEbNdzwLoMf3ii7A3ofnpYYPnUJGDSiDQpxRwAOuEYqTStKcMdhNdnJbFI3kI
         hCC7ns5xHv/qssYDVn+9peMBZm98CdEf9yz8FrKUVXABhjCprB3RKE7JkGnyhUg2DpLx
         allN2F/NHH1L+zoD+zyKqmrMTd8qtgm/ilw8kXu7RKJu5pPNjoFbXGQkwSR+WHTDyRuO
         PcsgLARFVNEqyhb+/GQPVTvbtdXg2BFs0ftZSTjxwyEQlaKGBSiUdT5mQ0CMmvadJ7uu
         pHPw==
X-Received: by 10.112.188.231 with SMTP id gd7mr3214712lbc.26.1370467619537;
        Wed, 05 Jun 2013 14:26:59 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-88-205.pppoe.mtu-net.ru. [91.76.88.205])
        by mx.google.com with ESMTPSA id f9sm27664055lbf.4.2013.06.05.14.26.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 14:26:58 -0700 (PDT)
Message-ID: <51AFAD28.1010608@cogentembedded.com>
Date:   Thu, 06 Jun 2013 01:27:04 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v7] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370466783-21288-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1370466783-21288-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlu2ZTurVbp3r8EiUPXpbj2e+iyjyPNm5JkK9p+ihK6TGuaBbHjfxbWSLNbH/Gqx/W7n5pa
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36711
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

On 06/06/2013 01:13 AM, Steven J. Hill wrote:
> The ISA exception bit selects whether exceptions are taken in classic
> or microMIPS mode. This bit is Config3.ISAOnExc and was improperly
> defined as bits 16 and 17 instead of just bit 16. A new function was
> added so that platforms could set this bit when running a kernel
> compiled with only microMIPS instructions.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Acked-by: David Daney <david.daney@cavium.com>
> ---
> Changes from v6:
> * Add '#ifdef SYS_SUPPORTS_MICROMIPS' around body of
>    'set_micromips_exception_mode' function. Platforms that
>    do not support microMIPS will optimize it out.
>
>   arch/mips/include/asm/mipsregs.h |   20 +++++++++++++++++++-
>   arch/mips/kernel/cpu-probe.c     |    3 ---
>   arch/mips/kernel/traps.c         |    5 +++++
>   3 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 87e6207..0a9544a 100644
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
> @@ -1161,6 +1161,24 @@ do {									\
>   #define write_c0_brcm_sleepcount(val)	__write_32bit_c0_register($22, 7, val)
>   
>   /*
> + * Set exceptions to be taken in microMIPS mode only, otherwise
> + * set for classic exceptions.
> + */
> +static inline void set_micromips_exception_mode(void)
> +{
> +#ifdef SYS_SUPPORTS_MICROMIPS
> +	unsigned int config3 = read_c0_config3();
> +
> +#ifdef CONFIG_CPU_MICROMIPS
> +	if (config3 & MIPS_CONF3_ISA)
> +		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
> +	else
> +#endif
> +		write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
> +#endif

    Let me remind that #ifdef's inside the function body are considered 
ugly and
should be avoided if at all possible (by defining an empty 
implementation in the
#else branch).

WBR, Sergei
