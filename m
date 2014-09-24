Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 13:10:43 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:46783 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009593AbaIXLKkjs8R6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 13:10:40 +0200
Received: by mail-la0-f42.google.com with SMTP id hz20so10491101lab.15
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 04:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zB21A5s3SIyy1H2mboLzFXTTv9bgGQi4f4c4E0j9e3M=;
        b=CuzP7YfDL9vmXeVPhSmC9tdzWjia48D4SnDCdWrfoNfNk5q4fzHrUGGPWGBhrdm2Cr
         gXrm8DQVfoxzbREqwff7eUN/J2OW1hnx6YoIhQCRcTKayL/Ff6DHXpsL81IYu2kiG61W
         5lNvhg1rydnMmUbaAprXkGaIKMYxV0lzvlfqcTn9yIUEXOha/TweYJDqFoi15CVR3vt7
         ftHXx/5lHiqFp4Q3mVulk3qPs655sjlgHRXCk0f+oi8BDzuLi8LwIByuBKZhEqV8XabI
         JA/VjxHA1Dgn/odbSA3yseeRPiDiWOH+s8WTWvWEk3nhxoRUGfRtQ5a1ZgPBTRJgsa+t
         qUvw==
X-Gm-Message-State: ALoCoQkrQvVpfk1u3sVo1D2KS5QcD0eFJlSj3qh3QXC0Xd8R8Dcl22r6qhDhqv/K1SYiTy2lusX2
X-Received: by 10.112.218.70 with SMTP id pe6mr5099291lbc.65.1411557034686;
        Wed, 24 Sep 2014 04:10:34 -0700 (PDT)
Received: from [192.168.2.5] (ppp83-237-252-17.pppoe.mtu-net.ru. [83.237.252.17])
        by mx.google.com with ESMTPSA id jf6sm5643971lac.42.2014.09.24.04.10.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Sep 2014 04:10:33 -0700 (PDT)
Message-ID: <5422A696.7080408@cogentembedded.com>
Date:   Wed, 24 Sep 2014 15:10:14 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 05/11] MIPS: clear MSACSR cause bits when handling MSA
 FP exception
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com> <1411551942-11153-6-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1411551942-11153-6-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 9/24/2014 1:45 PM, Paul Burton wrote:

> Much like for traditional scalar FP exceptions, the cause bits in the
> MSACSR register need to be cleared following an MSA FP exception.
> Without doing so the exception will simply be raised again whenever
> the kernel restores MSACSR from a tasks saved context, leading to
> undesirable spurious exceptions. Clear the cause bits from the
> handle_msa_fpe function, mirroring the way handle_fpe clears the
> cause bits in FCSR.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>   arch/mips/kernel/genex.S | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index ac35e12..ae84496 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -367,6 +367,15 @@ NESTED(nmi_handler, PT_SIZE, sp)
>   	STI
>   	.endm
>
> +	.macro	__build_clear_msa_fpe
> +	_cfcmsa	a1, MSA_CSR
> +	li	a2, ~(0x3f << 12)
> +	and	a2, a1
> +	_ctcmsa	MSA_CSR, a1

    Not a2?

> +	TRACE_IRQS_ON
> +	STI
> +	.endm
> +
>   	.macro	__build_clear_ade
>   	MFC0	t0, CP0_BADVADDR
>   	PTR_S	t0, PT_BVADDR(sp)

WBR, Sergei
