Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2012 18:48:39 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:43741 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903681Ab2DPQsY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2012 18:48:24 +0200
Received: by yhjj52 with SMTP id j52so2850415yhj.36
        for <multiple recipients>; Mon, 16 Apr 2012 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6tfnrA3Un8x+uyjmL814/qEOmm3qgywao5WjVh3U7qA=;
        b=zG5sNEDKaEmXUDvP7gs3bPbGikOEzKvxROsB/BZ4y2rruWE/UsJ80/sA/GacGgwzLL
         qZHgMKXQLJZqHdpwCm2ySN6/Zwqyuj6dnjdwczLboKMd/TfrCFRFfDMDIPUw5mJ/sHdU
         6IVTyBTFzh4LQW0oP1cKcDliBrc4Q+sZ3dV32IKkgjL3d2Mv2fBaKrVoXqLxqYwjYsWM
         f9gdfNiIY5LIPlhRk/zGd5DiLya+HEwt4De6Tvi6JeYc1WpZOmMg350x+yxU8+R2vmdx
         lxSWWLoEJvZRIKUVLuQO8pBYAYwFN1L9Y10YuTH3Qe5mKrAFwSltagaGKrSourYmARnk
         beaw==
Received: by 10.60.1.7 with SMTP id 7mr16736593oei.71.1334594898254;
        Mon, 16 Apr 2012 09:48:18 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id n10sm19910507obu.23.2012.04.16.09.48.15
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 09:48:16 -0700 (PDT)
Message-ID: <4F8C4D4E.4060900@gmail.com>
Date:   Mon, 16 Apr 2012 09:48:14 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang0@gmail.com>
CC:     linux-mips@linux-mips.org, Yong Zhang <yong.zhang@windriver.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: cavium: Don't enable irq in ->init__secondary()
References: <1334561133-19139-1-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1334561133-19139-1-git-send-email-yong.zhang0@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/16/2012 12:25 AM, Yong Zhang wrote:
> From: Yong Zhang<yong.zhang@windriver.com>
>
> Too early to enable irq will break some following action,
> such as notify_cpu_starting().

Can you be more specific about what breaks?

>
> I don't get side effect with this patch.

Without this, where do irqs get enabled on the secondary CPUs?

>
> Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>
> Cc: David Daney<ddaney@caviumnetworks.com>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> ---
>   arch/mips/cavium-octeon/smp.c |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 97e7ce9..7e65c88 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -185,7 +185,6 @@ static void __cpuinit octeon_init_secondary(void)
>   	octeon_init_cvmcount();
>
>   	octeon_irq_setup_secondary();
> -	raw_local_irq_enable();
>   }
>
>   /**
