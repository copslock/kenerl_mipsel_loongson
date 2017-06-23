Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 21:54:42 +0200 (CEST)
Received: from mail-it0-f68.google.com ([209.85.214.68]:36545 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdFWTygG-XXL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 21:54:36 +0200
Received: by mail-it0-f68.google.com with SMTP id 185so8179295itv.3;
        Fri, 23 Jun 2017 12:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PlpvC5NUG+V8j56OwP9o2QWrJFpgxqUhKAGscg1q/CM=;
        b=SgUBXaU/G6EUVy0of3kNhaHUmGyQer5Eqieo0JkgAUPXdp9qmvVvsicyTFXeop73o6
         4d8s7B4DjIn+M854TNO9VOVqnHHYW1nKw1qC3ksOHrQl/iHOWOv5P8NDDRvWbUJdIk7I
         2TpJ/YGB/2LYmrs3QQNsCSeiRNusy/IDQGbA099amAGtZutaxR4DN4KkoKoiDRp1ildW
         oSySLk1VG72SEZkc4WfVQBO9Za3RYWXSjRpbc65oru0tqC2La9nTwK9dT8yQZYFLnJ4B
         I5iFkMZro3rRset3l/uNVNwHLA4KKBEmynQI225muE7VepPqsOYFEk+8BAdGoFsQ2et8
         2ZTg==
X-Gm-Message-State: AKS2vOwvj+Ji0P8qglIbngeUy9oYaLwFGvvcInpTmVRrItdX63IpOwPr
        8/ayhvE8wIogqQ==
X-Received: by 10.36.162.13 with SMTP id j13mr6003309itf.16.1498247670135;
        Fri, 23 Jun 2017 12:54:30 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h133sm3496745ioe.60.2017.06.23.12.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Jun 2017 12:54:29 -0700 (PDT)
Date:   Fri, 23 Jun 2017 14:54:28 -0500
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
Subject: Re: [PATCH 1/5] dt-bindings: Update Broadcom STB binding
Message-ID: <20170623195428.x7ckvni5t5gl4ukx@rob-hp-laptop>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
 <20170616213703.21487-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616213703.21487-2-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58767
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

On Fri, Jun 16, 2017 at 02:36:59PM -0700, Florian Fainelli wrote:
> Update the Broadcom STB binding document with new compatible strings for
> the DDR PHY and memory controller found on newer chips.

The subject should be more specific what this patch is doing.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
> index 0d0c1ae81bed..790e6b0b8306 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
> @@ -164,6 +164,8 @@ Control registers for this memory controller's DDR PHY.
>  
>  Required properties:
>  - compatible     : should contain one of these
> +	"brcm,brcmstb-ddr-phy-v71.1"
> +	"brcm,brcmstb-ddr-phy-v72.0"
>  	"brcm,brcmstb-ddr-phy-v225.1"
>  	"brcm,brcmstb-ddr-phy-v240.1"
>  	"brcm,brcmstb-ddr-phy-v240.2"
> @@ -184,7 +186,9 @@ Sequencer DRAM parameters and control registers. Used for Self-Refresh
>  Power-Down (SRPD), among other things.
>  
>  Required properties:
> -- compatible     : should contain "brcm,brcmstb-memc-ddr"
> +- compatible     : should contain one of these
> +	"brcm,brcmstb-memc-ddr-rev-b.2.2"
> +	"brcm,brcmstb-memc-ddr"
>  - reg            : the MEMC DDR register range
>  
>  Example:
> -- 
> 2.9.3
> 
