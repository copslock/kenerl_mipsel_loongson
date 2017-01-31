Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 11:31:48 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:49668 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993878AbdAaKblo-nuV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 11:31:41 +0100
To:     Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document  pinctrl-ingenic
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jan 2017 11:31:10 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com
In-Reply-To: <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop>
Message-ID: <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56542
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

> From the overlapping register addresses in the examples and this
> description, it looks like the pinctrlr and gpio controller are 1 
> block.
> If so, then there should only be 1 node.

Well, that's what I had until Linus W. just told me to do the opposite:

> Just pull all these down two levels and make them one device
> each instead of having them inside the pin controller node
> like this.

-Paul
