Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 14:32:35 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:59462 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992916AbeGCMc2wjKFz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 14:32:28 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 00/14] dma-jz4780 improvements
Date:   Tue,  3 Jul 2018 14:32:00 +0200
Message-Id: <20180703123214.23090-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530621147; bh=/bFB1seiv8a/cfcw4LntnjrrWQLk0ur0HVnu1fOspP4=; h=From:To:Cc:Subject:Date:Message-Id; b=UimHgRqrZ3UVHCA3PWP90Ve1wW3Bwt/pu4JJQu5dT4vNhZvajb8WaLUGxL9vpsRsgSRCXZ9BjLxInslW+xDAfVY5aiFj5oaRIMbUXSyiC2j/dnWQrKYzKYAEaW1EVml4h+pgzEwS9lrqhAxmPr1pQRPKsxDQLybtN6XKw+x6768=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64564
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

This set of patches by myself and Daniel extends the dma-jz4780 driver
to support other SoCs (JZ4770, JZ4740, JZ4725B).

Some fixes are also included, for proper residue reporting, which fixes
errors with ALSA.

Finally, the last two patches update the devicetree bindings for the
JZ4780 SoC and add a binding for the JZ4770 SoC.

This patchset was tested on JZ4780, JZ4770 and JZ4725B, but was not tested
on the JZ4740, so it would be fantastic if somebody could test it there.

Regards,
-Paul
