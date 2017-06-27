Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 19:40:09 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:37470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993938AbdF0RkCjN4G0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Jun 2017 19:40:02 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3E680D;
        Tue, 27 Jun 2017 10:39:55 -0700 (PDT)
Received: from leverpostej (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 517DF3F557;
        Tue, 27 Jun 2017 10:39:52 -0700 (PDT)
Date:   Tue, 27 Jun 2017 18:38:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, lorenzo.pieralisi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, will.deacon@arm.com,
        catalin.marinas@arm.com
Subject: Re: [PATCH 1/4] misc: sram: Allow ARM64 to select SRAM_EXEC
Message-ID: <20170627173859.GA5189@leverpostej>
References: <20170626223248.14199-1-f.fainelli@gmail.com>
 <20170626223248.14199-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626223248.14199-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mark.rutland@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.rutland@arm.com
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

On Mon, Jun 26, 2017 at 03:32:42PM -0700, Florian Fainelli wrote:
> Now that ARM64 also has a fncpy() implementation, allow selection
> SRAM_EXEC for ARM64 as well.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Sorr,y but I must NAK this patch.

As mentioned on prior threads regarding fncpy, I do not think it makes
sense to enable this for arm64. The only use-cases that have been
described so far for this are power-management stuff that should live in
PSCI or other secure FW, and have no place in the kernel on arm64.

There are no other users of this functionality, and until there are, I
see no reason to enable this, and risk a proliferation of unnecessary
platform-specific code.

It should be possible to #ifdef-ise the relevant callers of this such
that they can be built on arm64 without using fncpy or sram_exec
functionality. AFAICT, there are no users on arm64 introduced by this
series.

Thanks,
Mark.

> ---
>  drivers/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 07bbd4cc1852..ac8779278c0c 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -464,7 +464,7 @@ config SRAM
>  	bool "Generic on-chip SRAM driver"
>  	depends on HAS_IOMEM
>  	select GENERIC_ALLOCATOR
> -	select SRAM_EXEC if ARM
> +	select SRAM_EXEC if ARM || ARM64
>  	help
>  	  This driver allows you to declare a memory region to be managed by
>  	  the genalloc API. It is supposed to be used for small on-chip SRAM
> -- 
> 2.9.3
> 
