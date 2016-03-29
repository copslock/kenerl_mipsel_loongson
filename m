Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 03:35:58 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35996 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007881AbcC2Bf4rr8Tj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 03:35:56 +0200
Received: by mail-ob0-f174.google.com with SMTP id m7so801689obh.3;
        Mon, 28 Mar 2016 18:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pVBvEZoQ2asXslfgtWqpEzadvKiZfPRz4BscTOXtDFw=;
        b=PT06yiYCwf2xelC5xb5AjB+y9FtI3SODEUDX+G2j+PlIF+TbEDufhRoEtini9OwLFW
         LJH9p0FkZ5C/gFoZO/bNGZJ5TzuF8G2zkMZUN8bBhr1TecAnbitaTRgetPXV42nQ5LWM
         1Cno1urEexXPrFa+u+te66FwreNY1ofhlfoYoiUqiADlm3XDyIHytzdG/8NeJk5ZUvDK
         8XIUUHROFlaMVpjXWcdi9TZtxJPJToT/SgFaz1QtD3UEgOZBM+AJh1Ake5VBVa+aXkCO
         JLw95rgOu1wqqrDIVT1+ycqeypdIdPK5qMbhNa1YDC/zIzIl0ArzZlD/YjC5wos2cSrq
         bSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pVBvEZoQ2asXslfgtWqpEzadvKiZfPRz4BscTOXtDFw=;
        b=cBPXAoM6c0zowsd5QYV9HiAswhUC9oI5Bthg8+xD+laNvnRd41e68bevXRju0xTxT1
         scdahPU0uTYU50peLLZxe1vUjEJifU7XWg+C6h7qKDi63oKTKwWrkFwmkNrjEWKaf6Cv
         rqWB15hvwVGEaC8ffBO2LGfQHvY7stp+j/9oxavfmoaiITFCJnN2+1ZNaH2p1Eg4KESE
         dex2gDmV81hKZ4e5F1pmJ0Knyeb32Vq8iiNWLvILOrY9e5B+K/VrFXv3qpBDSDSDX8Am
         xAA+mbLjc7wcpJpaQtCkF44v23JYuWdcSVPgY74vQOEdOEwG9pGsn/3mhLgfTJ64AjKz
         /+/w==
X-Gm-Message-State: AD7BkJLA8uFh+WS5TSMbIIRrfRHZZ1xh2weUoKkMew3h8KUlw7TRbSx705Vi7FDaXS63Iw==
X-Received: by 10.182.24.8 with SMTP id q8mr13205606obf.67.1459215349537;
        Mon, 28 Mar 2016 18:35:49 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:2903:38c6:7796:9ae1? ([2001:470:d:73f:2903:38c6:7796:9ae1])
        by smtp.googlemail.com with ESMTPSA id 94sm8629580ots.21.2016.03.28.18.35.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2016 18:35:48 -0700 (PDT)
Subject: Re: [PATCH 0/6] MIPS: BMIPS: Random fixes for BMIPS5000/5200
To:     linux-mips@linux-mips.org
References: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56F9DBF3.5060309@gmail.com>
Date:   Mon, 28 Mar 2016 18:35:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 29/01/2016 21:17, Florian Fainelli a écrit :
> Hi all,
> 
> This patch series contains a bunch of fixes for the BMIPS5000 processor class.
> 
> The first 4 patches are addressing some functional and cosmetic issues, while
> the last 2 patches fix the existing code to support BMIPS5200 processors.
> 
> Kevin, Jon, Jonas, please review!
> 
> These were tested on BCM7425 and BCM7435.
> 
> BMIPS5200 SMP patches will be submitted on top of this patch series

Ralf, can you queue these patches for 4.6? Thank you!

> 
> Florian Fainelli (6):
>   MIPS: BMIPS: BMIPS5000 has I cache filing from D cache
>   MIPS: BMIPS: Clear MIPS_CACHE_ALIASES earlier
>   BMIPS: BMIPS: local_r4k___flush_cache_all needs to blast S-cache
>   MIPS: BMIPS: Add cpu-feature-overrides.h
>   MIPS: BMIPS: Pretty print BMIPS5200 processor name
>   MIPS: BMIPS: Fix PRID_IMP_BMIPS5000 masking for BMIPS5200
> 
>  .../include/asm/mach-bmips/cpu-feature-overrides.h |   14 ++++++++++++++
>  arch/mips/kernel/bmips_vec.S                       |    9 +++++++--
>  arch/mips/kernel/cpu-probe.c                       |    5 ++++-
>  arch/mips/mm/c-r4k.c                               |   13 +++++++++++--
>  4 files changed, 36 insertions(+), 5 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h
> 


-- 
Florian
