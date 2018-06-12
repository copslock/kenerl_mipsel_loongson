Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 00:37:41 +0200 (CEST)
Received: from mail-yb0-f195.google.com ([209.85.213.195]:32993 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994657AbeFLWheGAzTP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 00:37:34 +0200
Received: by mail-yb0-f195.google.com with SMTP id x36-v6so225982ybi.0
        for <linux-mips@linux-mips.org>; Tue, 12 Jun 2018 15:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=53kEHG5lKbURjjpkY0ACPI+UlIMLyYbI0CswZHQRbzY=;
        b=pId/c3+byt5iIvfLX0F4Wt4kFYW0TDdKLQwzCPIdhNm7gY59AaArV+02KgFo9AQDk5
         9AnnPXyvUaFrK3Z9cgTeScqWO2h7LJazcokbJTrIACayG0X5LfY5B8fQ2U59AX0ImbBV
         EDCbfdtzB76O5J0vh4iEtj9wiVGj0tLXeqoqS28ot5Dmx4HqDo3suJY/WoDxpuQuWUf8
         E5RbHU2CdVdbQxtVVCzRLsgxFYg3r12j/Wp/VXpNQPqTQK17KaNfbYjZugjGtiQzXA69
         WvraSZbycu9/T2BA79/LQjArEZtlqM9PbMI5XYvb0lf7Gz71DInvhzGnvzApzQTO/nsn
         2j+Q==
X-Gm-Message-State: APt69E1243qqXTQgDg9yP9t8lK/r3QtS0k4j4QKb6BuQgUAQZQSty1D8
        BsWbwXusoKNHKCQDM1r0Bg==
X-Google-Smtp-Source: ADUXVKJ2GuxjiLSG6sD2rq1r/wJef1EFSzOAArwzuF8FsOwdVKaALSxyK2GMsjI5ZWn61SNaNwkdlw==
X-Received: by 2002:a25:5e89:: with SMTP id s131-v6mr1183106ybb.230.1528843048293;
        Tue, 12 Jun 2018 15:37:28 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n204-v6sm516651ywb.72.2018.06.12.15.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:37:27 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:37:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com, linux-mips@linux-mips.org,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/7] clk: intel: Add clock driver for GRX500 SoC
Message-ID: <20180612223725.GC2197@rob-hp-laptop>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-3-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612054034.4969-3-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64250
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

On Tue, Jun 12, 2018 at 01:40:29PM +0800, Songjun Wu wrote:
> From: Yixin Zhu <yixin.zhu@linux.intel.com>
> 
> PLL of GRX500 provide clock to DDR, CPU, and peripherals as show below
> 
>                  +---------+
> 	    |--->| LCPLL3 0|--PCIe clk-->
>    XO       |    +---------+
> +-----------|
>             |    +---------+
>             |    |        3|--PAE clk-->
>             |--->| PLL0B  2|--GSWIP clk-->
>             |    |        1|--DDR clk-->DDR PHY clk-->
>             |    |        0|--CPU1 clk--+   +-----+
>             |    +---------+            |--->0    |
>             |                               | MUX |--CPU clk-->
>             |    +---------+            |--->1    |
>             |    |        0|--CPU0 clk--+   +-----+
>             |--->| PLLOA  1|--SSX4 clk-->
>                  |        2|--NGI clk-->
>                  |        3|--CBM clk-->
>                  +---------+
> 
> VCO of all PLLs of GRX500 is not supposed to be reprogrammed.
> DDR PHY clock is created to show correct clock rate in software
> point of view.
> CPU clock of 1Ghz from PLL0B otherwise from PLL0A.
> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

Need a blank line before the SoB's and not one in the middle.

> ---
> 
>  .../devicetree/bindings/clock/intel,grx500-clk.txt |  46 ++

Please split bindings to separate patch.

>  drivers/clk/Kconfig                                |   1 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/intel/Kconfig                          |  21 +
>  drivers/clk/intel/Makefile                         |   7 +
>  drivers/clk/intel/clk-cgu-api.c                    | 676 +++++++++++++++++++++
>  drivers/clk/intel/clk-cgu-api.h                    | 120 ++++
>  drivers/clk/intel/clk-grx500.c                     | 236 +++++++
>  include/dt-bindings/clock/intel,grx500-clk.h       |  61 ++
>  9 files changed, 1169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
>  create mode 100644 drivers/clk/intel/Kconfig
>  create mode 100644 drivers/clk/intel/Makefile
>  create mode 100644 drivers/clk/intel/clk-cgu-api.c
>  create mode 100644 drivers/clk/intel/clk-cgu-api.h
>  create mode 100644 drivers/clk/intel/clk-grx500.c
>  create mode 100644 include/dt-bindings/clock/intel,grx500-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> new file mode 100644
> index 000000000000..dd761d900dc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> @@ -0,0 +1,46 @@
> +Device Tree Clock bindings for GRX500 PLL controller.
> +
> +This binding uses the common clock binding:
> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +This GRX500 PLL controller provides the 5 main clock domain of the SoC: CPU/DDR, XBAR,
> +Voice, WLAN, PCIe and gate clocks for HW modules.
> +
> +Required properties for osc clock node
> +- compatible: Should be intel,grx500-xxx-clk

These would need to be enumerated with all possible values. However, see 
below.

> +- reg: offset address of the controller memory area.
> +- clocks: phandle of the external reference clock
> +- #clock-cells: can be one or zero.
> +- clock-output-names: Names of the output clocks.
> +
> +Example:
> +	pll0aclk: pll0aclk {
> +		#clock-cells = <1>;
> +		compatible = "intel,grx500-pll0a-clk";
> +		clocks = <&pll0a>;
> +		reg = <0x8>;
> +		clock-output-names = "cbmclk", "ngiclk", "ssx4clk", "cpu0clk";
> +	};
> +
> +	cpuclk: cpuclk {
> +		#clock-cells = <0>;
> +		compatible = "intel,grx500-cpu-clk";
> +		clocks = <&pll0aclk CPU0_CLK>, <&pll0bclk CPU1_CLK>;
> +		reg = <0x8>;
> +		clock-output-names = "cpu";
> +	};
> +
> +Required properties for gate node:
> +- compatible: Should be intel,grx500-gatex-clk
> +- reg: offset address of the controller memory area.
> +- #clock-cells: Should be <1>
> +- clock-output-names: Names of the output clocks.
> +
> +Example:
> +	clkgate0: clkgate0 {
> +		#clock-cells = <1>;
> +		compatible = "intel,grx500-gate0-clk";
> +		reg = <0x114>;
> +		clock-output-names = "gate_xbar0", "gate_xbar1", "gate_xbar2",
> +		"gate_xbar3", "gate_xbar6", "gate_xbar7";
> +	};

We generally don't do a clock node per clock or few clocks but rather 1 
clock node per clock controller block. See any recent clock bindings.

Rob
