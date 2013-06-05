Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 13:08:02 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34021 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825737Ab3FELIBayqac (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 13:08:01 +0200
Received: by mail-lb0-f180.google.com with SMTP id r10so1741216lbi.11
        for <linux-mips@linux-mips.org>; Wed, 05 Jun 2013 04:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=LEPpYiXAH95q7ZmPJTaf6M1c+K52PWS+QXTL+5ImnWg=;
        b=EFfv1miT+X+lQLA+g5zAVmrjPRmoLvVyqW+jDU0qu3YuETcWIvLbbevBgjqTFFUPK+
         xJHabdOaCCVpNXx5EgcFw5w+Rb3dodkc8e+FNfFZG+j4WL1IzqjzRdtPX5UW1ttObEzJ
         Jt376MhdE4cfNFant99uBAINT0cx3SKUlyWzJzVYENnUIepVLJGcvunjG1Xm7iYHOVn5
         VJREjmRTBYthLWgOcmCnwjU+eULBFPW1wD3mbd5CZo+jGSo95e1ZNf3Wsi/Icoses+1n
         fk0uYjMT/IRHwxaK+lFvQUOVgKlbruY0SR58JFvw55fSOPRCfjLwdZi8Cc7s4xWFvIpY
         mclw==
X-Received: by 10.112.144.36 with SMTP id sj4mr15024391lbb.1.1370430475517;
        Wed, 05 Jun 2013 04:07:55 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-156-126.pppoe.mtu-net.ru. [91.76.156.126])
        by mx.google.com with ESMTPSA id 4sm16973801lai.4.2013.06.05.04.07.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 04:07:54 -0700 (PDT)
Message-ID: <51AF1C0B.6090904@cogentembedded.com>
Date:   Wed, 05 Jun 2013 15:07:55 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
Subject: Re: [PATCH v3] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370372979-20634-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1370372979-20634-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmeHsdOsHrtHSphAk1GcgG7sx3vbbhR844YEU9L/ZWeXqm7e0wWDVUXULUYk5alXHOSXgG4
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36693
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

On 04-06-2013 23:09, Steven J. Hill wrote:

> The ISA exception bit selects whether exceptions are taken in classic
> MIPS or microMIPS mode. This bit is Config3.ISAOnExc and is bit 16. It
> It was improperly defined as bits 16 and 17. Fortunately, bit 17 is
> read-only and did not effect microMIPS operation. However, detecting
> a classic or microMIPS kernel when examining the /proc/cpuinfo file,
> the result always showed a microMIPS kernel.

> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/include/asm/mipsregs.h |    2 +-
>   arch/mips/kernel/cpu-probe.c     |    7 ++-----
>   arch/mips/mti-malta/malta-init.c |    7 +++++++
>   arch/mips/mti-sead3/sead3-init.c |    7 +++++++
>   4 files changed, 17 insertions(+), 6 deletions(-)

[...]
> diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
> index ff8caff..3598f1d 100644
> --- a/arch/mips/mti-malta/malta-init.c
> +++ b/arch/mips/mti-malta/malta-init.c
> @@ -106,6 +106,13 @@ extern struct plat_smp_ops msmtc_smp_ops;
>
>   void __init prom_init(void)
>   {
> +#ifdef CONFIG_CPU_MICROMIPS
> +	unsigned int config3 = read_c0_config3();
> +
> +	if (config3 & MIPS_CONF3_ISA)
> +		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
> +#endif
> +
>   	mips_display_message("LINUX");
>
>   	/*
> diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
> index bfbd17b..e68bfd3 100644
> --- a/arch/mips/mti-sead3/sead3-init.c
> +++ b/arch/mips/mti-sead3/sead3-init.c
> @@ -130,6 +130,13 @@ static void __init mips_ejtag_setup(void)
>
>   void __init prom_init(void)
>   {
> +#ifdef CONFIG_CPU_MICROMIPS
> +	unsigned int config3 = read_c0_config3();
> +
> +	if (config3 & MIPS_CONF3_ISA)
> +		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
> +#endif
> +

    I see it's repeated twice and enclosed in #ifdef... Couldn't you
factor it out in some sort of inline function and put into some header:

#ifdef CONFIG_CPU_MICROMIPS
static inline void mips_set_config3_isa_oe(void)
{
	unsigned int config3 = read_c0_config3();

	if (config3 & MIPS_CONF3_ISA)
		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
}
#else
static inline void mips_set_config3_isa_oe(void) {}
#endif

WBR, Sergei
