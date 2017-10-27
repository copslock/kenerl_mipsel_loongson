Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2017 16:37:35 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:50324 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991526AbdJ0OhZlEcuX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Oct 2017 16:37:25 +0200
Received: by mail-oi0-f65.google.com with SMTP id q4so11185401oic.7;
        Fri, 27 Oct 2017 07:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U7szZWYn33z91Fftqim2DxW67wcl2kiXHaVZmr/ZY0A=;
        b=p4+2x756JLcO5CDZPCWjdNS7PklJO8tpKMDlJ10eWsLhO5yYKqZy6YOqjrN+JJeSOy
         txdgIglPTzR5+w5WJU2mGHoIoiskeEuaE+nOeQwpZ82GKB1W8E9Dqg+wM5ff/EjHSpUc
         jaD4guDS3WhofXLHbNSE/4fR0x06suf2s4jFGgY5V+kNmlXdKW8e7Q76I6s+Iu66NBR2
         +a2YueRToIXq89cyyM9x3P94OnmXn9fzMOeXs3uL28uJZ4Xubkyxba6DQ00AQIMM0gJV
         Qkw8vpaP8UcRnVxg6vOLCGFToo8cpGyMH+COV5/s7dpg1vB9n7ayZaAAm82RE/8ECfSF
         Mb9g==
X-Gm-Message-State: AMCzsaWZOcz5I1Azd3dPB70Id21S29UExm8jBz0xb5QZXfBxJHtVJ/1C
        2FnDSmATPVz+hIwI4ZhP4g==
X-Google-Smtp-Source: ABhQp+QGyt/7qXBS3/BCzET2JnDwBE7DJ9Y7xRDcPB0hBkN9WZBVD6e7sRNQfWrGcXXl8HpTIkDcIQ==
X-Received: by 10.202.49.129 with SMTP id x123mr365200oix.14.1509115039480;
        Fri, 27 Oct 2017 07:37:19 -0700 (PDT)
Received: from localhost (mobile-166-176-121-60.mycingular.net. [166.176.121.60])
        by smtp.gmail.com with ESMTPSA id l32sm3976233otb.17.2017.10.27.07.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Oct 2017 07:37:18 -0700 (PDT)
Date:   Fri, 27 Oct 2017 09:37:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/8] PCI: host: brcmstb: add DT docs for Brcmstb PCIe
 device
Message-ID: <20171027130538.lb2hs4umew4cgovv@rob-hp-laptop>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-3-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508868949-16652-3-git-send-email-jim2101024@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60575
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

On Tue, Oct 24, 2017 at 02:15:43PM -0400, Jim Quinlan wrote:
> The DT bindings description of the Brcmstb PCIe device is described.  This
> node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.

"dt-bindings: pci: ..." for the subject please.

> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcmstb-pci.txt        | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pci.txt b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> new file mode 100644
> index 0000000..49f9852
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> @@ -0,0 +1,63 @@
> +Brcmstb PCIe Host Controller Device Tree Bindings
> +
> +Required Properties:
> +- compatible
> +  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
> +  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
> +  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
> +      the 7278).
> +  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
> +
> +- reg -- the register start address and length for the PCIe reg block.
> +- interrupts -- two interrupts are specified; the first interrupt is for
> +     the PCI host controller and the second is for MSI if the built-in
> +     MSI controller is to be used.
> +- interrupt-names -- names of the interrupts (above): "pcie" and "msi".
> +- #address-cells -- set to <3>.
> +- #size-cells -- set to <2>.
> +- #interrupt-cells: set to <1>.
> +- interrupt-map-mask and interrupt-map, standard PCI properties to define the
> +     mapping of the PCIe interface to interrupt numbers.
> +- ranges: ranges for the PCI memory and I/O regions.
> +- linux,pci-domain -- should be unique per host controller.
> +
> +Optional Properties:
> +- clocks -- phandle of pcie clock.
> +- clock-names -- set to "sw_pcie" if clocks is used.
> +- dma-ranges -- Specifies the inbound memory mapping regions when
> +     an "identity map" is not possible.
> +- msi-controller -- this property is typically specified to have the
> +     PCIe controller use its internal MSI controller.
> +- msi-parent -- set to use an external MSI interrupt controller.
> +- brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.

Use the same one already defined for Broadcom SATA phy.

> +- max-link-speed --  (integer) indicates desired generation of link:
> +     1 => 2.5 Gbps (gen1), 2 => 5.0 Gbps (gen2), 3 => 8.0 Gbps (gen3).
> +- xyz-supply -- set to a voltage regulator phandle  that the root
> +     complex should turn off/on/on on suspend/resume/boot.  Any property
> +     matching '-supply' will be added to an internal list of phandles.

Still not really liking this...

> +
> +
> +Example Node:
> +
> +pcie0: pcie@f0460000 {
> +		reg = <0x0 0xf0460000 0x0 0x9310>;
> +		interrupts = <0x0 0x0 0x4>;
> +		compatible = "brcm,pci-plat-dev";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
> +			  0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &intc 0 47 3
> +				 0 0 0 2 &intc 0 48 3
> +				 0 0 0 3 &intc 0 49 3
> +				 0 0 0 4 &intc 0 50 3>;
> +		clocks = <&sw_pcie0>;
> +		clock-names = "sw_pcie";
> +		msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
> +		msi-controller;         /* use PCIe's internal MSI controller */
> +		brcm,ssc;
> +		max-link-speed = <1>;
> +		linux,pci-domain = <0>;
> +	};
> -- 
> 1.9.0.138.g2de3478
> 
