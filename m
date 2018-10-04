Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 10:36:47 +0200 (CEST)
Received: from mail-lf1-x144.google.com ([IPv6:2a00:1450:4864:20::144]:41397
        "EHLO mail-lf1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992087AbeJDIgkUIx1x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2018 10:36:40 +0200
Received: by mail-lf1-x144.google.com with SMTP id q39-v6so6134660lfi.8
        for <linux-mips@linux-mips.org>; Thu, 04 Oct 2018 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/LBR37Lgz421/EYf6/ISCqZcMWY/Q9fZrP8XaeRV5lU=;
        b=i1NtUt4kQE3EC6yNqcIv/4dpnCxZ6RTnYc0J8gP5HAatJTEBZhqPCNHWLKI8fBZzQN
         TliRK8OHjLz/Zy3iPFgbr7Kh+phpYrAgZsP8HJuyvxFFzBWb1QnSuICGxbOOXFy8C5Oe
         iLaDB32GF8vQbNf3twUQfYc+pKNvPAXxGA3KMlXGkrpUcjxYn6n0KpZ48xrUHWVKwskj
         2ST7PFSchPih1AH/8J8NEwn2UHBbZht4FvwCGSZQdj6RBJRvhOugrJH2f72qS9Ho32+p
         l9e/L/aplBHsxr/p0Jc+huWAFBR9rQkqrooDO/H6ThK64opkAvvRx+fCAPpSWTMTxU1m
         Hf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/LBR37Lgz421/EYf6/ISCqZcMWY/Q9fZrP8XaeRV5lU=;
        b=YSq1cUNZ0l+HgG8BEmtmeZFdj/LCKQ2s3gtE27ZIUYZ4Llkd+B59SfYjENhqFlVsqs
         /c1bERnlvqvXLv4gr7g1wkQOR72JHLfueEv6bXzbL3ti3KUg6fCH0ndjmZmssKl19PKv
         HIuU/KLH0kGiwpX/VOVYd5IIM+TfW8zZSOgUNFpJbCtEtqk8uSUpanMyeJQsmsY/oaVH
         ev0o6HpPD0LO73v7B9S2suB26MclBLTPzT7Q+MEgxup1wsO/OxgxPmLvahdet2dzc5WG
         c7EheHcxbyvxX3LZc3PMgyMj68qz3s8qeOYw8J2/1gEv44Y9Xgav8N4u5Xqnrdctwli0
         e8vA==
X-Gm-Message-State: ABuFfog0U4UN5JVTDIUxkfKbQTf7Zcjsz333q3bcbdl/u11YVbGESWYx
        rRiN7SIUI4gPCRJUf27ZjwEL3g==
X-Google-Smtp-Source: ACcGV609knavE19cCsJM8PgqCfDzCAIK36RuWBbVqa735lXN9/pkjg4fFT86dzZSk2VUJaOksG/keQ==
X-Received: by 2002:a19:dd0e:: with SMTP id u14-v6mr3315866lfg.109.1538642194556;
        Thu, 04 Oct 2018 01:36:34 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.83.191])
        by smtp.gmail.com with ESMTPSA id j73-v6sm876345lfg.16.2018.10.04.01.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:36:33 -0700 (PDT)
Subject: Re: [PATCH] mips: delete duplication of BUILTIN_DTB selection
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com>
Date:   Thu, 4 Oct 2018 11:36:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66668
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

Hello!

On 10/3/2018 8:23 PM, Maksym Kokhan wrote:

> CONFIG_BUILTIN_DTB selection is duplicated in menu
> "Machine selection" under MIPS_MALTA.
> 
> Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
> Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
> ---
>   arch/mips/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3551199..71d6549 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -539,7 +539,6 @@ config MIPS_MALTA
>   	select USE_OF
>   	select LIBFDT
>   	select ZONE_DMA32 if 64BIT
> -	select BUILTIN_DTB
>   	select LIBFDT

    LIBFDT seems duplicated too.

[...]

MBR, Sergei
