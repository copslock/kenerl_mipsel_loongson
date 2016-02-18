Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 15:35:29 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:49102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012796AbcBROf0XdyZ9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Feb 2016 15:35:26 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 3AD3E20225;
        Thu, 18 Feb 2016 14:35:21 +0000 (UTC)
Received: from rob-hp-laptop (pool-108-31-35-198.washdc.fios.verizon.net [108.31.35.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15AD20222;
        Thu, 18 Feb 2016 14:35:18 +0000 (UTC)
Date:   Thu, 18 Feb 2016 08:35:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     david.daney@cavium.com, aleksey.makarov@caviumnetworks.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
Subject: Re: [PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC
 controller
Message-ID: <20160218143516.GA9654@rob-hp-laptop>
References: <1455725574-9947-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1455725574-9947-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52115
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

On Wed, Feb 17, 2016 at 04:12:53PM +0000, Matt Redfearn wrote:
> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
> 
> Add Device Tree binding document for Octeon MMC controller. The driver
> is in a following patch.
> 
> The MMC controller can be connected to up to 4 "slots" which may be
> eMMC, MMC or SD card devices. As there is a single controller, each
> available slot is represented as a child node of the controller.
> 
> This is a similar concept to the atmel-mci driver.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
> Signed-off-by: Peter Swain <pswain@cavium.com>
> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
> v7: No changes
> 
> v6:
> - Split up patch
> - Moved device tree fixup to platform code
> ---
>  .../devicetree/bindings/mmc/octeon-mmc.txt         | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
> new file mode 100644
> index 000000000000..d2c576d9ad65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
> @@ -0,0 +1,79 @@
> +* OCTEON SD/MMC Host Controller
> +
> +This controller is present on some members of the Cavium OCTEON SoC
> +family, provide an interface for eMMC, MMC and SD devices.  There is a
> +single controller that may have several "slots" connected.  These
> +slots appear as children of the main controller node.
> +The DMA engine is an integral part of the controller block.
> +
> +1) MMC node
> +
> +Required properties:
> +- compatible : Should be "cavium,octeon-6130-mmc" or "cavium,octeon-7890-mmc"
> +- reg : Two entries:
> +	1) The base address of the MMC controller register bank.
> +	2) The base address of the MMC DMA engine register bank.
> +- interrupts :
> +	For "cavium,octeon-6130-mmc": two entries:
> +	1) The MMC controller interrupt line.
> +	2) The MMC DMA engine interrupt line.
> +	For "cavium,octeon-7890-mmc": nine entries:
> +	1) The next block transfer of a multiblock transfer has completed (BUF_DONE)
> +	2) Operation completed successfully (CMD_DONE).
> +	3) DMA transfer completed successfully (DMA_DONE).
> +	4) Operation encountered an error (CMD_ERR).
> +	5) DMA transfer encountered an error (DMA_ERR).
> +	6) Switch operation completed successfully (SWITCH_DONE).
> +	7) Switch operation encountered an error (SWITCH_ERR).
> +	8) Internal DMA engine request completion interrupt (DONE).
> +	9) Internal DMA FIFO underflow (FIFO).
> +- #address-cells : Must be <1>
> +- #size-cells : Must be <0>
> +
> +The node contains child nodes for each slot that the platform uses.
> +
> +Example:
> +mmc@1180000002000 {
> +	compatible = "cavium,octeon-6130-mmc";
> +	reg = <0x11800 0x00002000 0x0 0x100>,
> +		<0x11800 0x00000168 0x0 0x20>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	/* EMM irq, DMA irq */
> +	interrupts = <1 19>, <0 63>;
> +
> +	[ child node definitions...]
> +};
> +
> +
> +2) Slot nodes
> +Properties in mmc.txt apply to each slot node that the platform uses.
> +
> +Required properties:
> +- reg : The slot number.
> +
> +Optional properties:
> +- cavium,cmd-clk-skew : the amount of delay (in pS) past the clock edge
> +	to sample the command pin.
> +- cavium,dat-clk-skew : the amount of delay (in pS) past the clock edge
> +	to sample the data pin.

I thought you were okay with adding -ps? Either way:

Acked-by: Rob Herring <robh@kernel.org>
