Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 00:29:24 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:58246 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994661AbeCQX3S2yZth (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 00:29:18 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 0/8] Ingenic JZ47xx Timer/Counter Unit drivers
Date:   Sun, 18 Mar 2018 00:28:53 +0100
Message-Id: <20180317232901.14129-1-paul@crapouillou.net>
In-Reply-To: <20180110224838.16711-2-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1521329357; bh=SBKmvf9sw6wE61z1vU1rY2tzAn60kkuZjUK19pQhAD8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KfpY6QXNrBv/ipJJdOuDr5X5erWsaqmOiXmrn7f6HmxprfT7ptSOioifY29U109OkoX7KFdBluPkpMWcBbNCg1um0zWabpQGyt6jV9xM9bK+u4R4aA7YinUQb5b0ycQ3ML1qIn95abKd0dCiWF+/4IBOVMpNOS65m/NLY5p63LE=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63015
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

This is the 4th version of my TCU patchset.

The major change is a greatly improved documentation, both in-code
and as separate text files, to describe how the hardware works and
how the devicetree bindings should be used.

There are also cosmetic changes in the irqchip driver, and the
clocksource driver will now use as timers all TCU channels not
requested by the TCU PWM driver.

Cheers,
-Paul
