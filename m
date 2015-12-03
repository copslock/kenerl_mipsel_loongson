Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 15:24:10 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35390 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012083AbbLCOYIB8ePu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 15:24:08 +0100
Received: by lbcdv4 with SMTP id dv4so2493615lbc.2
        for <linux-mips@linux-mips.org>; Thu, 03 Dec 2015 06:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=N9ksJQn2LqgD6ZSQpl3y00NhSNfa9aK9GpHdfnIX6zE=;
        b=z6BZRW77wO5SCeIBpf/c1nyel/TRnhXtaggGA+gRLg31JPccFgVRmkfCC4RGQl9lfl
         R613DRRMS1/3s1sMQpPz5rHIZVzASZ0HICcr6I3Uf1IdW3xHCXDAdpEQSAsYrzit0v6M
         dtl+uGaok4+sS/j/GTDuQjJ/vKYX1a55nmva4FLMLcs1cM3xSuuzUpVf+CxOL6wwNVEL
         bV8JFaduVS1lNcwprxou5NoWkD2SwD2fkAQnV65zssWe76mJWn55JhDzDIsXMY8To4TW
         89aXiydSiY1DBRG4gDfET+SMc1tMbUCHpu3BXDTtcBShF8D2HHjbI5+ilS/hoiuwYth3
         TTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=N9ksJQn2LqgD6ZSQpl3y00NhSNfa9aK9GpHdfnIX6zE=;
        b=DA3u4iQkQZ3ugHbQ2OgxYDtuhzEXeJaSou8S3fWp9oaBXzlpv4BkBww5w+l1oXVh/Y
         Ht6LDSiYJepiId/mMZPqP+a8ATicnGdIkBye9VyF1mV4rG4PJ2vmOsBGTT1toMLfber7
         G2cveNkZyyiLgksavgJMcC4O//t67DsSV1E6BLQAFfN2apURI+hgEv5xU7LoeuMsMEkK
         11rbv8RxyHyJb5PDP4kkq2S2F3f8+WjpQ3pEaiyB89n56Vz0YdK3ASkJUjN3P5uOAaxD
         vqYatu/KK3eFw8guVdUU2RcSdf7nOr6BmoKtMzz2tbfnEyNloq2TulLMAATbPXdUViOn
         KDsA==
X-Gm-Message-State: ALoCoQk+oKKvbYg9Qebc+EAJOl/w1ieY3HL1OJ/C7wX6nmICtb2r8rTe4o32KUoiBsDSjLjzJ0zw
X-Received: by 10.112.201.132 with SMTP id ka4mr2892868lbc.71.1449152642198;
        Thu, 03 Dec 2015 06:24:02 -0800 (PST)
Received: from [192.168.4.126] ([195.16.110.34])
        by smtp.gmail.com with ESMTPSA id ak1sm1433493lbc.2.2015.12.03.06.24.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Dec 2015 06:24:01 -0800 (PST)
Subject: Re: [PATCH 6/9] MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
To:     Matt Redfearn <matt.redfearn@imgtec.com>, linux-mips@linux-mips.org
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
 <1449137297-30464-7-git-send-email-matt.redfearn@imgtec.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56605081.5050307@cogentembedded.com>
Date:   Thu, 3 Dec 2015 17:24:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1449137297-30464-7-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50317
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

On 12/3/2015 1:08 PM, Matt Redfearn wrote:

> If CONFIG_RELOCATABLE is enabled, jump to relocate_kernel.
>
> This function will return the entry point of the relocated kernel if
> copy/relocate is sucessful or the original entry point if not. The stack
> pointer must then be pointed into the new image.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>   arch/mips/kernel/head.S | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index 4e4cc5b9a771..7dc043349d66 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -132,7 +132,27 @@ not_found:
>   	set_saved_sp	sp, t0, t1
>   	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
>
> +#ifdef CONFIG_RELOCATABLE
> +	/* Copy kernel and apply the relocations */
> +	jal		relocate_kernel
> +
> +	/* Repoint the sp into the new kernel image */
> +	PTR_LI		sp, _THREAD_SIZE - 32 - PT_SIZE
> +	PTR_ADDU	sp, $28

    Can't you account for it in the previous PTR_LI?

> +	set_saved_sp	sp, t0, t1
> +	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
[...]

MBR, Sergei
