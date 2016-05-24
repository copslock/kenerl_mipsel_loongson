Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 20:10:24 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35510 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030121AbcEXSKWIQaAP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 20:10:22 +0200
Received: by mail-pa0-f65.google.com with SMTP id gp3so2767558pac.2;
        Tue, 24 May 2016 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=6e/mJ1HwgxLi9w5ePnxFB3Tz4f7w34uJxtJG6hWYHXw=;
        b=wjMEL5g3LtwTMpHEhO529bqDtUbUZeCe6DTNXRSdPhRUsIUzj90aus5rZ583t54qwQ
         nwSGsLUQlL1ZInwYkhAakYDgzpJay8ks7yECUswsehYlQkIqgL9lv5Lb1JOZsmpl75lL
         49tMDr1wQOqFKAVH52eDoFAMC/SIyJt4dkSnINtJf7JkEShjQulbkUIx1HTFQzVHXUi5
         31JXUrg6b1vFvxAPlIly4HT/MrLAqIq9sSq8UzGXl0cRD4gUDNLauWyAQxlcrlrm2K+t
         l25Bdjkm0yNQhwECtHGTfgNXxrs9YB7bHuBOFEZvDz9NcYz+2R+AgQUnaLIrBT1h7M/b
         b2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=6e/mJ1HwgxLi9w5ePnxFB3Tz4f7w34uJxtJG6hWYHXw=;
        b=MxHpS/KNzXXohgjXZbDEKB+MyJun+Y4SGkC1JF2BkDpY/A5Bske90qh+mz+BJmkK97
         JhaiolThcHiKgAS/Bv4ncVTVdrMuxK8qIszBELccIKemaHlx3arT2xFCeiL8mnC9VlIP
         G3KL6jlsUKbjSeji2nu1ZXkQYEw8i4+Gmc665xf/6PUhpVWfeorlyJGvJPnMFruDiy5K
         +0HITLATW1orcqDioldrgS4xrQYwwPfB7ToJGEN6S250AN3aJLid3ekaSKhddvGhI1mJ
         uwP87Zx68xKUozDG5L8MT7ic7eyUXI4l4QWov216K11R1KxRv+tkb4KkbAq46Ang67Xn
         ScgA==
X-Gm-Message-State: ALyK8tL7BPIrfA2UkP+0b+NZuR4k+t2sJ+XFcm4MXy0Z2VIg7hoVTUZ7924YkB0rrpAGrQ==
X-Received: by 10.67.30.193 with SMTP id kg1mr8782845pad.83.1464113415963;
        Tue, 24 May 2016 11:10:15 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id l67sm23139595pfi.10.2016.05.24.11.10.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 11:10:15 -0700 (PDT)
Message-ID: <57449906.6050407@gmail.com>
Date:   Tue, 24 May 2016 11:10:14 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org,
        Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>
Subject: Re: [PATCH 1/2] MIPS: OCTEON: take all memory into use by default
References: <1464098971-9362-1-git-send-email-aaro.koskinen@nokia.com>
In-Reply-To: <1464098971-9362-1-git-send-email-aaro.koskinen@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53646
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

On 05/24/2016 07:09 AM, Aaro Koskinen wrote:
> Take all memory into use by default, instead of limiting to 512 MB.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks for doing this.  I haven't tested it, but I think it is a good idea:

Acked-by: David Daney <david.daney@cavium.com>


> ---
>
> 	This supersedes this patch: http://marc.info/?t=146401648900005&r=1&w=2
>
>   arch/mips/cavium-octeon/setup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index cd7101f..53c1234 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -49,7 +49,7 @@ extern struct plat_smp_ops octeon_smp_ops;
>   extern void pci_console_init(const char *arg);
>   #endif
>
> -static unsigned long long MAX_MEMORY = 512ull << 20;
> +static unsigned long long MAX_MEMORY = ULLONG_MAX;
>
>   DEFINE_SEMAPHORE(octeon_bootbus_sem);
>   EXPORT_SYMBOL(octeon_bootbus_sem);
>
