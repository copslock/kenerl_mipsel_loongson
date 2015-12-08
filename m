Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 13:58:28 +0100 (CET)
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34790 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006859AbbLHM60hvIeZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 13:58:26 +0100
Received: by pfbg73 with SMTP id g73so12263265pfb.1;
        Tue, 08 Dec 2015 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cSJLvxffXhPHhlHiSkbWLp2K0noDYHaA0vp8AmZPojs=;
        b=UpYpqFXKmg0wBPSoEoYvylv6tz85DgqBNcJl9/muY4fHUiFPvZMHyJcZ/GZDhnucYx
         8Cr4DhZoaVFoH5VQZtd8eN8mI6OqJOoq8n/iqDq4GquNMgBaAuWFss5Lbxi1hsW6cuae
         wWfGBJCo2u3Ch6Df6Z6dHxVw0esz5D+tcvk0c2iOOfY5GHtXuS/y8hQDaPpNLXFrxDdh
         BFC7+1bT0sgyeM26FR02chryTIoMl3deYZKXvfHXHfqYUuc16pglvftbojuhQHb35DIT
         +CX4S0yC2g18aQODwDPcSLJIl8GoZH24EYbCZU0fgVuaOgjigSfn+sVV3MzFdeg2/P43
         6tTQ==
X-Received: by 10.98.67.68 with SMTP id q65mr4582919pfa.63.1449579500400;
        Tue, 08 Dec 2015 04:58:20 -0800 (PST)
Received: from ShengShiZhuChengdeMacBook-Pro.local ([223.72.67.57])
        by smtp.googlemail.com with ESMTPSA id kr16sm4837340pab.33.2015.12.08.04.58.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Dec 2015 04:58:19 -0800 (PST)
Message-ID: <5666D493.1030604@gmail.com>
Date:   Tue, 08 Dec 2015 21:01:07 +0800
From:   Chen Gang <gang.chen.5i5j@gmail.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mips: mm: fix build failure
References: <1449490164-21029-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1449490164-21029-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen.5i5j@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gang.chen.5i5j@gmail.com
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

On 12/7/15 20:09, Sudip Mukherjee wrote:
> We are having build failure with mips defconfig with the error:
> "MADV_FREE" redefined.
> 
> commit d53d95838c7d introduced uniform values for all architecture but
> missed removing the old value.
> 

What you said is OK to me. For me, one fix patch for all related archs
is enough (need not send several patches for each arch). :-)


Thanks.

> Fixes: d53d95838c7d ("arch/*/include/uapi/asm/mman.h: : let MADV_FREE have same value for all architectures")
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> 
> build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/95309512
> 
>  arch/mips/include/uapi/asm/mman.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> index b0ebe59..ccdcfcb 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -73,7 +73,6 @@
>  #define MADV_SEQUENTIAL 2		/* expect sequential page references */
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define MADV_DONTNEED	4		/* don't need these pages */
> -#define MADV_FREE	5		/* free pages only if memory pressure */
>  
>  /* common parameters: try to keep these consistent across architectures */
>  #define MADV_FREE	8		/* free pages only if memory pressure */
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
