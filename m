Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 11:41:17 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:38239 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007626AbbKYKlO2GZDu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 11:41:14 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id BF16228BD7E;
        Wed, 25 Nov 2015 11:41:12 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com [209.85.215.53])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B78A528BE7F;
        Wed, 25 Nov 2015 11:40:41 +0100 (CET)
Received: by lfaz4 with SMTP id z4so55228643lfa.0;
        Wed, 25 Nov 2015 02:40:40 -0800 (PST)
X-Received: by 10.112.170.67 with SMTP id ak3mr13120885lbc.82.1448448040335;
 Wed, 25 Nov 2015 02:40:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.162.78 with HTTP; Wed, 25 Nov 2015 02:40:20 -0800 (PST)
In-Reply-To: <1448446739-5541-4-git-send-email-mschiller@tdt.de>
References: <1448446739-5541-1-git-send-email-mschiller@tdt.de> <1448446739-5541-4-git-send-email-mschiller@tdt.de>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 25 Nov 2015 11:40:20 +0100
X-Gmail-Original-Message-ID: <CAOiHx=moeuw-qWdq0YVzVD3dv0Zq+3rxb2tAKV1Hiz35y4+7DQ@mail.gmail.com>
Message-ID: <CAOiHx=moeuw-qWdq0YVzVD3dv0Zq+3rxb2tAKV1Hiz35y4+7DQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pinctrl/lantiq: fix up pinmux
To:     Martin Schiller <mschiller@tdt.de>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, daniel.schwierzeck@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi

On Wed, Nov 25, 2015 at 11:18 AM, Martin Schiller <mschiller@tdt.de> wrote:
> From: John Crispin <blogic@openwrt.org>
>
> This patch is included in the openwrt patchset for several years now and needs
> to go upstream as well. It includes the following changes:
> 1. Fix up inline function call to xway_mux_apply

This really needs an explanation what is being fixed here.

> 2. Fix GPIO Setup of GPIO Port3

This change looks fine.

> 3. Implement gpio_chip.to_irq

These are three different changes (two fixes, one new feature) and
therefore should be split up into three patches.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Martin Schiller <mschiller@tdt.de>
> ---

Also please provide a changelog for your patches here.

>  drivers/pinctrl/pinctrl-xway.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>


Jonas
