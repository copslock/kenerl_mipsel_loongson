Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 13:42:29 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:35914 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994680AbeHGLm04Tf0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2018 13:42:26 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v4 00/18] JZ47xx DMA patchset v4
Date:   Tue,  7 Aug 2018 13:42:00 +0200
Message-Id: <20180807114218.20091-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533642145; bh=Gu/eO+hMxepg6IBh/SyeupsplejTZ/UFq8rkOBCNUYM=; h=From:To:Cc:Subject:Date:Message-Id; b=uI4ZPCV8UaVu52KaqTKrov4PKCpsx3qS0HhVvYMbQXT0isX3+t3VEk80nweAc/PNkPQn3iJJCcR5fMmjhITdYrbb3mKp8BdqCacr0evotMw9WLVn2SOnX5jgrYuqT70BpbOtQR+d6wrdhcwXE8qh91pw65OYbtqWuCkWNt38ncc=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65447
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

This is the V4 of my Ingenic JZ47xx DMA patchset.

Changelog:

- Added my Signed-off-by on Daniel's patches

- Removed the jz_version enum and IDs; add a 'flags' field with
  corresponding macros instead

Regards,
-Paul
