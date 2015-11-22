Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 22:15:05 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:53085 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbKVVPA5HEWZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 22:15:00 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 8CF16206F9;
        Sun, 22 Nov 2015 21:14:57 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13C72056D;
        Sun, 22 Nov 2015 21:14:55 +0000 (UTC)
Date:   Sun, 22 Nov 2015 15:14:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/14] DEVICETREE: Add bindings for PIC32 interrupt
 controller
Message-ID: <20151122211453.GA13180@rob-hp-laptop>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-2-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448065205-15762-2-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50051
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

On Fri, Nov 20, 2015 at 05:17:13PM -0700, Joshua Henderson wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> Document the devicetree bindings for the interrupt controller on Microchip
> PIC32 class devices. This also adds a header defining associated interrupts
> and related settings.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> ---
>  .../microchip,pic32mz-evic.txt                     |   65 ++++++
>  .../interrupt-controller/microchip,pic32mz-evic.h  |  238 ++++++++++++++++++++
>  2 files changed, 303 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
>  create mode 100644 include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt b/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
> new file mode 100644
> index 0000000..12fb91f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
> @@ -0,0 +1,65 @@
> +Microchip PIC32MZ Interrupt Controller
> +======================================
> +
> +The Microchip PIC32MZ SOC contains an Enhanced Vectored Interrupt Controller
> +(EVIC) version 2. It handles internal and external interrupts and provides
> +support for priority, sub-priority, irq type and polarity.
> +
> +Required properties
> +-------------------
> +
> +- compatible: Should be "microchip,evic-v2"

This should be more specific like "microchip,pic32mz-evic". You can keep 
this one in addition if you like for matching.

Rob
