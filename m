Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 22:57:45 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:54711 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbKVV5nazlqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 22:57:43 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 9028720606;
        Sun, 22 Nov 2015 21:57:41 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9DBF20662;
        Sun, 22 Nov 2015 21:57:39 +0000 (UTC)
Date:   Sun, 22 Nov 2015 15:57:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/14] DEVICETREE: Add bindings for PIC32 SDHC host
 controller
Message-ID: <20151122215737.GA5285@rob-hp-laptop>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-13-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448065205-15762-13-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50056
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

On Fri, Nov 20, 2015 at 05:17:24PM -0700, Joshua Henderson wrote:
> From: Andrei Pistirica <andrei.pistirica@microchip.com>
> 
> Document the devicetree bindings for the SDHC peripheral found on
> Microchip PIC32 class devices.
> 
> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-pic32.txt        |   24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
> new file mode 100644
> index 0000000..f16388c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
> @@ -0,0 +1,24 @@
> +* Microchip PIC32 SDHCI Controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci-pic32 driver.
> +
> +Required properties:
> +- compatible: Should be "microchip,pic32-sdhci"
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +- pinctrl: Should contain pinctrl for data and command lines
> +
> +Optional properties:
> +- no-1-8-v: 1.8V voltage selection not supported

There's a standard property for this one.

> +- piomode: disable DMA support

Proably this one too IIRC.

> +
> +Example:
> +
> +	sdhci@1f8ec000 {
> +		compatible = "microchip,pic32-sdhci";
> +		reg = <0x1f8ec000 0x100>;
> +		interrupts = <SDHC_EVENT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&REFCLKO4>, <&PBCLK5>;
> +		clock-names = "base_clk", "sys_clk";
> +	};
> -- 
> 1.7.9.5
> 
