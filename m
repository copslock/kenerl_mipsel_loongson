Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 15:45:39 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37585 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026159AbbD0Nphs9VZ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 15:45:37 +0200
Received: by widdi4 with SMTP id di4so90522236wid.0
        for <linux-mips@linux-mips.org>; Mon, 27 Apr 2015 06:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7hay39ZC4k0owqh7fGmUYRNUSSgN81DDovLc6sCjrLY=;
        b=Nt0okju2ZzpaZYDHZSmuifV2Fe48YSL5tRd53AemIyyWcOIzETNDPxXeSRioPOxoEy
         c6jpSKiTC8t2XvHNTZBTpLFSovbbN/7T/eG8UPIBfiRuL+OuJbBiJqlAGooTf3htx4TR
         kKmYaMguzFtgmf9DdF1gPdThTb0vlWuNJkR/o+YH5D//mpkvzFomk+mpPUqTmPbSMpTz
         25huxz081iuzMTnG1XfxxL4U3uWWmsEu82JST89xQvbPuBF5hB9/92K1IFqcup6zWuRn
         W/AIs28XUbv/YxqfukcyOcweyar1yGqBWxnn7vP/HylRhmIMoBfYv8FFt5y9BbKyhvUp
         JCmQ==
X-Gm-Message-State: ALoCoQn8BL6wZBKda2OkUTmWTJ4ruanejwIsXJBCyO2T/GGR4lQzlwBF4ViQCvQFClqWCJQGCLRX
X-Received: by 10.194.248.132 with SMTP id ym4mr23361118wjc.74.1430142334191;
        Mon, 27 Apr 2015 06:45:34 -0700 (PDT)
Received: from [192.168.0.45] ([190.2.108.156])
        by mx.google.com with ESMTPSA id fu2sm11694914wic.20.2015.04.27.06.45.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2015 06:45:33 -0700 (PDT)
Message-ID: <553E3CC8.3070304@vanguardiasur.com.ar>
Date:   Mon, 27 Apr 2015 10:42:32 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Organization: VanguardiaSur
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] MIPS: ath79: Add OF support and DTS for TL-WR1043ND
References: <1429875679-14973-1-git-send-email-albeu@free.fr>
In-Reply-To: <1429875679-14973-1-git-send-email-albeu@free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

On 04/24/2015 08:41 AM, Alban Bedel wrote:
> This series add OF bindings and code support for the interrupt
> controllers, clocks and GPIOs. However it was only tested on a
> TL-WR1043ND with an AR9132, others SoCs are untested, and a few are
> not supported at all.
> 
> Most code changes base on the previous bug fix series:
> [PATCH v2 0/5] MIPS: ath79: Various small fix to prepare OF support
> 
> The requested patch to move the GPIO driver to drivers/gpio is ready and
> will follow once it is clearer if this serie get merged.
> 
> ChangeLog:
> v2: * Fixed the OF bindings and DTS to use ePAPR standardized names
>     * Fixed the typos in the OF bindings
>     * Added an ngpios property to the GPIO binding and driver
>     * Removed all the soc_is_xxx() calls out of the GPIO driver probe()
>     * Updated the DTS patches to the new directory structure and merged both
>       in one. Having 3 patches to add Makefile, SoC dtsi and board DTS seemed
>       a bit overkill.
>     * Moved the patch to use the common clk API to the bug fix serie to keep
>       this one cleaner.
> 
> v3: * Moved the builtin DTB menu to the patch adding the TL-WR1043ND DTS
>     * Made the builtin DTB menu optional
>     * Fixed more typos
>     * Really fixed the DDR controller binding example to use ePAPR names
>     * Fixed the qca9550 compatible string in the PLL bindings and driver
>     * Fixed the example in the GPIO controller binding
>     * Moved the new vendor entry to the correct place
> 
> Alban Bedel (12):
>   devicetree: Add bindings for the SoC of the ATH79 family
>   MIPS: ath79: Add basic device tree support
>   devicetree: Add bindings for the ATH79 DDR controllers
>   devicetree: Add bindings for the ATH79 interrupt controllers
>   devicetree: Add bindings for the ATH79 MISC interrupt controllers
>   MIPS: ath79: Add OF support to the IRQ controllers
>   devicetree: Add bindings for the ATH79 PLL controllers
>   MIPS: ath79: Add OF support to the clocks
>   devicetree: Add bindings for the ATH79 GPIO controllers
>   MIPS: ath79: Add OF support to the GPIO driver
>   of: Add vendor prefix for TP-Link Technologies Co. Ltd
>   MIPS: Add basic support for the TL-WR1043ND version 1
> 

Hi Alban,

I've booted a Carambola2 using this (plus a custom devicetree and some
small changes):

Tested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Just a small comment/question: Shouldn't we allow to build all the
devicetree files, instead of just the one that will be built-in?

I.e., something like this:

dtb-$(CONFIG_MATCH_ATH79_DT)   += ar9132_tl_wr1043nd_v1.dtb
dtb-$(CONFIG_MACH_ATH79_DT)    += ar9331_carambola2.dtb

It should be useful to catch errors, but also in general, as the
devicetree is supposed to be independent of the kernel and should be
built separate from it.

PS: This series depends on a previous patchset. It's usually useful to
mention this in the cover letter and make a poor tester's life easier :)

Thanks for the work,
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
