Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2018 00:06:06 +0200 (CEST)
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35981 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994061AbeGCWF5qSZ69 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jul 2018 00:05:57 +0200
Received: by mail-yw0-f194.google.com with SMTP id t198-v6so1248631ywc.3;
        Tue, 03 Jul 2018 15:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjNZJADiN3SXuPhWKqSJ4KKjGatmrKZFxO3Wh1iUvLA=;
        b=MC4UgAHKbb+23gZNXr0dsmYxPDcCM6hcQ8oH017d0QT386Lq3XOo8BOaGq3gcGHYLv
         a29UsS7/05VkVN1UoaYg6QRXz2wL2Bs6qQGmBMBYAMzRuUJpuuFMLv8UJhUmRAJYGakj
         lYAKOvCo/4Uca89od+RWp1nuwU0ckzrXlM8kj6rziewTQJRZ/zb5EUTe3zau/YEXvkaj
         6qKDaFZaz7zMAQG4qt3suOoDX8CrAcUlVwoycrA9OTqDnUnH30P3PvlPfe1K+hfC1nKq
         PRZA97fymmKTdSUl2edw48Je54YeljqcHfA4DpT9K5hux77ynej07vB1rDw4Kaffa1On
         CT0w==
X-Gm-Message-State: APt69E31Sa74n75rfmFvVeTAoPw9/KYGj72iDVdlaeBJIFixYKhyBGgw
        AWGHW0+o7/yTGTX0hA9CtA==
X-Google-Smtp-Source: AAOMgpcvJfoCdwB9H6hLvUrv5s2CKoZ7lpN7YDZkDiQAWxdRjcbHVBRmDHmUE3QOpHs2fEKVyden8w==
X-Received: by 2002:a0d:f645:: with SMTP id g66-v6mr15202325ywf.253.1530655551670;
        Tue, 03 Jul 2018 15:05:51 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 204-v6sm754665ywk.86.2018.07.03.15.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:05:50 -0700 (PDT)
Date:   Tue, 3 Jul 2018 16:05:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 10/25] dt-bindings: PCI: qcom,ar7100: adds binding doc
Message-ID: <20180703220549.GA16778@rob-hp-laptop>
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-11-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171549.4618-11-john@phrozen.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64598
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

On Mon, Jun 25, 2018 at 07:15:34PM +0200, John Crispin wrote:
> With the driver being converted from platform_data to pure OF, we need to
> also add some docs.

No need to say "binding" twice in the subject.

> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/pci/qcom,ar7100-pci.txt    | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt b/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> new file mode 100644
> index 000000000000..97be7b0c4cf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,ar7100-pci.txt
> @@ -0,0 +1,36 @@
> +* Qualcomm Atheros AR7100 PCI express root complex
> +
> +Required properties:
> +- compatible: should contain "qcom,ar7100-pci" to identify the core.
> +- reg: Should contain the register ranges as listed in the reg-names property.
> +- reg-names: Definition: Must include the following entries
> +	- "cfg_base"	IO Memory
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- ranges: ranges for the PCI memory and I/O regions
> +- interrupt-map-mask and interrupt-map: standard PCI
> +	properties to define the mapping of the PCIe interface to interrupt
> +	numbers.
> +- #interrupt-cells: set to <1>
> +- interrupt-parent: phandle to the MIPS IRQ controller

You can just omit this. As pointed out it can be inherited from the 
parent. 

> +- interrupt-controller: define to enable the builtin IRQ cascade.

This is mutually exclusive with interrupt-map. At least of_irq_parse_raw 
will never parse interrupt-map if it finds interrupt-controller.

> +
> +* Example for ar7100
> +	pcie0: pcie-controller@180c0000 {

pcie@...

Building your dtb with W=1 (or W=12) will tell you this.

> +		compatible = "qca,ar7100-pci";

qca or qcom as above?

> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x0 0x0>;
> +		reg = <0x17010000 0x100>;
> +		reg-names = "cfg_base";
> +		ranges = <0x2000000 0 0x10000000 0x10000000 0 0x07000000
> +			  0x1000000 0 0x00000000 0x00000000 0 0x00000001>;
> +		interrupt-parent = <&cpuintc>;
> +		interrupts = <2>;
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
