Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2014 06:16:53 +0200 (CEST)
Received: from szxga03-in.huawei.com ([119.145.14.66]:38997 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818018AbaE0EQugh47u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2014 06:16:50 +0200
Received: from 172.24.2.119 (EHLO szxeml212-edg.china.huawei.com) ([172.24.2.119])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id APE75762;
        Tue, 27 May 2014 12:16:40 +0800 (CST)
Received: from SZXEML410-HUB.china.huawei.com (10.82.67.137) by
 szxeml212-edg.china.huawei.com (172.24.2.181) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Tue, 27 May 2014 12:16:39 +0800
Received: from [10.177.18.230] (10.177.18.230) by smtpscn.huawei.com
 (10.82.67.137) with Microsoft SMTP Server (TLS) id 14.3.158.1; Tue, 27 May
 2014 12:16:33 +0800
Message-ID: <5384119E.7010606@huawei.com>
Date:   Tue, 27 May 2014 12:16:30 +0800
From:   Li Zefan <lizefan@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang@windriver.com>
CC:     <ralf@linux-mips.org>, <huawei.libin@huawei.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH V2] MIPS: change type of asid_cache to unsigned long
References: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com>
In-Reply-To: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.18.230]
X-CFilter-Loop: Reflected
Return-Path: <lizefan@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizefan@huawei.com
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

I'm not quite happy about what happaned here. There's a story behind
this patch.

One of our Huawei product encountered a bug, and they're using WindRiver4,
so the kernel is 2.6.34.

Because they bought your licnece, they asked for your help, but
you were reluctant on this issue, and the problem remained there
for about one month.

At last they turned to us for help. We're the kernel department in
Huawei, but maintaining this product kernel isn't our job. Still
Li Bin devoted his time to analyzing this bug, and he did a great
job.

Li Bin told the product team what was wrong and was about to send
a fix for upstream kernel. They told you our analysis for further
confirmation, and you were so reluctant to help but so quick to
send the fix.

Li Bin never reported this bug, but he fixed it. It's a shame that
you took the credit from us.

On 2014/5/21 13:36, Yong Zhang wrote:
> asid_cache must be unsigned long otherwise on 64bit system
> it will become 0 if the value in get_new_mmu_context()
> reaches 0xffffffff and in the end the assumption of
> ASID_FIRST_VERSION is not true anymore thus leads to
> more dangerous things.
> 

We should describe what problem this bug can lead to, which
will help people who encounter the same problem and google it.

> Reported-by: libin <huawei.libin@huawei.com>
> Signed-off-by: Yong Zhang <yong.zhang@windriver.com>

Should mark the patch for stable trees. Though 2.6.34 is EOL,
the fix should be backported to other kernels.

> ---
> 
> V2<-V1: Add the reporter.
> 
>  arch/mips/include/asm/cpu-info.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> index f6299be..ebcc2ed 100644
> --- a/arch/mips/include/asm/cpu-info.h
> +++ b/arch/mips/include/asm/cpu-info.h
> @@ -40,7 +40,7 @@ struct cache_desc {
>  
>  struct cpuinfo_mips {
>  	unsigned int		udelay_val;
> -	unsigned int		asid_cache;
> +	unsigned long		asid_cache;
>  
>  	/*
>  	 * Capability and feature descriptor structure for MIPS CPU
> 
