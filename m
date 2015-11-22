Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 22:31:19 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:53508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbKVVbREOazM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 22:31:17 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 2F18B206A2;
        Sun, 22 Nov 2015 21:31:14 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7BAD205BC;
        Sun, 22 Nov 2015 21:31:12 +0000 (UTC)
Date:   Sun, 22 Nov 2015 15:31:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/14] DEVICETREE: Add PIC32 clock binding documentation
Message-ID: <20151122213110.GA16187@rob-hp-laptop>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-4-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448065205-15762-4-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50052
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

On Fri, Nov 20, 2015 at 05:17:15PM -0700, Joshua Henderson wrote:
> From: Purna Chandra Mandal <purna.mandal@microchip.com>
> 
> Document the devicetree bindings for the clock driver found on Microchip
> PIC32 class devices.
> 
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>  .../devicetree/bindings/clock/microchip,pic32.txt  |  263 ++++++++++++++++++++
>  1 file changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/microchip,pic32.txt b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
> new file mode 100644
> index 0000000..4cef72d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
> @@ -0,0 +1,263 @@
> +Binding for a Clock hardware block found on
> +certain Microchip PIC32 MCU devices.
> +
> +Microchip SoC clocks-node consists of few oscillators, PLL, multiplexer
> +and few divider nodes.

[...]

> +Required properties:
> +- compatible : should have "microchip,pic32-clk".
> +- reg : A Base address and length of the register set.
> +- interrupts : source of interrupt.
> +
> +Optional properties (for subnodes):
> +- #clock-cells: From common clock binding, should be 0.
> +
> +- microchip,clock-indices: in multiplexer node clock sources always aren't linear
> +    and contiguous. This property helps define clock-sources with respect to
> +    the mux clock node.
> +
> +- microchip,ignore-unused : ignore gate request even if the gated clock is unused.

There is some discussion about this upstream with "critical-clocks" 
binding. Can you use and wait for that?

> +- microchip,status-bit-mask: bitmask for status check. This will be used to confirm
> +    particular operation by clock sub-node is completed. It is dependent sub-node.
> +- microchip,bit-mask: enable mask, similar to microchip,status-bit-mask.

We've generally decided not to describe clocks at this level of detail 
in DT. It's fine though for simple clock trees. This one seems to be 
borderline IMO.

> +- microchip,slew-step: enable frequency slewing(stepping) during rate change;
> +    applicable only to sys-clock subnode.
