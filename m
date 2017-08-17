Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 23:36:43 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35999 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994895AbdHQVggtCufu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 23:36:36 +0200
Received: by mail-oi0-f65.google.com with SMTP id b130so7640443oii.3;
        Thu, 17 Aug 2017 14:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkjNGH2m06m6gKUoJElbpIilF+yJfv9mSUkjFFw2mvY=;
        b=ZxE6GvndRxG4a7YrEYAySw+5GIlhPyti6XceYkHmXrb0rKzAnhSi8dPCPlqJHs+qye
         Mislz6OJf6ME0lERsnxa75If6uUwtLMRF8OIOfGt/HZ71lraVSvRc5PHimYhZI13Nsfs
         fGL0j07DPl1y5gYJgpEOZY/v55BguKPjWgStS82ZrnpKQ6JxWXA4JR9aStUff1LerPrZ
         HxzXuRhNN/4A/taPozLD/JlIQoKSxNphxR83ADVExa8GHxZJRIKO5a7KZZUhGrQ+kAxD
         thC6f/opSJm4qpR4X2PO0vnDCnaQV2YcRpe8xUmaOYB0k6wozHIvX+KY55HDehUXM2nM
         aWPw==
X-Gm-Message-State: AHYfb5gJSJ6KSqLKLe7Yai5j2WoThWZE5AL07dh7y3UeNWHrXIY1onTA
        4/Jdtd4ScGZo8g==
X-Received: by 10.202.92.130 with SMTP id q124mr8088232oib.294.1503005790088;
        Thu, 17 Aug 2017 14:36:30 -0700 (PDT)
Received: from localhost (mobile-166-173-60-17.mycingular.net. [166.173.60.17])
        by smtp.gmail.com with ESMTPSA id i196sm5218356oib.14.2017.08.17.14.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2017 14:36:29 -0700 (PDT)
Date:   Thu, 17 Aug 2017 16:36:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     mark.rutland@arm.com, ralf@linux-mips.org, john@phrozen.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: dts: Add VoCore2 board
Message-ID: <20170817213628.nrkeuek7vu6oebfx@rob-hp-laptop>
References: <1502814773-40842-1-git-send-email-harvey.hunt@imgtec.com>
 <1502814773-40842-2-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502814773-40842-2-git-send-email-harvey.hunt@imgtec.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Tue, Aug 15, 2017 at 05:32:52PM +0100, Harvey Hunt wrote:
> The VoCore2 board is a low cost MT7628A based board with 128MB RAM, 16MB
> flash and multiple external peripherals.
> 
> This initial DTS provides enough support to get to userland and use the USB
> port.
> 
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>  MAINTAINERS                           |  6 ++++++
>  arch/mips/boot/dts/ralink/Makefile    |  1 +
>  arch/mips/boot/dts/ralink/vocore2.dts | 18 ++++++++++++++++++
>  arch/mips/ralink/Kconfig              |  5 +++++
>  4 files changed, 30 insertions(+)
>  create mode 100644 arch/mips/boot/dts/ralink/vocore2.dts
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f7721d..82dcc6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14127,6 +14127,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/vmxnet3/
>  
> +VOCORE VOCORE2 BOARD
> +M:	Harvey Hunt <harveyhuntnexus@gmail.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/boot/dts/ralink/vocore2.dts
> +
>  VOLTAGE AND CURRENT REGULATOR FRAMEWORK
>  M:	Liam Girdwood <lgirdwood@gmail.com>
>  M:	Mark Brown <broonie@kernel.org>
> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> index 2a72259..a191788 100644
> --- a/arch/mips/boot/dts/ralink/Makefile
> +++ b/arch/mips/boot/dts/ralink/Makefile
> @@ -2,6 +2,7 @@ dtb-$(CONFIG_DTB_RT2880_EVAL)	+= rt2880_eval.dtb
>  dtb-$(CONFIG_DTB_RT305X_EVAL)	+= rt3052_eval.dtb
>  dtb-$(CONFIG_DTB_RT3883_EVAL)	+= rt3883_eval.dtb
>  dtb-$(CONFIG_DTB_MT7620A_EVAL)	+= mt7620a_eval.dtb
> +dtb-$(CONFIG_DTB_VOCORE2)		+= vocore2.dtb
>  
>  obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
>  
> diff --git a/arch/mips/boot/dts/ralink/vocore2.dts b/arch/mips/boot/dts/ralink/vocore2.dts
> new file mode 100644
> index 0000000..7591340
> --- /dev/null
> +++ b/arch/mips/boot/dts/ralink/vocore2.dts
> @@ -0,0 +1,18 @@
> +/dts-v1/;
> +
> +#include "mt7628a.dtsi"
> +
> +/ {
> +	compatible = "vocore,vocore2", "ralink,mt7628a-soc";

Is vocore,vocore2 documented?

> +	model = "VoCore2";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x8000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS2,115200";
> +		stdout-path = "serial2:115200";
> +	};
> +};
> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> index 710b04c..c2b2c2d 100644
> --- a/arch/mips/ralink/Kconfig
> +++ b/arch/mips/ralink/Kconfig
> @@ -82,6 +82,11 @@ choice
>  		depends on SOC_MT7620
>  		select BUILTIN_DTB
>  
> +	config DTB_VOCORE2
> +		bool "VoCore2"
> +		depends on SOC_MT7620
> +		select BUILTIN_DTB
> +
>  endchoice
>  
>  endif
> -- 
> 2.7.4
> 
