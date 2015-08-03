Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 09:23:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33264 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010209AbbHCHXomFQHx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 09:23:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t737NaB4032432;
        Mon, 3 Aug 2015 09:23:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t737NWLV032431;
        Mon, 3 Aug 2015 09:23:32 +0200
Date:   Mon, 3 Aug 2015 09:23:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Michael Buesch <m@bues.ch>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Remove all the uses of custom gpio.h
Message-ID: <20150803072332.GC16650@linux-mips.org>
References: <1438277338-7246-1-git-send-email-albeu@free.fr>
 <CACRpkdbUhYysC+mGuJY6Y8kd18LQLoWu+av81+ZD4UZo2nM-Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbUhYysC+mGuJY6Y8kd18LQLoWu+av81+ZD4UZo2nM-Yw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Aug 03, 2015 at 09:13:27AM +0200, Linus Walleij wrote:

> Very good job being done here.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I guess this better go in through the MIPS tree.
> Given all the OpenWRT ports using MIPS this is excellent
> progress for a large hobbyist community.

Alban has posted a v2 [1] already but I take it that your Reviewed-by: applies
to the v2 patch as well?

  Ralf

[1] https://patchwork.linux-mips.org/patch/10828/
