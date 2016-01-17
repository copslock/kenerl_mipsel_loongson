Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jan 2016 04:57:19 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006150AbcAQD5QwNzYh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jan 2016 04:57:16 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id A272E20304;
        Sun, 17 Jan 2016 03:57:14 +0000 (UTC)
Received: from rob-hp-laptop (c-73-166-181-108.hsd1.tx.comcast.net [73.166.181.108])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062E820263;
        Sun, 17 Jan 2016 03:57:12 +0000 (UTC)
Date:   Sat, 16 Jan 2016 21:57:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 01/14] dt/bindings: Add bindings for PIC32 interrupt
 controller
Message-ID: <20160117035711.GA26226@rob-hp-laptop>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
 <1452734299-460-2-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452734299-460-2-git-send-email-joshua.henderson@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51173
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

On Wed, Jan 13, 2016 at 06:15:34PM -0700, Joshua Henderson wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> Document the devicetree bindings for the interrupt controller on
> Microchip PIC32 class devices.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
> Changes since v4:
> 	- Add new microchip,external-interrupts property
> 	- Provide a better description of some of the features
> 	- Clean up formatting
> Changes since v3: None
> Changes since v2: None
> Changes since v1:
> 	- Remove hardware interrupt priorities from interrupt controller DT
> 	  bindings.
> ---
>  .../interrupt-controller/microchip,pic32-evic.txt  |   67 ++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,pic32-evic.txt

Acked-by: Rob Herring <robh@kernel.org>
