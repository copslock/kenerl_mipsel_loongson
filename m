Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 19:52:30 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:48958 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993874AbdAYSwXSosow (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 19:52:23 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
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
Subject: [PATCH v3 00/14] Ingenic JZ4740 / JZ4780 pinctrl driver
Date:   Wed, 25 Jan 2017 19:51:53 +0100
Message-Id: <20170125185207.23902-1-paul@crapouillou.net>
In-Reply-To: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485370342; bh=jnTOHTIsxappK3wRG8GIXGSVF/Oz/TTQe27BqppdiUk=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aNJHxWZQb2PrSfT1QxaV8SXTdqmST6w7qNXuCsV22n8akUbgcZzxe0XnCapjzShSn2QNwuTAwETNx5kAnG5EvKcqVNirQYqezTBH5e9Bsxue13ggmV+bqgkrSM8DeJNoJ9n42V63lM03LibyJe/86jY7terVEkhPfZKl2p+laqc=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56492
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

This is my v3 of my ingenic pinctrl patch series.
Not much is changed here, just cosmetic changes reported by coccinelle
as well as a missing header include.

To clear up any doubts: I left the GPIO base for the gpio-ingenic driver
configurable, for the reason that the QI_LB60 platform still uses global
GPIO numbers. When this code will eventually be cleaned up I will send
a patch to remove this mechanism.

Best regards,
- Paul
