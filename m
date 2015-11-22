Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 22:35:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbKVVfMcxeXM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 22:35:12 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E174D20710;
        Sun, 22 Nov 2015 21:35:08 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 412C7206A2;
        Sun, 22 Nov 2015 21:35:07 +0000 (UTC)
Date:   Sun, 22 Nov 2015 15:35:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 05/14] DEVICETREE: Add bindings for PIC32/MZDA platforms
Message-ID: <20151122213505.GA24204@rob-hp-laptop>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-6-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448065205-15762-6-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50053
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

On Fri, Nov 20, 2015 at 05:17:17PM -0700, Joshua Henderson wrote:
> This adds support for the Microchip PIC32 platform along with the
> specific variant PIC32MZDA on a PIC32MZDA Starter Kit.
> 
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>

Acked-by: Rob Herring <robh@kernel.org>


> ---
>  .../bindings/mips/pic32/microchip,pic32mzda.txt    |   33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt b/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
> new file mode 100644
> index 0000000..bcf3e04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/pic32/microchip,pic32mzda.txt
> @@ -0,0 +1,33 @@
> +* Microchip PIC32MZDA Platforms
> +
> +PIC32MZDA Starter Kit
> +Required root node properties:
> +    - compatible = "microchip,pic32mzda-sk", "microchip,pic32mzda"
> +
> +CPU nodes:
> +----------
> +A "cpus" node is required.  Required properties:
> + - #address-cells: Must be 1.
> + - #size-cells: Must be 0.
> +A CPU sub-node is also required.  Required properties:
> + - device_type: Must be "cpu".
> + - compatible: Must be "mti,mips14KEc".
> +Example:
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "mti,mips14KEc";
> +		};
> +	};
> +
> +Boot protocol

This probably belongs somewhere else if it is common.

> +--------------
> +In accordance with the MIPS UHI specification[1], the bootloader must pass the
> +following arguments to the kernel:
> + - $a0: -2.
> + - $a1: KSEG0 address of the flattened device-tree blob.
> +
> +[1] http://prplfoundation.org/wiki/MIPS_documentation
> -- 
> 1.7.9.5
> 
