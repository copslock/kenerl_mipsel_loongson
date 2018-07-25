Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 19:34:49 +0200 (CEST)
Received: from mail-it0-f65.google.com ([209.85.214.65]:55997 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991947AbeGYRel1voVJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 19:34:41 +0200
Received: by mail-it0-f65.google.com with SMTP id 16-v6so9813231itl.5;
        Wed, 25 Jul 2018 10:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KsA21uuR1f8LdH+jPj1RE73yY6H8fOhFq1FWjDFNXq4=;
        b=FPmG0ElK6gKyNKN1j2ODLsf6grAxxaCZ9bN4xs1VBkvsGjHfuLovkS9QYnbsFEEn1r
         e3G0OxPVASOlp3ERvmD0fxluOQNlYrGUTu9ls6ZRfQISW2pCDloT6hi/EwCisyu0UH3E
         m7VSxO+k/U9q9qlU8AdZHBq3iBAghqaXf97/Q9IXbs7OmhfZoCCyLWrURnm8znyN9zsC
         rQmX9kZE7PGb0fv+dmSNL5BxEqQRiUpiTw7IyFQzTkhlbuZ+Le9E5wOnurrEO+cCwffA
         Lfx1Jm3wnxIdl3+TcO+6mjfViEe8fB4QU6YyS+CXjUyUPlAhoIT1lIcLBTBs47eWFBkM
         fgrQ==
X-Gm-Message-State: AOUpUlFiuf2Z+Nfe4cIlkkbKNNYe1BfjV6wp+HSlYZr0P0ZVwiviUxsO
        bPp0FhGLngtw6tQi5NrdHw==
X-Google-Smtp-Source: AAOMgpeHcWdOGTho/T1oWUW5aOautyNTr7k33oBo+KxcBOoMEHe0A5wUJarLNcKC5UgYFrroHKlHfA==
X-Received: by 2002:a24:b71a:: with SMTP id h26-v6mr7120529itf.37.1532540075353;
        Wed, 25 Jul 2018 10:34:35 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id d12-v6sm2386280itf.44.2018.07.25.10.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:34:34 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:34:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 11/25] dt-bindings: PCI: qcom,ar7240: adds binding doc
Message-ID: <20180725173434.GA17215@rob-hp-laptop>
References: <20180720115842.8406-1-john@phrozen.org>
 <20180720115842.8406-12-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720115842.8406-12-john@phrozen.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65146
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

On Fri, Jul 20, 2018 at 01:58:28PM +0200, John Crispin wrote:
> With the driver being converted from platform_data to pure OF, we need to
> also add some docs.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/pci/qcom,ar7240-pci.txt    | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt b/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> new file mode 100644
> index 000000000000..5379affd4615
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> @@ -0,0 +1,42 @@
> +* Qualcomm Atheros AR724X PCI express root complex
> +
> +Required properties:
> +- compatible: should contain "qcom,ar7240-pci" to identify the core.
> +- reg: Should contain the register ranges as listed in the reg-names property.
> +- reg-names: Definition: Must include the following entries
> +	- "crp_base"	Configuration registers
> +	- "ctrl_base"	Control registers
> +	- "cfg_base"	IO Memory

'_base' is redundant.

Same question as v1 remains: IO or config space? IO space goes in ranges 
and config space goes in reg.

> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- ranges: ranges for the PCI memory and I/O regions
> +- interrupt-map-mask and interrupt-map: standard PCI
> +	properties to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- #interrupt-cells: set to <1>
> +- interrupt-parent: phandle to the MIPS IRQ controller

This property is implied (and could be in a parent node). Sergei pointed 
this out in v1 for the 7100.

> +
> +Optional properties:
> +- interrupt-controller: define to enable the builtin IRQ cascade.
> +
> +* Example for qca9557
> +	pcie-controller@180c0000 {

pcie@...

Also pointed out in v1...

> +		compatible = "qcom,ar7240-pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0x0>;
> +		reg = <0x180c0000 0x1000>,
> +		      <0x180f0000 0x100>,
> +		      <0x14000000 0x1000>;
> +		reg-names = "crp_base", "ctrl_base", "cfg_base";
> +		ranges = <0x2000000 0 0x10000000 0x10000000 0 0x04000000
> +			  0x1000000 0 0x00000000 0x00000000 0 0x00000001>;
> +		interrupt-parent = <&intc2>;
> +		interrupts = <1>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		interrupt-map-mask = <0 0 0 1>;
> +		interrupt-map = <0 0 0 0 &pcie0 0>;
> +	};
> -- 
> 2.11.0
> 
