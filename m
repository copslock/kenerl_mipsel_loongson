Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 15:52:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013772AbbKMOwPDSzdK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Nov 2015 15:52:15 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5C2D5206B8;
        Fri, 13 Nov 2015 14:52:12 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1F8B2066B;
        Fri, 13 Nov 2015 14:52:10 +0000 (UTC)
Date:   Fri, 13 Nov 2015 08:52:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH_V3 1/4] dt-bindings: MIPS: Document xilfpga bindings and
 boot style
Message-ID: <20151113145208.GA21683@rob-hp-laptop>
References: <1445859057-47665-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1445859057-47665-2-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1445859057-47665-2-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49921
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

On Mon, Oct 26, 2015 at 11:30:54AM +0000, Zubair Lutfullah Kakakhel wrote:
> Xilfpga boots only with device-tree. Document the required properties
> and the unique boot style
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Rob Herring <robh@kernel.org>

> 
> ---
> V2->V3
> minor nitpicks. mips->MIPS. typo. reorder compatible strings in priority
> 
> V1->V2
> 
> Reformatted to 80 char column
> Correct clock phandle description
> Added digilent,nexys4ddr to get more specific about platform
> Added compatible string in example.
> ---
>  .../devicetree/bindings/mips/img/xilfpga.txt       | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/img/xilfpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/img/xilfpga.txt b/Documentation/devicetree/bindings/mips/img/xilfpga.txt
> new file mode 100644
> index 0000000..57e7ee9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/img/xilfpga.txt
> @@ -0,0 +1,83 @@
> +Imagination University Program MIPSfpga
> +=======================================
> +
> +Under the Imagination University Program, a microAptiv UP core has been
> +released for academic usage.
> +
> +As we are dealing with a MIPS core instantiated on an FPGA, specifications
> +are fluid and can be varied in RTL.
> +
> +This binding document is provided as baseline guidance for the example
> +project provided by IMG.
> +
> +The example project runs on the Nexys4DDR board by Digilent powered by
> +the ARTIX-7 FPGA by Xilinx.
> +
> +Relevant details about the example project and the Nexys4DDR board:
> +
> +- microAptiv UP core m14Kc
> +- 50MHz clock speed
> +- 128Mbyte DDR RAM	at 0x0000_0000
> +- 8Kbyte RAM		at 0x1000_0000
> +- axi_intc		at 0x1020_0000
> +- axi_uart16550		at 0x1040_0000
> +- axi_gpio		at 0x1060_0000
> +- axi_i2c		at 0x10A0_0000
> +- custom_gpio		at 0x10C0_0000
> +- axi_ethernetlite	at 0x10E0_0000
> +- 8Kbyte BootRAM	at 0x1FC0_0000
> +
> +Required properties:
> +--------------------
> + - compatible: Must include "digilent,nexys4ddr","img,xilfpga".
> +
> +CPU nodes:
> +----------
> +A "cpus" node is required.  Required properties:
> + - #address-cells: Must be 1.
> + - #size-cells: Must be 0.
> +A CPU sub-node is also required for at least CPU 0. Required properties:
> + - device_type: Must be "cpu".
> + - compatible: Must be "mips,m14Kc".
> + - reg: Must be <0>.
> + - clocks: phandle to ext clock for fixed-clock received by MIPS core.
> +
> +Example:
> +
> +	compatible = "img,xilfpga","digilent,nexys4ddr";
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "mips,m14Kc";
> +			reg = <0>;
> +			clocks	= <&ext>;
> +		};
> +	};
> +
> +	ext: ext {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <50000000>;
> +	};
> +
> +Boot protocol:
> +--------------
> +
> +The BootRAM is a writeable "RAM" in FPGA at 0x1FC0_0000.
> +This is for easy reprogrammibility via JTAG.
> +
> +The BootRAM initializes the cache and the axi_uart peripheral.
> +
> +DDR initialization is already handled by a HW IP block.
> +
> +When the example project bitstream is loaded, the cpu_reset button
> +needs to be pressed.
> +
> +The bootram initializes the cache and axi_uart.
> +Then outputs MIPSFPGA\n\r on the serial port on the Nexys4DDR board.
> +
> +At this point, the board is ready to load the Linux kernel
> +vmlinux file via JTAG.
> -- 
> 1.9.1
> 
