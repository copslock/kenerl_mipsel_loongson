Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 23:59:34 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:46466
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeC2V71z8vSz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 23:59:27 +0200
Received: by mail-pf0-x243.google.com with SMTP id h69so4154098pfe.13
        for <linux-mips@linux-mips.org>; Thu, 29 Mar 2018 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sizx/vudgFGM9hUkQbbfRLhJPiwKRTaQH/207nQmySc=;
        b=VtgfdPnI/daIS7ZMSama0x7NeXICVtk1TNg+D7YZ0XttjwH1cA5dFecHE5QyTy+T8/
         JXX9A8/yQfdy2VZoGiLTPM2NlLEnn7xj8blIlvt8gsfB47IJbt4IlSDa5TMst/x6bT9+
         efvnZhP/K/gIi8knI1negS+CJJKTSgHbLAHZeF3rfUA7D5bVwUX2Xht1+G5Kbq5SgZ/H
         rHoEs5RbfDh0sdZWKiKBrJyBBGfaTLzAVyt2ejK7RhwbQUJxoWT1ef+hlBIrIpWi2Zb+
         L5CBHxLOY30sxyXhmYd/I5GDmMs1220KNt0X8QF/5im5kxQrQ9GN7uPKLGloFvXvG0in
         leOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sizx/vudgFGM9hUkQbbfRLhJPiwKRTaQH/207nQmySc=;
        b=SPDll/BsmFkPUhpXbAtkbcr7T772paeQLYv4+Q6JL4dDIOAZhIpuaPveveyzvfsn5a
         0h2CCSffFC+R3KHjKTdE6/lsfO2kP7CRChFBOylqetk4BC6BQLTvhauvkYdNx3pBHD6l
         GbUKvTVdOwOeTpJ7LUm1BCM01xdkwUYOuoOoDvZdK8c+2YM56oBG7nWDW7Xonf3icBB9
         Ee2pY1dukmunub5lmNL9pDB72h3qW3mYm2hSKQucOgz4tqiNKHbJ+/E44nWyiM4RcmY2
         kC4J4rJtsrloeSNdLUkH81h6vP2N7BJAFVDrVZpYIuUo+RzfzlXtukdx3zUimJ+vQgll
         N8Bw==
X-Gm-Message-State: AElRT7HX0sPM4BGNYMo91eNPldxZElUyMRMZfnc65Z7mgK3rqVdClA71
        g0p5RePHpGqy6bz5yoXi/rkUCA==
X-Google-Smtp-Source: AIpwx4+1q+wcZnngGTVUNIoH2TPPWxEBKmzFJWfnVc3Zcagj3akNfaXoQvJUiGThPTqQ8WXnYF4ZCQ==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12-v6mr10362196plk.295.1522360761229;
        Thu, 29 Mar 2018 14:59:21 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m10sm11629223pgd.32.2018.03.29.14.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 14:59:20 -0700 (PDT)
Date:   Thu, 29 Mar 2018 14:59:20 -0700 (PDT)
X-Google-Original-Date: Thu, 29 Mar 2018 14:47:34 PDT (-0700)
Subject:     Re: [PATCH v4 1/3] Add notrace to lib/ucmpdi2.c
In-Reply-To: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
CC:     antonynpavlov@gmail.com, jhogan@kernel.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org, matt.redfearn@mips.com,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     matt.redfearn@mips.com
Message-ID: <mhng-e7e3dffe-bc80-4bea-8cf5-4d8afb76565a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63349
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

On Thu, 29 Mar 2018 03:41:21 PDT (-0700), matt.redfearn@mips.com wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
>
> As part of the MIPS conversion to use the generic GCC library routines,
> Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
> patch rectifies the problem.
>
> CC: Matt Redfearn <matt.redfearn@mips.com>
> CC: Antony Pavlov <antonynpavlov@gmail.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
>   add notrace to lib/ucmpdi2.c
>
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

Ah, thanks, I think I must have forgotten about this.  I assume these three are 
going through your tree?
