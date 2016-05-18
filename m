Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 08:53:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27930 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008982AbcERGxveTurY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 08:53:51 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id C7C3C57C07F84;
        Wed, 18 May 2016 07:53:43 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 07:53:45 +0100
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 18 May
 2016 07:53:45 +0100
Subject: Re: [PATCH 2/3] MIPS: smp-cps: Clear Status IPL field when using EIC
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
References: <1463495466-29689-1-git-send-email-paul.burton@imgtec.com>
 <1463495466-29689-3-git-send-email-paul.burton@imgtec.com>
CC:     Qais Yousef <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Markos Chandras <markos.chandras@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <573C1179.8060306@imgtec.com>
Date:   Wed, 18 May 2016 07:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1463495466-29689-3-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 17/05/16 15:31, Paul Burton wrote:
> When using an external interrupt controller (EIC) the interrupt mask
> bits in the cop0 Status register are reused for the Interrupt Priority
> Level, and any interrupts with a priority lower than the field will be
> ignored. Clear the field to 0 by default such that all interrupts are
> serviced.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>   arch/mips/kernel/smp-cps.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index 253e140..f19f0d3 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -307,8 +307,12 @@ static void cps_init_secondary(void)
>   	if (cpu_has_mipsmt)
>   		dmt();
>   
> -	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
> -				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
> +	if (cpu_has_veic)
> +		clear_c0_status(ST0_IM);
> +	else
> +		change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 |
> +					 STATUSF_IP4 | STATUSF_IP5 |
> +					 STATUSF_IP6 | STATUSF_IP7);
>   }
>   
>   static void cps_smp_finish(void)
Hi Paul

Reviewed-by: Matt Redfearn <matt.redfearn@imgtec.com>
Tested-by: Matt Redfearn <matt.redfearn@imgtec.com>

Thanks,
Matt
