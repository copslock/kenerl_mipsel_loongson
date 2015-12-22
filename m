Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 02:16:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52140 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009000AbbLVBQShRZ02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Dec 2015 02:16:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tBM1GES7016801;
        Tue, 22 Dec 2015 02:16:15 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tBM1G9CT016792;
        Tue, 22 Dec 2015 02:16:09 +0100
Date:   Tue, 22 Dec 2015 02:16:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     arm@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] MIPS: dts: jz4780/ci20: Add compatible property
 to "partitions" node
Message-ID: <20151222011609.GA15881@linux-mips.org>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <1450694033-27717-10-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450694033-27717-10-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Dec 21, 2015 at 11:33:53AM +0100, Geert Uytterhoeven wrote:
> Date:   Mon, 21 Dec 2015 11:33:53 +0100
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> To: arm@kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement
>  <gregory.clement@free-electrons.com>, Sebastian Hesselbarth
>  <sebastian.hesselbarth@gmail.com>, Simon Horman <horms@verge.net.au>,
>  Magnus Damm <magnus.damm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
>  Alex Smith <alex.smith@imgtec.com>
> Cc: Brian Norris <computersforpeace@gmail.com>, Rob Herring
>  <robh+dt@kernel.org>, devicetree@vger.kernel.org,
>  linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
>  linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
>  linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH v2 9/9] MIPS: dts: jz4780/ci20: Add compatible property to
>  "partitions" node
> 
> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), the "partitions" subnode of an SPI
> FLASH device node must have a compatible property. The partitions are no
> longer detected if it is not present.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index 782258c0e4fbba8e..1652d8d60b1e4b86 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -70,6 +70,7 @@
>  			nand-on-flash-bbt;
>  
>  			partitions {
> +				compatible = "fixed-partitions";
>  				#address-cells = <2>;
>  				#size-cells = <2>;
>  
> -- 
> 1.9.1

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
