Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 09:53:05 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:35961 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993029AbeGaHw6r8tPa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 09:52:58 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 546B1207AB; Tue, 31 Jul 2018 09:52:52 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 26C9E20741;
        Tue, 31 Jul 2018 09:52:42 +0200 (CEST)
Date:   Tue, 31 Jul 2018 09:52:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        kishon@ti.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 02/10] dt-bindings: net: ocelot: remove hsio
 from the list of register address spaces
Message-ID: <20180731075243.GO28585@piout.net>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 30/07/2018 14:43:47+0200, Quentin Schulz wrote:
> HSIO register address space should be handled outside of the MAC
> controller as there are some registers for PLL5 configuring,
> SerDes/switch port muxing and a thermal sensor IP, so let's remove it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  Documentation/devicetree/bindings/mips/mscc.txt       | 16 ++++++++++++-
>  Documentation/devicetree/bindings/net/mscc-ocelot.txt |  9 ++-----
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
> index ae15ec3..bc817e9 100644
> --- a/Documentation/devicetree/bindings/mips/mscc.txt
> +++ b/Documentation/devicetree/bindings/mips/mscc.txt
> @@ -41,3 +41,19 @@ Example:
>  		compatible = "mscc,ocelot-cpu-syscon", "syscon";
>  		reg = <0x70000000 0x2c>;
>  	};
> +
> +o HSIO regs:
> +
> +The SoC has a few registers (HSIO) handling miscellaneous functionalities:
> +configuration and status of PLL5, RCOMP, SyncE, SerDes configurations and
> +status, SerDes muxing and a thermal sensor.
> +
> +Required properties:
> +- compatible: Should be "mscc,ocelot-hsio", "syscon", "simple-mfd"
> +- reg : Should contain registers location and length
> +
> +Example:
> +	syscon@10d0000 {
> +		compatible = "mscc,ocelot-hsio", "syscon", "simple-mfd";
> +		reg = <0x10d0000 0x10000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> index 0a84711..9e5c17d 100644
> --- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> @@ -12,7 +12,6 @@ Required properties:
>    - "sys"
>    - "rew"
>    - "qs"
> -  - "hsio"
>    - "qsys"
>    - "ana"
>    - "portX" with X from 0 to the number of last port index available on that
> @@ -45,7 +44,6 @@ Example:
>  		reg = <0x1010000 0x10000>,
>  		      <0x1030000 0x10000>,
>  		      <0x1080000 0x100>,
> -		      <0x10d0000 0x10000>,
>  		      <0x11e0000 0x100>,
>  		      <0x11f0000 0x100>,
>  		      <0x1200000 0x100>,
> @@ -59,10 +57,9 @@ Example:
>  		      <0x1280000 0x100>,
>  		      <0x1800000 0x80000>,
>  		      <0x1880000 0x10000>;
> -		reg-names = "sys", "rew", "qs", "hsio", "port0",
> -			    "port1", "port2", "port3", "port4", "port5",
> -			    "port6", "port7", "port8", "port9", "port10",
> -			    "qsys", "ana";
> +		reg-names = "sys", "rew", "qs", "port0", "port1", "port2",
> +			    "port3", "port4", "port5", "port6", "port7",
> +			    "port8", "port9", "port10", "qsys", "ana";
>  		interrupts = <21 22>;
>  		interrupt-names = "xtr", "inj";
>  
> -- 
> git-series 0.9.1

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
