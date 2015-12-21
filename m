Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Dec 2015 17:50:16 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:48286 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008778AbbLUQuOTCIT9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Dec 2015 17:50:14 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 21652295; Mon, 21 Dec 2015 17:50:08 +0100 (CET)
Received: from localhost (81-67-231-93.rev.numericable.fr [81.67.231.93])
        by mail.free-electrons.com (Postfix) with ESMTPSA id D4D62246;
        Mon, 21 Dec 2015 17:49:57 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@free-electrons.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     arm@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] ARM: mvebu: kirkwood: Add compatible property to "partitions" node
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
        <1450694033-27717-3-git-send-email-geert+renesas@glider.be>
Date:   Mon, 21 Dec 2015 17:49:58 +0100
In-Reply-To: <1450694033-27717-3-git-send-email-geert+renesas@glider.be>
        (Geert Uytterhoeven's message of "Mon, 21 Dec 2015 11:33:46 +0100")
Message-ID: <87vb7rrbk9.fsf@free-electrons.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <gregory.clement@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.clement@free-electrons.com
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

Hi Geert,
 
 On lun., déc. 21 2015, Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), the "partitions" subnode of an SPI
> FLASH device node must have a compatible property. The partitions are no
> longer detected if it is not present.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied on mvebu/dt

Thanks,

Gregory

> ---
> v2:
>   - New.
> ---
>  arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> index 1db6f2c506cce320..8082d64266a37c33 100644
> --- a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> +++ b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> @@ -131,6 +131,7 @@
>  	chip-delay = <40>;
>  	status = "okay";
>  	partitions {
> +		compatible = "fixed-partitions";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  
> -- 
> 1.9.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
