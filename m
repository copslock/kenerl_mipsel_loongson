Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 17:13:18 +0200 (CEST)
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:39047 "EHLO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992043AbcHOPNEY0m0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 17:13:04 +0200
X-MHO-User: f7b0e588-62fa-11e6-8929-8ded99d5e9d7
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.99.77.15
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.99.77.15])
        by outbound2.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Mon, 15 Aug 2016 15:14:31 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 8562280071;
        Mon, 15 Aug 2016 15:12:59 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 8562280071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1471273979;
        bh=2L9H4xLE9QOyo/nnl6N8PezwQgKMFNbhNijKDtd4yyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=p2wLFZzOoIhjS9HFfRQ+qLMNLstzRB6If9ZLeF4BKrSwEPuhXeStEN3RjsPW08d/d
         wwf9KFBZchwvghdgxqIoQuRpKF4b6uHWoL7K5Xg0gxQbC+mLTeeNQ4wv2auQSp3XF1
         whmQI8oXQDg3nhz48ZjpsJDdfLNwh61FCiCs4kCCRLVOcYFpvvnSJtZl60siJAFax+
         biz5IXiWh5LVCmzOnndNUWXClAk2gN3+W7mpMfvyzAXJuytNh/X+yMDhy3Ls89kq1S
         9WpnQvL5uQF2FzgZimkqJrA+aRr1LARUJ3OsQNYvlNpZFiasrqd8OwEWiuAsURibgj
         VmlylQtefPyVQ==
Date:   Mon, 15 Aug 2016 15:12:59 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        marc.zyngier@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/9] MIPS: xilfpga: Use Xilinx AXI Interrupt Controller
Message-ID: <20160815151259.GC3353@io.lakedaemon.net>
References: <1471269335-58747-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1471269335-58747-5-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471269335-58747-5-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

Hi Zubair,

On Mon, Aug 15, 2016 at 02:55:30PM +0100, Zubair Lutfullah Kakakhel wrote:
> IRQs from peripherals such as i2c/uart/ethernet come via
> the AXI Interrupt controller.
> 
> Select it in Kconfig for xilfpga and add the DT node
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  arch/mips/Kconfig                        |  1 +
>  arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2638856..42ecf40 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -426,6 +426,7 @@ config MACH_XILFPGA
>  	select SYS_SUPPORTS_ZBOOT_UART16550
>  	select USE_OF
>  	select USE_GENERIC_EARLY_PRINTK_8250
> +	select XILINX_IRQ
>  	help
>  	  This enables support for the IMG University Program MIPSfpga platform.

Please split dt changes from code changes.

> diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> index 48d2112..8db660b 100644
> --- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> +++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> @@ -17,6 +17,18 @@
>  		compatible = "mti,cpu-interrupt-controller";
>  	};
>  
> +	axi_intc: interrupt-controller@10200000 {
> +		#interrupt-cells = <1>;
> +		compatible = "xlnx,xps-intc-1.00.a";

This compatible string isn't documented, mind adding it?  Please make
sure to Cc the devicetree maintainers on it.

thx,

Jason.

> +		interrupt-controller;
> +		reg = <0x10200000 0x10000>;
> +		xlnx,kind-of-intr = <0x0>;
> +		xlnx,num-intr-inputs = <0x6>;
> +
> +		interrupt-parent = <&cpuintc>;
> +		interrupts = <6>;
> +	};
> +
>  	axi_gpio: gpio@10600000 {
>  		#gpio-cells = <1>;
>  		compatible = "xlnx,xps-gpio-1.00.a";
> -- 
> 1.9.1
> 
