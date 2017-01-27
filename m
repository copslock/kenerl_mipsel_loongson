Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2017 16:28:04 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:54332 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdA0P15JPB0E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jan 2017 16:27:57 +0100
To:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 01/14] Documentation: dt/bindings: Document  pinctrl-ingenic
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Jan 2017 16:27:56 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux MIPS <linux-mips@linux-mips.org>,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>
In-Reply-To: <CACRpkdZFRH84c4x7HBwgmY3fH+=Qq4q167c9oPhvrJ70MQkjaA@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
 <20170122144947.16158-2-paul@crapouillou.net>
 <CACRpkdZFRH84c4x7HBwgmY3fH+=Qq4q167c9oPhvrJ70MQkjaA@mail.gmail.com>
Message-ID: <08e9505d2d366557950f8e6a4e81f57a@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi,

> So I still don't understand these properties.
> 
> Does this mean that there is a pull-up *inside* the SoC or *outside*
> on the board where it is mounted?

The pull-up resistors are inside the SoCs.

> In the former case, if this pertains to the *inside* of the SoC:
> is it just different between jz4740 and jz4780?
> In that case, just code this into the driver as .data to the 
> .compatible
> in the DT match. No special DT properties needed.

Well, I've been taught that devicetree is for describing the hardware, 
and
the driver code is for functionality. So that's why I put it in 
devicetree.

That's also the reason why I put the list of functions and groups in
devicetree and not in the driver code.

> Standard bindings use just "pins". Why the custom ingenic,
> prefix?

I can change that.

Regards,
-Paul
