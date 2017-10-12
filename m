Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 02:55:40 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:56186
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992544AbdJLAzaCeMbl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 02:55:30 +0200
Received: by mail-pf0-x243.google.com with SMTP id 17so2637938pfn.12;
        Wed, 11 Oct 2017 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0e2qN49+C1JuAo2rJ4gXbA363oGgtugDu16YzsVpLqk=;
        b=bCgx5M18pmfyz18rJvLRRfoF6oCprCPuzNYKEQqj+nGQp+FHjnHf2WNaOUoETe29qh
         iagwqhwOPeAOm/3dDsADe0C70QIOyQaQQDB2o04wrU5Q0VQBsRsj1OglfkqurNSZTo2c
         ALmUsskdwdCc4b7qH+p2qQipRXrjcWhz8eB4RJpfs0PoTZYKeqpfyq4gwM/BXImCYpFb
         s/QZW7YVBWi51J4SLHBC0aPsLXaycVZvQn5V5+pI4R8IVzAySC3N6mK3voSiJdGSP7Xt
         IKSZHYpnsDWUCkL65uVdHw6i7wSqg4wDGr2t2d5FXgrhMqndAPEeq7iOqsUKP8IIQtym
         nD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0e2qN49+C1JuAo2rJ4gXbA363oGgtugDu16YzsVpLqk=;
        b=qoc86OMpXWi1kxI84EIXB9P5J4sIVZEbvAPn4mc3Xbb8KeyozFmHWzqPhg2nBvN1Cu
         YZmGbIBOlx9bJgzGSI8vuLy7dpKDYZpjbdPBAp5mF5q8Tnrv2ofQv1qKM2L+wbAR6uKJ
         dBuF6UyWoMmn7JS7GqeaWidakLrE4o3NX107JFy9rdK6js2cE0c++2csEgDh9lE87zcR
         gjxcVnqkU/yd1+ualV2YJWhIf+aPFhFo9B7YqZO/JQO+jQMkyDSn6qe8pJ/6FLlNFPAl
         kMEfghT93ei+EL57Z+DaPOzQQGabls35/33NmFTDVBuG5rpx/pXkCf919G88BAoLEhp2
         oWZQ==
X-Gm-Message-State: AMCzsaXEQtsvH5p8lspnmQvpgMvdrELp3yLQhijb2T9571nUZqnjtEO1
        tfV6aGmLDO7clpSO3FjPv2o=
X-Google-Smtp-Source: AOwi7QCdbV2m+E0Dq32iWzoqalCly0GTW3sr9fdxjxYoRWSM8ZHJG9Sz22yC5K0VhO0CkGHiSImxHg==
X-Received: by 10.98.64.86 with SMTP id n83mr684690pfa.231.1507769723062;
        Wed, 11 Oct 2017 17:55:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:1600:f89c:4a3f:6657:2bee])
        by smtp.gmail.com with ESMTPSA id x11sm24231555pgq.29.2017.10.11.17.55.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 17:55:22 -0700 (PDT)
Date:   Wed, 11 Oct 2017 17:55:20 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 2/9] PCI: host: brcmstb: add DT docs for Brcmstb PCIe
 device
Message-ID: <20171012005520.GA111185@google.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-3-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507761269-7017-3-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Hi Jim,

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
> +  interrupts -- two interrupts are specified; the first interrupt is for
> +      the PCI host controller and the second is for MSI if the built-in
> +      MSI controller is to be used.
> +  interrupt-names -- names of the interrupts (above): "pcie" and "msi".
> +  compatible -- must be one of: "brcm,bcm7425-pcie", "brcm,bcm7435-pcie",
> +      or "brcm,bcm7278-pcie".
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
> +  msi-parent -- if MSI is to be used, this must be a phandle to the
> +      msi-parent.  If this prop is set to the phandle of the PCIe
> +      node, or if the msi-parent prop is missing, the PCIE controller
> +      will attempt to use its built in MSI controller.
> +  msi-controller -- this property should only be specified if the
> +      PCIe controller is using its internal MSI controller.
> +  brcm,ssc -- (boolean) indicates usage of spread-spectrum clocking.
> +  brcm,gen --  (integer) indicates desired generation of link:
> +      1 => 2.5 Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps.

Does this differ from the 'max-link-speed' now documented in
Documentation/devicetree/bindings/pci/pci.txt? If not, might as well use
it, and of_pci_get_max_link_speed().

> +  supply-names -- the names of voltage regulators that the root
> +      complex should turn off/on/on on suspend/resume/boot.  This
> +      is a string list.
> +  supplies -- A collection of phandles to a regulator nodes, see
> +      Documentation/devicetree/bindings/regulator/ for specific
> +      bindings. The number and order of phandles must match
> +      exactly the number of strings in the "supply-names" property.
> +
> +Example Node:
> +
> +pcie0:	pcie@f0460000 {

^^ You've got a tab after the colon. Makes this look funky in my
vim/mutt :)

Brian

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
