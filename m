Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 May 2017 19:00:26 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:47364 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994625AbdELRATTbZcR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 May 2017 19:00:19 +0200
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic
 SoCs
To:     Linus Walleij <linus.walleij@linaro.org>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net>
 <CACRpkdaYRmB=i-=k4vfFYL6wHVrpNo1w11xnLGbu+6YPPmT8vA@mail.gmail.com>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
From:   Paul Cercueil <paul@crapouillou.net>
Message-ID: <421a30e7-1bfc-b1de-6db8-96216a65adcf@crapouillou.net>
Date:   Fri, 12 May 2017 19:00:15 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkdaYRmB=i-=k4vfFYL6wHVrpNo1w11xnLGbu+6YPPmT8vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57889
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

On 11/05/2017 13:08, Linus Walleij wrote:
> On Fri, Apr 28, 2017 at 10:08 PM, Paul Cercueil <paul@crapouillou.net> wrote:
>
>> There is a pinctrl driver for each of the Ingenic SoCs supported by the
>> upstream Linux kernel. In order to switch away from the old GPIO
>> platform code, we now enable the pinctrl drivers by default for the
>> Ingenic SoCs.
>>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>   arch/mips/Kconfig | 1 +
> So please tell me your desired merge strategy for these bits. I can
> provide an immutable branch for pinctrl if you want to pull the deps in
> or we can just merge this orthogonally in the MIPS tree and let things
> smoothen together in the merge window.
>
> This goes for everything outside of pinctrl/gpio.
>
> If I should merge patches for other subsystems I need ACKs from
> the maintainers of MIPS etc.
>
> Yours,
> Linus Walleij
>
It is very unlikely that those patches will cause merge failures
if you merge it in your tree, these drivers are touched very rarely;
so I'd say you can merge them.

But to be sure I'd like Ralf's input on that.

Regards,
-Paul
