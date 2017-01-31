Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 15:12:11 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:60224 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993888AbdAaOMEZIaCe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 15:12:04 +0100
To:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 03/14] pinctrl-ingenic: add a pinctrl driver for the  Ingenic jz47xx SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 31 Jan 2017 15:12:01 +0100
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
In-Reply-To: <CACRpkdZKNACkOYJtUcYavriSxSDMy0iLt2SUX+d8DcKPXofXyw@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-4-paul@crapouillou.net>
 <CACRpkdZKNACkOYJtUcYavriSxSDMy0iLt2SUX+d8DcKPXofXyw@mail.gmail.com>
Message-ID: <a17fe420e842f4975fbff4172fd72f67@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56546
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

Le 2017-01-31 15:05, Linus Walleij a écrit :

> If I didn't mention before this could pperhaps just use "pins"?

You commented this on v2 after I sent the v3 :)
I will fix it for v4.

> If you just use "pins" can this even be parsed by a generic parser 
> function
> pinconf_generic_dt_subnode_to_map()?

I'll take a look. Thanks.

Regards,
-Paul
