Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 00:24:43 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35920 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012083AbbCCXYjvsPXb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 00:24:39 +0100
Received: by ierx19 with SMTP id x19so63076775ier.3;
        Tue, 03 Mar 2015 15:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XW0U+kNjMGbdUp2I/AqtKlM1D8r2PN9P7V5V7D4ENVM=;
        b=MfUHRzJLQsVF1qC1OPwiAtMgUEsZW2EacKaH80ntYwNp6EpvmT0PXeRT0VhO/cptH9
         a2LoXOnvJ3Xbs2Aw9jnFn5nFHcjE7BYZ3wJBNS1UcenbqEjOOMqq1/s3HtfT3Hmmezca
         JhiD5IiJEJAocnAHzhZ/nXD52GMQjERKDvDJ7RzMUbSVFkqR2YQKtIYM+1HEe6KKIaU4
         c8xGjEKB9+HX9mIQU59EpEYV8NpKltoFGZ9T47dDHNUi2WwLDyuqX+SBgvBAQHY+NFtl
         6Q9VNvJSlRgv/WnaEGwUOunf23NmlFFY0EquIZeRkjGNU/w96QJTwTG3flyzuGupI+k4
         wwbg==
X-Received: by 10.50.80.12 with SMTP id n12mr32185006igx.29.1425425073615;
        Tue, 03 Mar 2015 15:24:33 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id z9sm9636987igw.21.2015.03.03.15.24.31
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Mar 2015 15:24:32 -0800 (PST)
Message-ID: <54F642AE.1020802@gmail.com>
Date:   Tue, 03 Mar 2015 15:24:30 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ben Hutchings <ben@decadent.org.uk>
CC:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3.2 12/24] MIPS: Fix C0_Pagegrain[IEC] support.
References: <lsq.1425420688.25339415@decadent.org.uk>
In-Reply-To: <lsq.1425420688.25339415@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/03/2015 02:11 PM, Ben Hutchings wrote:
> 3.2.68-rc1 review patch.  If anyone has any objections, please let me know.
>

I object!

Because ...

> ------------------
>
> From: David Daney <david.daney@cavium.com>
>
> commit 9ead8632bbf454cfc709b6205dc9cd8582fb0d64 upstream.
>
> The following commits:
>
>    5890f70f15c52d (MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions)
>    6575b1d4173eae (MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions)
>
> break the kernel for *all* existing MIPS CPUs that implement the
> CP0_PageGrain[IEC] bit.  They cause the TLB exception handlers to be
> generated without the legacy execute-inhibit handling, but never set
> the CP0_PageGrain[IEC] bit to activate the use of dedicated exception
> vectors for execute-inhibit exceptions.  The result is that upon
> detection of an execute-inhibit violation, we loop forever in the TLB
> exception handlers instead of sending SIGSEGV to the task.
>
> If we are generating TLB exception handlers expecting separate
> vectors, we must also enable the CP0_PageGrain[IEC] feature.
>
> The bug was introduced in kernel version 3.17.

... I don't think the patch should be applied to versions prior to 3.17

David Daney

>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: http://patchwork.linux-mips.org/patch/8880/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>   arch/mips/mm/tlb-r4k.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -447,6 +447,8 @@ void __cpuinit tlb_init(void)
>   #ifdef CONFIG_64BIT
>   		pg |= PG_ELPA;
>   #endif
> +		if (cpu_has_rixiex)
> +			pg |= PG_IEC;
>   		write_c0_pagegrain(pg);
>   	}
>
>
>
>
>
