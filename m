Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2015 17:38:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2035 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006547AbbFRPiUSobBQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2015 17:38:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8E61D59045B70;
        Thu, 18 Jun 2015 16:38:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Jun 2015 16:38:14 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Jun
 2015 16:38:13 +0100
Subject: Re: [PATCH] MIPS: CPS: Guard mips_mt_set_cpuoptions call
To:     Tony Wu <tung7970@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>
References: <20150618232909-tung7970@googlemail.com>
CC:     Paul Burton <paul.burton@imgtec.com>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <5582E5E5.6080005@imgtec.com>
Date:   Thu, 18 Jun 2015 16:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150618232909-tung7970@googlemail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 06/18/2015 04:30 PM, Tony Wu wrote:
> Guard mips_mt_set_cpuoptions with MT specific options to
> avoid undefined reference error on multicore platform
> without multithreading support.
> 
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/kernel/smp-cps.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index 5570bc8..85633d6 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -102,7 +102,8 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
>  	bool cca_unsuitable;
>  	u32 *entry_code;
>  
> -	mips_mt_set_cpuoptions();
> +	if (config_enabled(CONFIG_MIPS_MT_SMP) && cpu_has_mipsmt)
> +		mips_mt_set_cpuoptions();
>  
>  	/* Detect whether the CCA is unsuited to multi-core SMP */
>  	cca = read_c0_config() & CONF_CM_CMASK;
> 

How come you hit a build problem here? according to
arch/mips/include/asm/mips_mt.h the mips_mt_set_cpuoptions() is a NOP
when CONFIG_MIPS_MT is not selected so it should work for non-MT
multicore CPUs. Am I missing something?

-- 
markos
