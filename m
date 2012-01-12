Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2012 15:39:42 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:64025 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904102Ab2ALOjf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jan 2012 15:39:35 +0100
Received: by eaaa13 with SMTP id a13so863365eaa.36
        for <multiple recipients>; Thu, 12 Jan 2012 06:39:29 -0800 (PST)
Received: by 10.204.225.71 with SMTP id ir7mr1217089bkb.124.1326379168947;
        Thu, 12 Jan 2012 06:39:28 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id b9sm11124861bks.6.2012.01.12.06.39.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 06:39:28 -0800 (PST)
Message-ID: <4F0EFE6E.3080503@mvista.com>
Date:   Thu, 12 Jan 2012 18:38:22 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH RESEND 16/17] MIPS: make oprofile use cp0_perfcount_irq
 if it is set
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org> <1326314674-9899-16-git-send-email-blogic@openwrt.org>
In-Reply-To: <1326314674-9899-16-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 01/11/2012 11:44 PM, John Crispin wrote:

> The patch makes the oprofile code use the performance counters irq.

> This patch is written by Felix Fietkau.

> Signed-off-by: Felix Fietkau<nbd@openwrt.org>
> Signed-off-by: John Crispin<blogic@openwrt.org>

> @@ -374,6 +379,10 @@ static int __init mipsxx_init(void)
>   	save_perf_irq = perf_irq;
>   	perf_irq = mipsxx_perfcount_handler;
>
> +	if (cp0_perfcount_irq>= 0)

    BTW, I just noticed. IRQ0 is not a valid IRQ in Linux, request_irq() should 
fail when passed 0, so this and following check should be '> 0'.

> +		return request_irq(cp0_perfcount_irq, mipsxx_perfcount_int,
> +			IRQF_SHARED, "Perfcounter", save_perf_irq);
> +
>   	return 0;
>   }
>
> @@ -381,6 +390,9 @@ static void mipsxx_exit(void)
>   {
>   	int counters = op_model_mipsxx_ops.num_counters;
>
> +	if (cp0_perfcount_irq>= 0)
> +		free_irq(cp0_perfcount_irq, save_perf_irq);
> +
>   	counters = counters_per_cpu_to_total(counters);
>   	on_each_cpu(reset_counters, (void *)(long)counters, 1);
>

WBR, Sergei
