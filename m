Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 14:43:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17004 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013201AbcCDNnoaDfqp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 14:43:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 34BD8A89F9319;
        Fri,  4 Mar 2016 13:43:36 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 4 Mar 2016 13:43:38 +0000
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 4 Mar
 2016 13:43:37 +0000
Subject: Re: [PATCH] MIPS: smp.c: Fix uninitialised temp_foreign_map
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1457086251-6477-1-git-send-email-james.hogan@imgtec.com>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <56D99109.2050306@imgtec.com>
Date:   Fri, 4 Mar 2016 13:43:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1457086251-6477-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52445
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

Hi James,

On 04/03/16 10:10, James Hogan wrote:
> When calculate_cpu_foreign_map() recalculates the cpu_foreign_map
> cpumask it uses the local variable temp_foreign_map without initialising
> it to zero. Since the calculation only ever sets bits in this cpumask
> any existing bits at that memory location will remain set and find their
> way into cpu_foreign_map too. This could potentially lead to cache
> operations suboptimally doing smp calls to multiple VPEs in the same
> core, even though the VPEs share primary caches.
>
> Therefore initialise temp_foreign_map using cpumask_clear() before use.
>
> Fixes: cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores")

cccf34e9411c was CC'd to stable 3.15+, should this fix do the same?

Thanks,
Matt


> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mips@linux-mips.org
> ---
>   arch/mips/kernel/smp.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index bd4385a8e6e8..2b521e07b860 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -121,6 +121,7 @@ static inline void calculate_cpu_foreign_map(void)
>   	cpumask_t temp_foreign_map;
>   
>   	/* Re-calculate the mask */
> +	cpumask_clear(&temp_foreign_map);
>   	for_each_online_cpu(i) {
>   		core_present = 0;
>   		for_each_cpu(k, &temp_foreign_map)
