Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:03:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:53429 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822092AbaDHLDqUf4Ft (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:03:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 231E3A9A2694;
        Tue,  8 Apr 2014 12:03:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:03:39 +0100
Received: from [192.168.154.89] (192.168.154.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 8 Apr
 2014 12:03:36 +0100
Message-ID: <5343D799.2040203@imgtec.com>
Date:   Tue, 8 Apr 2014 12:03:53 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: Remove SMTC Support
References: <1396954750-24762-1-git-send-email-markos.chandras@imgtec.com> <1396954750-24762-2-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1396954750-24762-2-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39701
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

On 04/08/2014 11:59 AM, Markos Chandras wrote:
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 037a44d..e12843a 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -124,7 +124,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   	seq_printf(m, "kscratch registers\t: %d\n",
>   		      hweight8(cpu_data[n].kscratch_mask));
>   	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
> -

Hi Ralf,

This change was not intentional. It's due to a bad merge conflict 
resolution. Could you please fix this before you merge this patch?

Thanks!

-- 
markos
