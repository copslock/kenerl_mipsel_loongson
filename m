Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2017 12:59:15 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:56950 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992993AbdATL7ItqjmW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jan 2017 12:59:08 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 09/13] mmc: jz4740: Let the pinctrl driver configure the  pins
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Jan 2017 12:59:07 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
In-Reply-To: <CAPDyKFp4idZx+ynQByz22zwsiK+reBcvt3OdHm1kR2QUy+sUhw@mail.gmail.com>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170117231421.16310-10-paul@crapouillou.net>
 <CAPDyKFp4idZx+ynQByz22zwsiK+reBcvt3OdHm1kR2QUy+sUhw@mail.gmail.com>
Message-ID: <81c24244706ce24a678a3d05bbf6b17c@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56432
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

Le 2017-01-19 11:55, Ulf Hansson a écrit :

> Shouldn't this be replaced with a call to:
> pinctrl_pm_select_sleep_state();

You're totally right. I'll change it.

Thanks,
-Paul
