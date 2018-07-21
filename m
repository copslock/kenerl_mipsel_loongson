Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 13:07:39 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:55148 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992759AbeGULHgRt1yi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jul 2018 13:07:36 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v3 00/18] JZ4780 DMA patchset v3
Date:   Sat, 21 Jul 2018 13:06:25 +0200
Message-Id: <20180721110643.19624-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532171254; bh=tccPmS0+AXzeM8qeRY0jErccGTxGelWcD54wPadIWKg=; h=From:To:Cc:Subject:Date:Message-Id; b=e4VY0M9cJ/vueBEkJhoHsthiZpNtSzznBfFdZgOG0E1HjNGHPumW92HLtDQMxKO64ki3WFF8TPkQnG2hev9ekPCJDulTZtU2WFS3KYsli86TM7TYSf2MQzCKFwuIYGLWmg1aEce87NHmjIGxM4TA9gzuoXPnTA+vET1TUIE7p/w=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65001
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

This is the version 3 of my jz4780-dma driver update patchset.

Apologies to the DMA people, the v2 of this patchset did not make it to
their mailing-list; see the bottom of this email for a description of
what happened in v2.

Changelog from v2 to v3:

- Modified the devicetree bindings to comply with the specification

- New patch [06/18] allows the JZ4780 DMA driver to be compiled within a
  generic MIPS kernel.

Changelog from v1 to v2:

- All documentation changes have been moved to one single patch [01/17].

- The new patch [02/17] enforces that we're probed from devicetree.

- The driver will not fail if only one memory resource has been supplied
  in the devicetree, to keep compatibility with old devicetree files.

- A new patch [17/17] adds a devicetree node for the DMA driver in the
  JZ4740 DTS file.

- Some other small changes; see per-file changelog.

Regards,
-Paul
