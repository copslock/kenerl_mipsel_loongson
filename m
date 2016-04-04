Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 07:16:28 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:46273 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008573AbcDDFQZiEN6j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Apr 2016 07:16:25 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 35AE020204;
        Mon,  4 Apr 2016 05:16:23 +0000 (UTC)
Received: from rob-hp-laptop (unknown [209.65.105.133])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618FC2021F;
        Mon,  4 Apr 2016 05:16:18 +0000 (UTC)
Date:   Mon, 4 Apr 2016 00:16:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, jogo@openwrt.org,
        cernekee@gmail.com
Subject: Re: [PATCH v3 2/2] bmips: add device tree example for BCM6358
Message-ID: <20160404051615.GL17806@rob-hp-laptop>
References: <1456054881-26787-1-git-send-email-noltari@gmail.com>
 <1459677376-10449-1-git-send-email-noltari@gmail.com>
 <1459677376-10449-2-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1459677376-10449-2-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52853
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

On Sun, Apr 03, 2016 at 11:56:16AM +0200, Álvaro Fernández Rojas wrote:
> This adds a device tree example for SFR Neufbox4 (Sercomm version), which
> also serves as a real example for brcm,bcm6358-leds.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v3: Device tree fixes
>   - Use interrupt-controller instead of periph_intc.
>   - Use led@# instead of naming the LEDs.
>  v2: Remove led0 alias and use stdout-path only
> 
>  .../devicetree/bindings/mips/brcm/soc.txt          |   2 +-
>  arch/mips/bmips/Kconfig                            |   4 +
>  arch/mips/boot/dts/brcm/Makefile                   |   2 +
>  arch/mips/boot/dts/brcm/bcm6358.dtsi               | 111 +++++++++++++++++++++
>  arch/mips/boot/dts/brcm/bcm96358nb4ser.dts         |  46 +++++++++
>  5 files changed, 164 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/brcm/bcm6358.dtsi
>  create mode 100644 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts

Acked-by: Rob Herring <robh@kernel.org>
