Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2018 18:27:53 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:43790
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992818AbeBHR1qa0-qC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2018 18:27:46 +0100
Received: by mail-pf0-x244.google.com with SMTP id b62so1982429pfk.10
        for <linux-mips@linux-mips.org>; Thu, 08 Feb 2018 09:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jVKm1m7/aXCf73AvdgaKcbkQ9pb6qRSVuLao4GnIe44=;
        b=lDm6S+mGnjjV+6u2riVeAeMuOFKRvLOShRRxs6s/bHj99T0v5M44Vmp3dpL0O0zF0I
         hP2mlpqA/c4QTNwwhfHB3r7Z1DNb5e6Gnuv+3VuFMBA15vkYDaUuielLil0vu6FliJ7p
         XH4sqeMqgFQS4wfEQ3O0K8vLFFJfNv0XYEfgHS9Fadb+IoKRSl6F++g/8wa7cxvlJvyF
         /i2WL5IZKivFl5FMuO5BCSWXpu1r+yjXH6+2aF97MCz4AJ6nlC7Xrcjk9g6lHfRb0ihf
         HT3TeCzKwKSnS5+1JdT2ZlajMhNPvrsY5gBTHTxjqOBjAPYM8Xblyib608LigletvhME
         te6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jVKm1m7/aXCf73AvdgaKcbkQ9pb6qRSVuLao4GnIe44=;
        b=sM3lXmrWfCPRPAYUX953vCjRMvOqCAHCY5Jg4MZcXFnghG0IpSmiYnAED4LJu2NeaV
         b3w+0GIOlkADKxHXhWFX3u5QCxL0GjJ547uywda82dF3L5NJEg5mOnuW96FvxqD3eUhN
         z/FKvn9ciGX5dbri17/rv918dd6dntYtrKLh2hCuhl48zmM38nUOf5dx2MmGt5aReFd3
         whZNwRjlBsNLzV+ihcbx78z1ywLir4MxQQbsDJtTZkoilGlptdfx+4TXGvKLLHZ05wkR
         aWJUE0k3f2SE4o4ut93AFj6+/+l9xgJAxgEWtrRLGYFhFYCCsaQ6LUVXH4GPJVHPDSq4
         dKMA==
X-Gm-Message-State: APf1xPBa5gVtvlxSf3bUVb8naADG1RspqmHwYpVLgxQnqb6KgQQd0VhO
        5mQGtKZRfb9iJqxn+0z8obf/FEqSxX8=
X-Google-Smtp-Source: AH8x226EeYa71KPJLqfqlRPMe2U/dL2iGAbK10BMVOEozLGHgs3n5nU2TNrZ7TCd7ehixuMg65Hadw==
X-Received: by 10.101.76.2 with SMTP id u2mr1055506pgq.363.1518110859690;
        Thu, 08 Feb 2018 09:27:39 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l84sm1169261pfb.153.2018.02.08.09.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 09:27:38 -0800 (PST)
Date:   Thu, 08 Feb 2018 09:27:38 -0800 (PST)
X-Google-Original-Date: Thu, 08 Feb 2018 09:27:30 PST (-0800)
Subject:     Re: [PATCH v2 1/2] Add notrace to lib/ucmpdi2.c
In-Reply-To: <20180130224202.7682-2-antonynpavlov@gmail.com>
CC:     linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, matt.redfearn@mips.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     antonynpavlov@gmail.com
Message-ID: <mhng-58c9bb50-e7d0-4b58-81ed-bf77161f9ec3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Tue, 30 Jan 2018 14:42:01 PST (-0800), antonynpavlov@gmail.com wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
>
> As part of the MIPS conversion to use the generic GCC library routines,
> Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
> patch rectifies the problem.
>
> CC: Matt Redfearn <matt.redfearn@mips.com>
> CC: Antony Pavlov <antonynpavlov@gmail.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  lib/ucmpdi2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
> index 25ca2d4c1e19..597998169a96 100644
> --- a/lib/ucmpdi2.c
> +++ b/lib/ucmpdi2.c
> @@ -17,7 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/libgcc.h>
>
> -word_type __ucmpdi2(unsigned long long a, unsigned long long b)
> +word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>  {
>  	const DWunion au = {.ll = a};
>  	const DWunion bu = {.ll = b};

Thanks for submitting this, I've gotten quite a bit behind due to FOSDEM.
