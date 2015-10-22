Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2015 03:12:26 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:58271 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011312AbbJVBMYpvUXP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Oct 2015 03:12:24 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id DF7F0208C1;
        Thu, 22 Oct 2015 01:12:19 +0000 (UTC)
Received: from mail-yk0-f177.google.com (mail-yk0-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D3120880;
        Thu, 22 Oct 2015 01:12:18 +0000 (UTC)
Received: by ykaz22 with SMTP id z22so68574245yka.2;
        Wed, 21 Oct 2015 18:12:18 -0700 (PDT)
X-Received: by 10.129.33.198 with SMTP id h189mr9156240ywh.287.1445476338308;
 Wed, 21 Oct 2015 18:12:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.219.76 with HTTP; Wed, 21 Oct 2015 18:11:59 -0700 (PDT)
In-Reply-To: <1445358661-53953-2-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1445358661-53953-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1445358661-53953-2-git-send-email-Zubair.Kakakhel@imgtec.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Oct 2015 20:11:59 -0500
Message-ID: <CAL_Jsq+gYJRuCroCm2BDrEY2TjFV7cG9WcUr0nEZfBsrgzruTg@mail.gmail.com>
Subject: Re: [PATCH_V2 1/4] dt-bindings: MIPS: Document xilfpga bindings and
 boot style
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Tue, Oct 20, 2015 at 11:30 AM, Zubair Lutfullah Kakakhel
<Zubair.Kakakhel@imgtec.com> wrote:
> Xilfpga boots only with device-tree. Document the required properties
> and the unique boot style
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>
> ---
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
> index 0000000..eaba22b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/img/xilfpga.txt
> @@ -0,0 +1,83 @@
> +Imagination University Program MIPSfpga
> +=======================================
> +
> +Under the Imagination University Program, a microAptiv UP core has been
> +released for academic usage.
> +
> +As we are dealing with a mips core instantiated on an FPGA, specifications

s/mips/MIPS/

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
> +- 128Mbyte DDR RAM     at 0x0000_0000
> +- 8Kbyte RAM           at 0x1000_0000
> +- axi_intc             at 0x1020_0000
> +- axi_uart16550                at 0x1040_0000
> +- axi_gpio             at 0x1060_0000
> +- axi_i2c              at 0x10A0_0000
> +- custom_gpio          at 0x10C0_0000
> +- axi_ethernetlite     at 0x10E0_0000
> +- 8Kbyte BootRAM       at 0x1FC0_0000
> +
> +Required properties:
> +--------------------
> + - compatible: Must include "img,xilfpga","digilent,nexys4ddr".

Should be in the reverse order. Most specific comes first.

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
> +       compatible = "img,xilfpga","digilent,nexys4ddr";
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "mips,m14Kc";
> +                       reg = <0>;
> +                       clocks  = <&ext>;
> +               };
> +       };
> +
> +       ext: ext {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <50000000>;
> +       };
> +
> +Boot protocol:
> +--------------
> +
> +The BootRAM is a writeable "RAM" in FPGA at 0x1FC0_0000.
> +This is for easy reprogrammibility via JTAG.
> +
> +The BootRAM inializes the cache and the axi_uart peripheral.

typo

> +
> +DDR initialiation is already handled by a HW IP block.

typo

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
