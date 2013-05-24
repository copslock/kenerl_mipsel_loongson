Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 18:20:24 +0200 (CEST)
Received: from mail-pb0-f48.google.com ([209.85.160.48]:42785 "EHLO
        mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831921Ab3EXQUTt4IaN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 18:20:19 +0200
Received: by mail-pb0-f48.google.com with SMTP id md12so4383392pbc.21
        for <multiple recipients>; Fri, 24 May 2013 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FfS7RUIhMzLdULeeTV7Tt7umCxEEwxheoaheQV8ZdPo=;
        b=yr6htEELrkdRCKPFxZ5khO8ZWUQmmqwkTRdrWZXLUFVIF4OudpdaRP3Zy8kMvsEd6p
         Q4/QhVeJm7i1XIFGoo2X2/NmfDKv3GfMlrGcgYk2eU4ab6SR5UhsllLzFnhlPP3WEe+k
         raQKqbPWbD9YY/QqGGQ7J0xNqg21yUCj9ULnLYGjR6YsCfH/hL9de+2njWrUDAaKb6VF
         lZu1MKEnJeFg7EqZqcYgfUDHpYKfj7OKd0hCEhM+wWOuBhkF17cvPGXTqfOVfkUGVDcg
         xi1a4QECYmXQYJLJ59U7OrP4N5xVGa6vDc4PGz8NieaxIlYTCz92OMXsUldYJ8eVrER1
         cg/Q==
X-Received: by 10.68.191.36 with SMTP id gv4mr18867097pbc.67.1369412412745;
        Fri, 24 May 2013 09:20:12 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id cc15sm18070156pac.1.2013.05.24.09.20.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 09:20:11 -0700 (PDT)
Message-ID: <519F933A.6020407@gmail.com>
Date:   Fri, 24 May 2013 09:20:10 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Steven J. Hill" <sjhill@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: define cpu_has_mmips where appropriate
References: <1369345335-28062-1-git-send-email-jogo@openwrt.org>
In-Reply-To: <1369345335-28062-1-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36587
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

On 05/23/2013 02:42 PM, Jonas Gorski wrote:
> Disable cpu_has_mmips for everything but SEAD3 and MALTA. Most of these
> platforms are from before the micromips introduction, so they are very
> unlikely to implement it.
>
> Reduces an -Os compiled, uncompressed kernel image by 8KiB for BCM63XX.
>
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>

Acked-by: David Daney <david.daney@cavium.com>
> ---
>
> Position chosen is based on asm/cpu-features.h. Missing hardware and/or
> data sheets for most platforms I obviously couldn't verify its
> non-existence, so maintainer acks are appreciated.
>
>   arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h         |    1 +
>   arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h        |    1 +
>   arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h       |    1 +
>   arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 +
>   arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h        |    1 +
>   arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h          |    1 +
>   arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h          |    1 +
>   arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h          |    1 +
>   arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h          |    1 +
>   arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h        |    1 +
>   arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h      |    1 +
>   arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h      |    1 +
>   arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h  |    1 +
>   arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h       |    1 +
>   arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h |    1 +
>   arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h |    1 +
>   arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h |    1 +
>   arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h       |    1 +
>   arch/mips/include/asm/mach-rm/cpu-feature-overrides.h            |    1 +
>   arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h        |    1 +
>   arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h        |    1 +
>   21 files changed, 21 insertions(+)
>
[...]
