Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 07:39:09 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:48626 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837156AbaEUFjICK6cz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 07:39:08 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s4L5cu8Y019154
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 20 May 2014 22:38:56 -0700 (PDT)
Received: from localhost (128.224.162.188) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.169.1; Tue, 20 May
 2014 22:38:56 -0700
Date:   Wed, 21 May 2014 13:38:53 +0800
From:   Yong Zhang <yong.zhang@windriver.com>
To:     Yong Zhang <yong.zhang0@gmail.com>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <huawei.libin@huawei.com>
Subject: Re: [PATCH] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140521053853.GC19655@pek-yzhang-d1>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
References: <1400573344-5035-1-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1400573344-5035-1-git-send-email-yong.zhang0@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [128.224.162.188]
Return-Path: <yong.zhang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
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

Please check the V2 in which I add the reporter.
And thanks libin for reporting it :)

Thanks,
Yong

On Tue, May 20, 2014 at 04:09:04PM +0800, Yong Zhang wrote:
> From: Yong Zhang <yong.zhang@windriver.com>
> 
> asid_cache must be unsigned long otherwise on 64bit system
> it will become 0 if the value in get_new_mmu_context()
> reaches 0xffffffff and in the end the assumption of
> ASID_FIRST_VERSION is not true anymore thus leads to
> more dangerous things.
> 
> Signed-off-by: Yong Zhang <yong.zhang@windriver.com>
> ---
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
> -- 
> 1.7.9.5
