Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 20:14:56 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012049AbcBHTOyOORib (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Feb 2016 20:14:54 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B5CA1203B7;
        Mon,  8 Feb 2016 19:14:51 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7B9203B4;
        Mon,  8 Feb 2016 19:14:50 +0000 (UTC)
Date:   Mon, 8 Feb 2016 13:14:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/7] [PATCH] MIPS: OCTEON: Add support for OCTEON III
 interrupt  controller.
Message-ID: <20160208191448.GA19126@rob-hp-laptop>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
 <1454632974-7686-7-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454632974-7686-7-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51868
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

On Thu, Feb 04, 2016 at 04:42:53PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Add irq_chip support for both IPI and "normal" interrupts of the CIU3
> controller.  Document the device tree binding for the CIU3.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: devicetree@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  .../devicetree/bindings/mips/cavium/ciu3.txt       |  27 +

Acked-by: Rob Herring <robh@kernel.org>

>  arch/mips/cavium-octeon/octeon-irq.c               | 651 ++++++++++++++++++++-
>  arch/mips/include/asm/octeon/octeon.h              |   2 +
>  3 files changed, 679 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/cavium/ciu3.txt
