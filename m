Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 17:17:19 +0200 (CEST)
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:47251 "EHLO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992128AbcHOPRKdBlZf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 17:17:10 +0200
X-MHO-User: 89b93464-62fb-11e6-8929-8ded99d5e9d7
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.99.77.15
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.99.77.15])
        by outbound2.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Mon, 15 Aug 2016 15:18:36 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id A82FE80064;
        Mon, 15 Aug 2016 15:17:03 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io A82FE80064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1471274223;
        bh=c+Xoz3iedM9ql3ctkz5v7DOSvoK+bg/rSkgjuIQ6UwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=2BiqF6GwXCd+ccmgM8c1oSXHkBVI6JXvPcdIX5R87ZEAmpUxetM0ii/e243E29fPT
         S59Eg7ZAtrJSvmsEpDfJjK52I0Vo/8W2PpP4AguEnNh7KH9a7ew2cjr7b9Ktz2jxgH
         eALeILr7sHaibSdgs4qHXmNUXmYgJ8RJdIz8/itbYAmiu7kKH0kdQtbspwDaPxh3O6
         mfrh0oWQzphFUQLzjb/+1t1snnDwPkdJl+IGNo+7l9AcIBDgBFYfhz48HXXezqytne
         7/UqYN/7fkxEWV+P264plC5yLyOv3U6MyIMGAIPOHMmlAQhts+bL6t3l5uy/tiS43h
         I2mGJZlMrzCuA==
Date:   Mon, 15 Aug 2016 15:17:03 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        marc.zyngier@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/9] MIPS: xilfpga: Add DT node for AXI emaclite
Message-ID: <20160815151703.GD3353@io.lakedaemon.net>
References: <1471269335-58747-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1471269335-58747-9-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471269335-58747-9-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54548
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

On Mon, Aug 15, 2016 at 02:55:34PM +0100, Zubair Lutfullah Kakakhel wrote:
> The xilfpga platform has a Xilinx AXI emaclite block.
> 
> Add the DT node to use it.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> index 3658e21..58bc62f 100644
> --- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> +++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> @@ -42,6 +42,33 @@
>  		xlnx,tri-default = <0xffffffff>;
>  	} ;
>  
> +	axi_ethernetlite: ethernet@10e00000 {
> +		compatible = "xlnx,xps-ethernetlite-3.00.a";

This one also isn't documented.

> +		device_type = "network";
> +		interrupt-parent = <&axi_intc>;
> +		interrupts = <1>;
> +		local-mac-address = [08 86 4C 0D F7 09];

I'm pretty sure you don't want this in the mainline dts file.

thx,

Jason.

> +		phy-handle = <&phy0>;
> +		reg = <0x10e00000 0x10000>;
> +		xlnx,duplex = <0x1>;
> +		xlnx,include-global-buffers = <0x1>;
> +		xlnx,include-internal-loopback = <0x0>;
> +		xlnx,include-mdio = <0x1>;
> +		xlnx,instance = "axi_ethernetlite_inst";
> +		xlnx,rx-ping-pong = <0x1>;
> +		xlnx,s-axi-id-width = <0x1>;
> +		xlnx,tx-ping-pong = <0x1>;
> +		xlnx,use-internal = <0x0>;
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			phy0: phy@1 {
> +				device_type = "ethernet-phy";
> +				reg = <1>;
> +			};
> +		};
> +	};
> +
>  	axi_uart16550: serial@10400000 {
>  		compatible = "ns16550a";
>  		reg = <0x10400000 0x10000>;
> -- 
> 1.9.1
> 
