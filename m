Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2018 00:08:44 +0200 (CEST)
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41858 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994061AbeGCWIf5UH79 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jul 2018 00:08:35 +0200
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so1323793ybe.8;
        Tue, 03 Jul 2018 15:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4sCzML10BLdyq+VcEb0fJSfsYqFicxaXW8+MDrlhdu4=;
        b=SUl8g20H4ckwoOUTMA4p5N9KVart9tdrHdPGBalLtahApPX5jMrOtjTXCTjDE9yoI6
         d7DR3k51n2YgnlOFuDaIYDz6zki+PLykK1UzhmYmdHJjaDLHV2osV1A7z9xWqh1jlvPw
         tzhWHPsxhdw7ijAOUP96H/yWQ7Tmu/tWC4hMOei+7fMFYONwSpiGZN5ZvA8NF0E3pJEN
         fpg3gU1y2dygMbWLSWE+v90y5iYCVxzzJl5gBLxb7gPXvg84EpRcFMIV+oLqAwnQDwRt
         JCFK4S370jG76B84UDN+XCJVRbJgzpwy/KEnjvr7HkvpThW7UBTi/nIgB4fAc4qhYjLI
         vxWg==
X-Gm-Message-State: APt69E1NqEih007j2Mt7/tNJwdeVrb5qB/+kWligQkcnP2STQICJ/mv2
        1u/YVg/UvtBOa9W9Hh7SCQ==
X-Google-Smtp-Source: AAOMgpdU/PIoKFBnjH7I88ffBszQneRwxWHagyGowfI4qIdKj141ktBLg9wiLEb59YUw+SHEOIw0TQ==
X-Received: by 2002:a25:ef04:: with SMTP id g4-v6mr12565556ybd.223.1530655710084;
        Tue, 03 Jul 2018 15:08:30 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id a68-v6sm956195ywh.12.2018.07.03.15.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:08:29 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:08:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 12/25] dt-bindings: PCI: qcom,ar7240: adds binding doc
Message-ID: <20180703220826.GA3230@rob-hp-laptop>
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-13-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171549.4618-13-john@phrozen.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64599
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

On Mon, Jun 25, 2018 at 07:15:36PM +0200, John Crispin wrote:
> With the driver being converted from platform_data to pure OF, we need to
> also add some docs.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/pci/qcom,ar7240-pci.txt    | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt b/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> new file mode 100644
> index 000000000000..7f6ca8a0f859
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
> @@ -0,0 +1,40 @@
> +* Qualcomm Atheros AR724X PCI express root complex
> +
> +Required properties:
> +- compatible: should contain "qcom,ar7240-pci" to identify the core.
> +- reg: Should contain the register ranges as listed in the reg-names property.
> +- reg-names: Definition: Must include the following entries
> +	- "crp_base"	Configuration registers
> +	- "ctrl_base"	Control registers
> +	- "cfg_base"	IO Memory

IO or config space? IO space goes in ranges and config space goes 
in reg.

Same comments as 7100 below.

> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- ranges: ranges for the PCI memory and I/O regions
> +- interrupt-map-mask and interrupt-map: standard PCI
> +	properties to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- #interrupt-cells: set to <1>
> +- interrupt-parent: phandle to the MIPS IRQ controller
> +- interrupt-controller: define to enable the builtin IRQ cascade.
> +
> +* Example for qca9557
> +	pcie0: pcie-controller@180c0000 {
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
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
