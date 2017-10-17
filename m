Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 22:24:33 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:48010 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992318AbdJQUY0Io6bg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 22:24:26 +0200
Received: by mail-oi0-f67.google.com with SMTP id h200so5260361oib.4;
        Tue, 17 Oct 2017 13:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ulBFKOjuDJbUF512q04ytmJKJd3E7wUOsljKIU0epR0=;
        b=bzvzP6ZCovKCLy+7EoRe7BM8OuldUR5YTVHL4L0lzgQ2NdIL39teYKYcOB59e3YqJG
         RCnuizt+G7TNos7z1AMSSlUUQdAgwQ79Mt2EDznXRkuYGFgNSp/sRuMNfivuo8TBy2ZQ
         UOHhyKf/GaNfy/bCLl+TF4nGIrpKzvDDQb2KLYSGYIDttxNVQxd3tZ/k5E0e7Wv4Agaa
         SJGa71KaAxIs1P31++zzP5exbRV4ciAlzF36ldfZk1mHheGn3EMKFsRYoOgUdKuLckx3
         81YqWvTonWkkr8B8r/HOYQ1aF279C+ydtaT9+IeyfTaIBJx6ym9lIeC32iiPieG50NH8
         riRw==
X-Gm-Message-State: AMCzsaXSoRHZr/991quwVwb9DFTVUKuQmNsc+v5/fzlBB/5CPdspnG4Y
        R8JJUT3QEpDYYmOYQbmw+g==
X-Google-Smtp-Source: ABhQp+SqlTfsSbWVU6AxDWIRk3rbu+DdRkSylSC/AyYUWTWRtY0mu5nUX2BUmc95G8oxe9T595SMOg==
X-Received: by 10.157.73.131 with SMTP id g3mr2780984otf.451.1508271859744;
        Tue, 17 Oct 2017 13:24:19 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id 5sm5461163ota.14.2017.10.17.13.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 13:24:19 -0700 (PDT)
Date:   Tue, 17 Oct 2017 15:24:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-mips@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/9] PCI: host: brcmstb: add DT docs for Brcmstb PCIe
 device
Message-ID: <20171017202418.ykve2o4zvuwxjdgj@rob-hp-laptop>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-3-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507761269-7017-3-git-send-email-jim2101024@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60435
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

On Wed, Oct 11, 2017 at 06:34:22PM -0400, Jim Quinlan wrote:
> The DT bindings description of the Brcmstb PCIe device is described.  This
> node can be used by almost all Broadcom settop box chips, using
> ARM, ARM64, or MIPS CPU architectures.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../devicetree/bindings/pci/brcmstb-pci.txt        | 106 +++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pci.txt b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> new file mode 100644
> index 0000000..2f699da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcmstb-pci.txt
> @@ -0,0 +1,106 @@
> +Brcmstb PCIe Host Controller Device Tree Bindings
> +
> +Introduction:
> +  The brcmstb host controller closely follows the example set in
> +
> +	[1] http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
> +
> +  The rest of this document explains some added customizations and
> +  offers an example Brcmstb PCIe host controller DT node.
> +
> +Required Properties:
> +  reg -- the register start address and length for the PCIe block.
> +      Additional start,length pairs may be specified for clock addresses.

Kind of vague and why do you need clock addresses and the clock binding?

Also, typically the config space is defined here? Is that missing or you 
don't support memory mapped config space?

> +  interrupts -- two interrupts are specified; the first interrupt is for
> +      the PCI host controller and the second is for MSI if the built-in
> +      MSI controller is to be used.
> +  interrupt-names -- names of the interrupts (above): "pcie" and "msi".
> +  compatible -- must be one of: "brcm,bcm7425-pcie", "brcm,bcm7435-pcie",
> +      or "brcm,bcm7278-pcie".

One compatible per line.

> +  #address-cells -- the number of address cells for PCI-space.
> +  #size-cells -- the number of size cells for PCI-space.
> +  ranges -- See [1]; a specification of the outbound windows for the host
> +      controller.  Each outbound window is described by a n-tuple:
> +          (3 cells) -- PCIe space start address; one cell for attributes
> +                       and two cells for the 64-bit PCIe address.
> +          (x cells) -- CPU/System start address, number of cells is determined
> +                       by the parent node's #address-cells.
> +          (y cells) -- Size of region, number of cells determined by the
> +                       parent node's #size-cells.
> +      Due to hardware limitations, there may be a maximum of four
> +      non-contiguous ranges specified.
> +  #interrupt-cells -- number of cells used to describe the interrupt.

How many cells?

> +  interrupt-map-mask -- see [1]; four cells, the first three are zero
> +      for our uses and the fourth cell is the mask (val = 0x7) for
> +      the legacy interrupt number [1..4].
> +  interrupt-map -- See [1]; there are four interrupts (INTA, INTB,
> +      INTC, and INTD) to be mapped; each interrupt requires 5 cells
> +      plus the size of the interrupt specifier.
> +  linux,pci-domain -- the domain of the host controller.
> +
> +Optional Properties:
> +  clocks -- list of clock phandles.  If specified, this should list one
> +      clock.
> +  clock-names -- the "local" names of the clocks specified in 'clocks'.  Note
> +      that if the 'clocks' property is given, 'clock-names' is mandatory,
> +      and the name of the clock is expected to be "sw_pcie".
> +  dma-ranges -- Similar in structure to ranges, each dma region is
> +      specified with a n-tuple.  Dma-regions describe the inbound
> +      accesses from EP to RC; it translates the pci address that the
> +      EP "sees" to the CPU address in memory.  This property is needed
> +      because the design of the Brcmstb memory subsystem often precludes
> +      idenity-mapping between CPU address space and PCIe address space.
> +      Each range is described by a n-tuple:
> +          (3 cells) -- PCIe space start address; one cell for attributes
> +                       and two cells for the 64-bit PCIe address.
> +          (x cells) -- CPU/System start address, number of cells is determined
> +                       by the parent node's #address-cells.
> +          (y cells) -- Size of region, number of cells determined by the
> +                       parent node's #size-cells.

There's no need to describe standard properties. Just put whatever is 
specific to your platform. That applies throughout this doc.

> +  msi-parent -- if MSI is to be used, this must be a phandle to the
> +      msi-parent.  If this prop is set to the phandle of the PCIe
> +      node, or if the msi-parent prop is missing, the PCIE controller
> +      will attempt to use its built in MSI controller.
> +  msi-controller -- this property should only be specified if the
> +      PCIe controller is using its internal MSI controller.
> +  brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.
> +  brcm,gen --  (integer) indicates desired generation of link:
> +      1 => 2.5 Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps.

We have a standard property for this IIRC.

> +  supply-names -- the names of voltage regulators that the root
> +      complex should turn off/on/on on suspend/resume/boot.  This
> +      is a string list.
> +  supplies -- A collection of phandles to a regulator nodes, see
> +      Documentation/devicetree/bindings/regulator/ for specific
> +      bindings. The number and order of phandles must match
> +      exactly the number of strings in the "supply-names" property.

This is not the regulator binding. Use the standard binding.

> +
> +Example Node:
> +
> +pcie0:	pcie@f0460000 {
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
> +		interrupt-names = "pcie_0_inta",
> +				  "pcie_0_intb",
> +				  "pcie_0_intc",
> +				  "pcie_0_intd";
> +		clocks = <&sw_pcie0>;
> +		clock-names = "sw_pcie";
> +		msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
> +		msi-controller;         /* use PCIe's internal MSI controller */
> +		brcm,ssc;
> +		brcm,gen = <1>;
> +		supply-names = "vreg-wifi-pwr";
> +		supplies = <&vreg-wifi-pwr>;
> +		linux,pci-domain = <0>;
> +	};
> -- 
> 1.9.0.138.g2de3478
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
