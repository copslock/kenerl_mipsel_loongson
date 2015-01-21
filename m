Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 12:34:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5089 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011344AbbAULeNTxExa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 12:34:13 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2799780519145;
        Wed, 21 Jan 2015 11:34:05 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 11:34:07 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Jan
 2015 11:34:05 +0000
Message-ID: <54BF8EAD.6030403@imgtec.com>
Date:   Wed, 21 Jan 2015 11:34:05 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BF8E2B.3010904@gentoo.org>
In-Reply-To: <54BF8E2B.3010904@gentoo.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45401
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

On 01/21/2015 11:31 AM, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
> 
> This is a small patch to display the CPU byteorder that the kernel was compiled
> with in /proc/cpuinfo.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/kernel/proc.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> This version of the patches replaces the #ifdefs with proper conditionals.
> 
> linux-mips-proc-cpuinfo-byteorder.patch
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 097fc8d..22ef4c9 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -65,6 +65,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
>  		      cpu_data[n].udelay_val / (500000/HZ),
>  		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
> +	if (config_enabled(CONFIG_CPU_BIG_ENDIAN))
> +		seq_printf(m, "byteorder\t\t: big endian\n");
> +	else
> +		seq_printf(m, "byteorder\t\t: little endian\n");
>  	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
>  	seq_printf(m, "microsecond timers\t: %s\n",
>  		      cpu_has_counter ? "yes" : "no");
> 
> 
fwiw that looks ok to me

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
