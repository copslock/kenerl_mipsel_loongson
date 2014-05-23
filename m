Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2014 05:08:44 +0200 (CEST)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:60300 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821305AbaEWDImskaOq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 May 2014 05:08:42 +0200
Received: by mail-pb0-f51.google.com with SMTP id ma3so3449458pbc.38
        for <multiple recipients>; Thu, 22 May 2014 20:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RRNzPl1k1XsxUX+J5lJTCNUDInZBGfiwR3aPmP8j3HM=;
        b=SAoFpjIbOEC2uJPmHRDYgRyZz9htgroonVWuZCNM+RfsVqSMk9oxHXgVcUC3odlHQW
         zNTiI3zCsY9HHtHJhE3iVzdhbvqNcpB5eTDVT2pBT5M+Ykyhr039lhsFdLYXDqmpq/E9
         QI0kgOow98gY9TbLAS3qnlEsLVeT+WLQP8F7p7FGSfj9+AtO413b8QnoNZJItHN41ruE
         AFOpW3uPuULcOVON8Gp9ca9tT7u6BuGk/o2DVelsCA87lgML4YNFf16WoZ8R6y4Nbu8Y
         JTAQc9jaOLZru4sG3w5FD9X74V7onPpdCKBCk63yuTaU0hBTrXIQeeHtE4urrBAGX3hh
         ONCg==
X-Received: by 10.66.151.144 with SMTP id uq16mr2285234pab.68.1400814515851;
        Thu, 22 May 2014 20:08:35 -0700 (PDT)
Received: from localhost ([1.202.252.122])
        by mx.google.com with ESMTPSA id ay3sm1927089pbb.62.2014.05.22.20.08.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 20:08:34 -0700 (PDT)
Date:   Fri, 23 May 2014 11:08:28 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Yong Zhang <yong.zhang@windriver.com>, linux-mips@linux-mips.org,
        huawei.libin@huawei.com
Subject: Re: [PATCH] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140523030828.GA19723@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1400573344-5035-1-git-send-email-yong.zhang0@gmail.com>
 <20140521053853.GC19655@pek-yzhang-d1>
 <20140521112936.GC17197@linux-mips.org>
 <20140522020611.GA6813@zhy>
 <20140522134245.GF10287@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140522134245.GF10287@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <yong.zhang0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
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

On Thu, May 22, 2014 at 03:42:45PM +0200, Ralf Baechle wrote:
> Yes, struct cache_desc is still a problem.  Easily solvable though -
> some of it's members are excessivly large; by using smaller data types
> both the struct and its required alignment will shrink.  But that's
> for another patch; as for this patch my goal to just not make things
> any worse.

Agree. Anyway I have done the similiar change as your patch already :)

Thanks,
Yong

> 
>   Ralf
> 
> ---
>  arch/mips/include/asm/cpu-info.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> index dc2135b..ff2707a 100644
> --- a/arch/mips/include/asm/cpu-info.h
> +++ b/arch/mips/include/asm/cpu-info.h
> @@ -39,14 +39,14 @@ struct cache_desc {
>  #define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
>  
>  struct cpuinfo_mips {
> -	unsigned int		udelay_val;
> -	unsigned int		asid_cache;
> +	unsigned long		asid_cache;
>  
>  	/*
>  	 * Capability and feature descriptor structure for MIPS CPU
>  	 */
>  	unsigned long		options;
>  	unsigned long		ases;
> +	unsigned int		udelay_val;
>  	unsigned int		processor_id;
>  	unsigned int		fpu_id;
>  	unsigned int		msa_id;
