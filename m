Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 22:02:44 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:36787 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdFWUCiLGhEL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 22:02:38 +0200
Received: by mail-it0-f66.google.com with SMTP id 185so8198148itv.3;
        Fri, 23 Jun 2017 13:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7kLoGVZzyoi1HpT2oBsWtdojBLICbKSWLayvDLHeZU=;
        b=RinbwIc2bBkFQbxSgle3hld/dNz6/Cj1/NOT4dk2xJCKPYnOXduxaE7Lf+aVTHu8IR
         X1dZr69mCf1R+wHwyrknN9Fk6H6Yt98jbRI0pRd5q5QXWg0DGb2t61oncHf/lBIxLcjP
         umoVEB9n+ohO0tNpbtKQ9zNgPQhekgkAwH6vvUxmNfnMNZgJt7ctUpQ6qlI/5i/pB/3z
         SxQl97X+IFBHJwelje8cjxvKeK+kVjWZFHY2nLqenFXXsTKhyHPq2dAkBE9TpU/HqI/7
         hFHhy9kgashOrbN3nXzJVBBJgOVfwtMEwd3x3yZ+Q3JGiQonEL1ZZI4X+f8XdqfzgAg5
         QZcw==
X-Gm-Message-State: AKS2vOz6tTbxBmiAfj3td5Gi0TW/KkxDZybjscInOD/egez0LFLVeq25
        HqyDkX2NP7ZLlA==
X-Received: by 10.36.216.130 with SMTP id b124mr9678383itg.46.1498248151504;
        Fri, 23 Jun 2017 13:02:31 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id m141sm3451774itb.4.2017.06.23.13.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Jun 2017 13:02:30 -0700 (PDT)
Date:   Fri, 23 Jun 2017 15:02:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
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
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] dt-bindings: Document MIPS Broadcom STB power
 management nodes
Message-ID: <20170623200229.p6pp4g2hvkei4doj@rob-hp-laptop>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
 <20170616213703.21487-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616213703.21487-5-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58768
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

On Fri, Jun 16, 2017 at 02:37:02PM -0700, Florian Fainelli wrote:
> Document the different nodes required for supporting S2/S3/S5 suspend
> states on MIPS-based Broadcom STB SoCs.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/mips/brcm/soc.txt          | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> index e4e1cd91fb1f..f7413168d938 100644
> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> @@ -11,3 +11,80 @@ Required properties:
>  
>  The experimental -viper variants are for running Linux on the 3384's
>  BMIPS4355 cable modem CPU instead of the BMIPS5000 application processor.
> +
> +Power management
> +----------------
> +
> +For power management (particularly, S2/S3/S5 system suspend), the following SoC
> +components are needed:
> +
> += Always-On control block (AON CTRL)
> +
> +This hardware provides control registers for the "always-on" (even in low-power
> +modes) hardware, such as the Power Management State Machine (PMSM).
> +
> +Required properties:
> +- compatible     : should contain "brcm,brcmstb-aon-ctrl"

Exact same block on all SoCs?

> +- reg            : the register start and length for the AON CTRL block
> +
> +Example:
> +
> +aon-ctrl@410000 {

syscon@...

> +	compatible = "brcm,brcmstb-aon-ctrl";
> +	reg = <0x410000 0x400>;
> +};
> +
> += Memory controllers
> +
> +A Broadcom STB SoC typically has a number of independent memory controllers,
> +each of which may have several associated hardware blocks, which are versioned
> +independently (control registers, DDR PHYs, etc.). One might consider
> +describing these controllers as a parent "memory controllers" block, which
> +contains N sub-nodes (one for each controller in the system), each of which is
> +associated with a number of hardware register resources (e.g., its PHY). See
> +the example device tree snippet below.

What example?

> +
> +== MEMC (MEMory Controller)
> +
> +Represents a single memory controller instance.
> +
> +Required properties:
> +- compatible     : should contain "brcm,brcmstb-memc" and "simple-bus"

No registers for the controller?

> +
> +Should contain subnodes for any of the following relevant hardware resources:
> +
> +== DDR PHY control
> +
> +Control registers for this memory controller's DDR PHY.
> +
> +Required properties:
> +- compatible     : should contain one of these
> +	"brcm,brcmstb-ddr-phy-v64.5"
> +	"brcm,brcmstb-ddr-phy"
> +
> +- reg            : the DDR PHY register range
> +
> +== MEMC Arbiter
> +
> +The memory controller arbiter is responsible for memory clients allocation
> +(bandwidth, priorities etc.) and needs to have its contents restored during
> +deep sleep states (S3).
> +
> +Required properties:
> +
> +- compatible	: should contain one of these
> +	"brcm,brcmstb-memc-arb-v10.0.0.0"
> +	"brcm,brcmstb-memc-arb"
> +
> +- reg		: the DDR Arbiter register range
> +
> +== Timers
> +
> +The Broadcom STB chips contain a timer block with several general purpose
> +timers that can be used.
> +
> +Required properties:
> +
> +- compatible	: should contain "brcm,brcmstb-timers"
> +- reg		: the timers register range
> +
> -- 
> 2.9.3
> 
