Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:33:49 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:37864 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993920AbeH2VdH0qJip (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 23:33:07 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH v5 00/18] JZ4780 DMA patchset v5
Date:   Wed, 29 Aug 2018 23:32:42 +0200
Message-Id: <20180829213300.22829-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535578385; bh=P2zeDZ4eN3KanGl3b1TYQQanGGSDgw+wuqlU89HN4+U=; h=From:To:Cc:Subject:Date:Message-Id; b=nR0Vo3tuk8JsqrlHf2zPs2woWWISPLVHJAt7d74IVtieGgHmlP1XX908cS5TX5IEI3jQcKB21Lpkb3SBa6Cr2lWiwvNxc+5JkUuDEdNZNzIpgot3YTr1m0SGYsE3aeXn38KJoNkDp6kIov+ExESnRBMsRpUlt4SOZ/mAll3QNiA=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65781
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

Hi Vinod,

This is the V5 of my Ingenic JZ4780 DMA patchset.

- Patch [01/18] dropped the "doc:" in the patch title;
- Patches [11/18] and [12/18] now use the GENMASK() macro.
- The rest is untouched.

Thanks,
-Paul Cercueil
