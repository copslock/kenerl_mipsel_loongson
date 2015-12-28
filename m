Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Dec 2015 09:27:48 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:39365 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007617AbbL1I1pxJ3b4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Dec 2015 09:27:45 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 902CA295; Mon, 28 Dec 2015 09:27:38 +0100 (CET)
Received: from bbrezillon (AToulouse-657-1-24-92.w83-193.abo.wanadoo.fr [83.193.68.92])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 106BB26C;
        Mon, 28 Dec 2015 09:27:38 +0100 (CET)
Date:   Mon, 28 Dec 2015 09:27:38 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     <linux-mtd@lists.infradead.org>, <computersforpeace@gmail.com>,
        <alex@alex-smith.me.uk>, Alex Smith <alex.smith@imgtec.com>,
        "Zubair Lutfullah Kakakhel" <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <robh@kernel.org>
Subject: Re: [PATCH v10 3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
Message-ID: <20151228092738.5cba56da@bbrezillon>
In-Reply-To: <1450959615-30246-4-git-send-email-harvey.hunt@imgtec.com>
References: <1450959615-30246-1-git-send-email-harvey.hunt@imgtec.com>
        <1450959615-30246-4-git-send-email-harvey.hunt@imgtec.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

On Thu, 24 Dec 2015 12:20:15 +0000
Harvey Hunt <harvey.hunt@imgtec.com> wrote:

> From: Alex Smith <alex.smith@imgtec.com>
> 
> Add device tree nodes for the NEMC and BCH to the JZ4780 device tree,
> and make use of them in the Ci20 device tree to add a node for the
> board's NAND.
> 
> Note that since the pinctrl driver is not yet upstream, this includes
> neither pin configuration nor busy/write-protect GPIO pins for the
> NAND. Use of the NAND relies on the boot loader to have left the pins
> configured in a usable state, which should be the case when booted
> from the NAND.
> 
> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
> Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: robh@kernel.org
> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>

Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> v9 -> v10:
>  - No change.
> 
> v8 -> v9:
>  - Represent the partition table as a subnode of a NAND chip. 
> 
> v7 -> v8:
>  - Describe the NAND chips as children nodes of the NAND controller.
>  - Remove ingenic, prefix from ECC settings.
>  - Renamed some ECC settings.
> 
> v6 -> v7:
>  - Add nand-ecc-mode to DT.
>  - Add nand-on-flash-bbt to DT.
> 
> v4 -> v5:
>  - New patch adding DT nodes for the NAND so that the driver can be
>    tested.
> 
>  arch/mips/boot/dts/ingenic/ci20.dts    | 63 ++++++++++++++++++++++++++++++++++
>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 26 ++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index 9fcb9e7..782258c 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -42,3 +42,66 @@
>  &uart4 {
>  	status = "okay";
>  };
> +
> +&nemc {
> +	status = "okay";
> +
> +	nandc: nand-controller@1 {
> +		compatible = "ingenic,jz4780-nand";
> +		reg = <1 0 0x1000000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ingenic,bch-controller = <&bch>;
> +
> +		ingenic,nemc-tAS = <10>;
> +		ingenic,nemc-tAH = <5>;
> +		ingenic,nemc-tBP = <10>;
> +		ingenic,nemc-tAW = <15>;
> +		ingenic,nemc-tSTRV = <100>;
> +
> +		nand@1 {
> +			reg = <1>;
> +
> +			nand-ecc-step-size = <1024>;
> +			nand-ecc-strength = <24>;
> +			nand-ecc-mode = "hw";
> +			nand-on-flash-bbt;
> +
> +			partitions {
> +				#address-cells = <2>;
> +				#size-cells = <2>;
> +
> +				partition@0 {
> +					label = "u-boot-spl";
> +					reg = <0x0 0x0 0x0 0x800000>;
> +				};
> +
> +				partition@0x800000 {
> +					label = "u-boot";
> +					reg = <0x0 0x800000 0x0 0x200000>;
> +				};
> +
> +				partition@0xa00000 {
> +					label = "u-boot-env";
> +					reg = <0x0 0xa00000 0x0 0x200000>;
> +				};
> +
> +				partition@0xc00000 {
> +					label = "boot";
> +					reg = <0x0 0xc00000 0x0 0x4000000>;
> +				};
> +
> +				partition@0x8c00000 {
> +					label = "system";
> +					reg = <0x0 0x4c00000 0x1 0xfb400000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&bch {
> +	status = "okay";
> +};
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index 65389f6..b868b42 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -108,4 +108,30 @@
>  
>  		status = "disabled";
>  	};
> +
> +	nemc: nemc@13410000 {
> +		compatible = "ingenic,jz4780-nemc";
> +		reg = <0x13410000 0x10000>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <1 0 0x1b000000 0x1000000
> +			  2 0 0x1a000000 0x1000000
> +			  3 0 0x19000000 0x1000000
> +			  4 0 0x18000000 0x1000000
> +			  5 0 0x17000000 0x1000000
> +			  6 0 0x16000000 0x1000000>;
> +
> +		clocks = <&cgu JZ4780_CLK_NEMC>;
> +
> +		status = "disabled";
> +	};
> +
> +	bch: bch@134d0000 {
> +		compatible = "ingenic,jz4780-bch";
> +		reg = <0x134d0000 0x10000>;
> +
> +		clocks = <&cgu JZ4780_CLK_BCH>;
> +
> +		status = "disabled";
> +	};
>  };



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
