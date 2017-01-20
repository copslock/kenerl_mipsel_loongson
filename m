Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2017 11:02:14 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:45080 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdATKCGprXgn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jan 2017 11:02:06 +0100
To:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 13/13] MIPS: jz4740: Remove custom GPIO code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Jan 2017 11:01:35 +0100
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
In-Reply-To: <CACRpkdYMm0iWxmEGyQyEz4JfWukXNyGXO1rqw1dSiABgHdA1tQ@mail.gmail.com>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170117231421.16310-14-paul@crapouillou.net>
 <CACRpkdYMm0iWxmEGyQyEz4JfWukXNyGXO1rqw1dSiABgHdA1tQ@mail.gmail.com>
Message-ID: <8944dd20e8ae6ed705dcf69e9f0ed4fd@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56430
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

Le 2017-01-19 10:07, Linus Walleij a écrit :

> On Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net> 
> wrote:
> 
>> All the drivers for the various hardware elements of the jz4740 SoC 
>> have been modified to use the pinctrl framework for their pin 
>> configuration needs. As such, this platform code is now unused and can 
>> be deleted. Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> I feel I might have come across as a bit harsh in the previous review 
> of the
> patches leading up to this one. In that case I'm sorry.
> 
> I can clearly see that the intent of the series is to remove this 
> hopelessly
> idiomatic code from the MIPS hurdle, and move these systems over
> to standard frameworks.
> 
> In a way, if I look at the kernel as a whole, it would likely look 
> better
> after these patches were merged, than before. Even with the
> shortcomings I painted out in the previous review comments.
> 
> A very complicated piece of messy code is cut from MIPS.
> 
> I think this is very valuable work and well worth persuing, so please
> go ahead and work with the series, your effort is very much 
> appreciated!
> 
> Yours,
> Linus Walleij

Well thank you for your very constructive criticism ;) And for your 
review.
I'll submit a v2 very soon - I don't want to miss the 4.11 merge.

Regards,
-Paul
