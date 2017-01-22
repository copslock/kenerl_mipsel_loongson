Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2017 15:50:29 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:45672 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991964AbdAVOuTaVXlb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2017 15:50:19 +0100
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
Subject: [PATCH v2 00/14] Ingenic JZ4740 / JZ4780 pinctrl driver
Date:   Sun, 22 Jan 2017 15:49:33 +0100
Message-Id: <20170122144947.16158-1-paul@crapouillou.net>
In-Reply-To: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485096617; bh=73bgZ0DFUhDhjogCN9AUbFEh/HNnjXgotipjUvYvbxc=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z4DmUA4a30KYuwtYJddpC4wxMtGYBD4GBZFRvGgb2RFNMkS12y/q9em2BDsSce31G8bszmsWDXvlmfx8cq7hspnAETY67XnYHHSP9b3WHblkntEJsN1o0Gu5CkANSqzfodhmBRulwfuxk9hAkj5nZ6gt2Orcr1sK0xJfyPH81lk=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56441
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

This is the v2 of my ingenic pinctrl patch series.
Huge changes in there, the pinctrl driver was completely rewritten, and the
GPIO code was split into a separate driver.

It now uses the generic functions to handle pin groups, as well as generic
devicetree bindings.

Best regards,
- Paul
