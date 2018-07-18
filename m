Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 20:20:46 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:52706 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992925AbeGRSUnnIW1K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jul 2018 20:20:43 +0200
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 00/17] JZ4780 DMA patchset v2
Date:   Wed, 18 Jul 2018 20:20:06 +0200
Message-Id: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938042; bh=mPdINxxdHVMuf+vePSdZ2HjJ+KrzVlCN6oTxHng266g=; h=From:To:Cc:Subject:Date:Message-Id; b=ZxI+Vrv1ieM/xM81BRKnQ9wXQfrN07UAhc6ZGM05A91ETJJX9kGSSINBHEzMLoqZL9O8QeGVqpPPpCy+12IyAfDXyiATRUcVkr+2tGQyI2JRi6e8ns/NcEjtfGukE/+J/GBaL3TJJw6yM1y7LP49Oo5m8p2Lqet5Z40RcAQXuLE=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64922
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

This is the version 2 of my jz4780-dma driver update patchset.

Changelog:

- All documentation changes have been moved to one single patch [01/17].

- The new patch [02/17] enforces that we're probed from devicetree.

- The driver will not fail if only one memory resource has been supplied
  in the devicetree, to keep compatibility with old devicetree files.

- A new patch [17/17] adds a devicetree node for the DMA driver in the
  JZ4740 DTS file.

- Some other small changes; see per-file changelog.

Regards,
-Paul
