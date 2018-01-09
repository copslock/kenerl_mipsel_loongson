Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2018 04:13:54 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:33390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990403AbeAIDNrYGEUM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Jan 2018 04:13:47 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9837B60BEA; Tue,  9 Jan 2018 03:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515467624;
        bh=qDmadMIpbbSNwDjLeXmAPKUnirVBzkl+XuhZLBfDG9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EACt1qTUxC+q6/WrRWKatZc+SKKGa3Gk8P2jSneczFrHs81nPJtDBIim0ZpJsUKbI
         T7giKanW40RTTsKwtrGULygJalEf8to0poyIWEHMrt5V6RPUqZNc4Ojx0achRQaWOd
         mMe3HuoSbt08rJSojVKfDmhAJMGG4eimmVyBEizw=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA26D6034E;
        Tue,  9 Jan 2018 03:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515467623;
        bh=qDmadMIpbbSNwDjLeXmAPKUnirVBzkl+XuhZLBfDG9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CaSD8Xagm9ls9G66PxhEy5W0fs+FE8NYbQzSV5CsqTgn+C+zXDVwdcB/Wb4hoXlkI
         O671cD0fqdANV8WAuRDyTJWE4wvAZ1sf65r7r1ge1SAvNTPv6XH2r+M7ewEAiLZQFT
         luRKpcDvBSY7gz1kcTRR7uktQk73kv8CdAvd0cGY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA26D6034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Mon, 8 Jan 2018 21:13:39 -0600
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patches@groups.riscv.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/67] hexagon: remove unused flush_write_buffers
 definition
Message-ID: <20180109031339.GA4196@codeaurora.org>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171229081911.2802-7-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <rkuo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkuo@codeaurora.org
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

On Fri, Dec 29, 2017 at 09:18:10AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/include/asm/io.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 66f5e9a61efc..9e8621d94ee9 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -330,8 +330,6 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
>  	}
>  }
>  
> -#define flush_write_buffers() do { } while (0)
> -
>  #endif /* __KERNEL__ */
>  
>  #endif
> -- 
> 2.14.2
> 

For Hexagon:

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
