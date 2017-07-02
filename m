Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jul 2017 18:38:00 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:47446 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993419AbdGBQfQi0sOq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jul 2017 18:35:16 +0200
Date:   Sun, 02 Jul 2017 18:35:01 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic
 SoCs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Message-Id: <1499013301.1477.0@smtp.crapouillou.net>
In-Reply-To: <CACRpkdauf5c2i4o5i8QY8YHPNjizkvTu6kAbnquWiP_=v2=KdQ@mail.gmail.com>
References: <20170402204244.14216-2-paul@crapouillou.net>
        <20170428200824.10906-1-paul@crapouillou.net>
        <20170428200824.10906-6-paul@crapouillou.net>
        <CACRpkdauf5c2i4o5i8QY8YHPNjizkvTu6kAbnquWiP_=v2=KdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1499013311; bh=mtPV2CxHXL4vEB4E6Ur//bQ7fgALF+q75uFaDxLB3fQ=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type; b=vQNNLq0+I975MxmEJwUZZVKiD/6JimnQwKW39UlyyT7UtvQ4DW/n9TQMc3RdT/Mxz1NDGOKOIhPh0/wrHMwFhyPKO8pFM79HomsIGk4WokMgLjmtYH+aUEBT5jdhKiXvzKksoLNcnOh8hspcgPCVN+fbBM6iI8B8dRgs8izYmws=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58962
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

Hi Linus,

> I applied all the patches to a branch in pinctrl and merged into my
> devel branch for testing:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/
> Branch: ingenic
> 
> Ralf: are you OK with this? It would be nice to have your ACK on
> all patches. If you want you can pull this branch into the MIPS
> tree, or we can hope for it all to settle nicely because of low 
> platform
> activity in MIPS on this platform, so it only needs to come in
> from my trees.

There has been no word from Ralf, is this going into 4.13?
