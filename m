Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2018 03:34:48 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:52710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994626AbeDFBelTL6Xd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2018 03:34:41 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 766806081B; Fri,  6 Apr 2018 01:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522978474;
        bh=34v6SXWpP8Vzfv7iQcsdoIDgGYEUWjUInnSMnkoV26w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iWdOw430WazP1Set4sfbNgX1jgTTj7OvQCxQmpN4yGVlXYOkrMQmPQ+XMBonSmwFY
         NbccUnwyJOX7R/CMzOqGdB8Hvg/Zg54Ks5jPMULHOwN7yB8pd+93UHepOJwtWlLaec
         I0wrmFq1y/x3fS0QVTPT1Lcxk7ZLSKc/0GfRnXoc=
Received: from [192.168.0.105] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B79DA60274;
        Fri,  6 Apr 2018 01:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1522978473;
        bh=34v6SXWpP8Vzfv7iQcsdoIDgGYEUWjUInnSMnkoV26w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KOy+EwgeXu0X83sPVFmcur52Ybfs9rjEfEw5I0I+oEAfGLJf9GX8lOSvuqWXJsCxZ
         +qjKl9E+mGprTaetmUiNVFbKAlSILNnh+qLQWucJzxKiurx9ucIz6AlgPIhVf19Fsh
         SJT5rR1tdUEwp5tpg7WfKmW9BpuNA8j/gBs0+Tqw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B79DA60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
Date:   Thu, 5 Apr 2018 21:34:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

On 4/3/2018 8:55 AM, Sinan Kaya wrote:
> While a barrier is present in writeX() function before the register write,
> a similar barrier is missing in the readX() function after the register
> read. This could allow memory accesses following readX() to observe
> stale data.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index fd00ddaf..6ac502f 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -377,6 +377,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
>  		BUG();							\
>  	}								\
>  									\
> +	rmb();								\
>  	return pfx##ioswab##bwlq(__mem, __val);				\
>  }
>  
> 

Can we get these merged to 4.17? 

There was a consensus to fix the architectures having API violation issues.
https://www.mail-archive.com/netdev@vger.kernel.org/msg225971.html


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
