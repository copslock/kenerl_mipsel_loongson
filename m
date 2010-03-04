Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2010 19:24:55 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5396 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492267Ab0CDSYw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Mar 2010 19:24:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b8ffafa0000>; Thu, 04 Mar 2010 10:24:58 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 4 Mar 2010 10:23:53 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 4 Mar 2010 10:23:53 -0800
Message-ID: <4B8FFAB3.1090409@caviumnetworks.com>
Date:   Thu, 04 Mar 2010 10:23:47 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Protect current_cpu_data with preempt disable in
 delay()
References: <1267695573-27360-1-git-send-email-yang.shi@windriver.com>
In-Reply-To: <1267695573-27360-1-git-send-email-yang.shi@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2010 18:23:53.0236 (UTC) FILETIME=[D8204540:01CABBC7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/04/2010 01:39 AM, Yang Shi wrote:
> During machine restart with reboot command, get the following
> bug info:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: reboot/1989
> caller is __udelay+0x14/0x70
> Call Trace:
> [<ffffffff8110ad28>] dump_stack+0x8/0x34
> [<ffffffff812dde04>] debug_smp_processor_id+0xf4/0x110
> [<ffffffff812d90bc>] __udelay+0x14/0x70
> [<ffffffff81378274>] md_notify_reboot+0x12c/0x148
> [<ffffffff81161054>] notifier_call_chain+0x64/0xc8
> [<ffffffff811614dc>] __blocking_notifier_call_chain+0x64/0xc0
> [<ffffffff8115566c>] kernel_restart_prepare+0x1c/0x38
> [<ffffffff811556cc>] kernel_restart+0x14/0x50
> [<ffffffff8115581c>] SyS_reboot+0x10c/0x1f0
> [<ffffffff81103684>] handle_sysn32+0x44/0x84
>
> The root cause is that current_cpu_data is accessed in preemptible
> context, so protect it with preempt_disable/preempt_enable pair
> in delay().
>
> Signed-off-by: Yang Shi<yang.shi@windriver.com>
> ---
>   arch/mips/lib/delay.c |    6 +++++-
>   1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
> index 6b3b1de..dc38064 100644
> --- a/arch/mips/lib/delay.c
> +++ b/arch/mips/lib/delay.c
> @@ -41,7 +41,11 @@ EXPORT_SYMBOL(__delay);
>
>   void __udelay(unsigned long us)
>   {
> -	unsigned int lpj = current_cpu_data.udelay_val;
> +	unsigned int lpj;
> +
> +	preempt_disable();
> +	lpj = current_cpu_data.udelay_val;
> +	preempt_enable();
>
>   	__delay((us * 0x000010c7ull * HZ * lpj)>>  32);
>   }

This doesn't seem like the best approach.

Perhaps we should either use raw_current_cpu_data and no 
preempt_disable(), or if we are concerned about migrating to a CPU with 
a different lpj value, move the preempt_enable after the call to __delay().

David Daney
