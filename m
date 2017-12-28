Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 14:58:44 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:49288 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990506AbdL1N4wOcKw5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 14:56:52 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 00/15] Ingenic JZ4770 and GCW Zero support
Date:   Thu, 28 Dec 2017 14:56:19 +0100
Message-Id: <20171228135634.30000-1-paul@crapouillou.net>
In-Reply-To: <20170702163016.6714-2-paul@crapouillou.net>
References: <20170702163016.6714-2-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514469406; bh=RCpXEssmrGKpKg2mjnwXqITj2OrVWzlxgj44JZdCsqw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BzG4yVjKKLFUVzVcNJIuVxQIVpoeY/tm7QP/qIsMNxpPGduuZY0M36Kz3J8e0lwe8UY+imvppSGVZph+qJPjtdr0EejS3fin5kvqQ/jytho8NNWs1jXiL2pByd4oIwRJOSeBMrhh4OrX4UbiCLSQRglUDpAeU6JsGB7oKpSDtaU=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61650
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

This is my v4 of my patch series to support the JZ4770 SoC from Ingenic
as well as the GCW Zero handheld console.

Not much changed since v3, I dropped the three serial-related patches
(07-08-09/18) as I will submit them separately. The only other change is
that I rebased the patch series on top of v4.15-rc5.

Regards,
-Paul Cercueil
