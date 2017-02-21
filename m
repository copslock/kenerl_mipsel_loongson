Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2017 12:20:19 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:42118 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991111AbdBULUM2LU96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2017 12:20:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 21 Feb 2017 12:20:10 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document
 pinctrl-ingenic
In-Reply-To: <CACRpkdbAA33FFrMgx-eZPmpBBfQ_hF+=dSu0hANVthdbadicDg@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop>
 <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
 <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com>
 <fd3c507484a9ee34a08c9f92e60624db@mail.crapouillou.net>
 <CACRpkdbAA33FFrMgx-eZPmpBBfQ_hF+=dSu0hANVthdbadicDg@mail.gmail.com>
Message-ID: <f19fea79c2616455f5f08070923428cc@crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56883
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

Le 2017-02-20 14:56, Linus Walleij a écrit :
> On Thu, Feb 9, 2017 at 6:28 PM, Paul Cercueil <paul@crapouillou.net> 
> wrote:
> 
>> I was thinking that instead of having one pinctrl-ingenic instance 
>> covering
>> 0x600 of register space, and 6 instances of gpio-ingenic having 0x100 
>> each,
>> I could just have 6 instances of pinctrl-ingenic, each one with an 
>> instance
>> of gpio-ingenic declared as a sub-node, each handling just 0x100 of 
>> memory
>> space.
> 
> My head is spinning,  but I think I get it. What is wrong with the 
> solution
> I proposed with one pin control instance covering the whole 0x600 and 
> with 6
> subnodes of GPIO?
> 
> The GPIO nodes do not even have to have an address range associated 
> with
> them you know, that can be distributed out with regmap code accessing
> the parent regmap.

OK, but then each GPIO chip 'X' still need to know its offset in the 
register
area, which is (pinctrl_base + X * 0x100).
What's the best way to pass that info to the driver? (I assume it's not 
with
a custom DT binding...).

Regards,
-Paul
