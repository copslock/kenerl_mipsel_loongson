Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 19:16:54 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:41364 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993997AbeHURQuqRuoD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 19:16:50 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v7 00/24] TCU patchset v7
Date:   Tue, 21 Aug 2018 19:16:11 +0200
Message-Id: <20180821171635.22740-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871809; bh=lUaJww5mQU8gGtIiC/2MeG+isI/sXxRp/8lsFMzow6o=; h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding; b=BuT9xWLDhbvkenEW6ozw0b+gkK12tD0LiKt3x2ctlCVPDA4ZuBkPSCUL4dZ3km0F1Nb8nZyjp/vyWC/d6dDFl6S968zZrxofd1prqUsPXRQTKS4+8yaQz1oPkn/zEY66xHkrmL2FvHrvWYK3LCPP3WBOm/qgm3Eq8NmyC1D3Onw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65684
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

This is the v7 of my patchset that adds support for the Timer/Counter
Unit in Ingenic JZ47xx SoCs.

From v6, only patches [05/24] and [06/24] were modified to fix a section
mismatch. All the other patches are the same.

Thanks,
-Paul Cercueil
