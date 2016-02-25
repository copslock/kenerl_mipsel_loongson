Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 10:46:14 +0100 (CET)
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39154 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008884AbcBYJpwVo-em (ORCPT
        <rfc822;linux-mips@linux-mips.Org>); Thu, 25 Feb 2016 10:45:52 +0100
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.80)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1aYsUW-0001iy-9c; Thu, 25 Feb 2016 10:45:48 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/2] MIPS: lantiq: Make reset_control_ops const
Date:   Thu, 25 Feb 2016 10:45:46 +0100
Message-Id: <1456393547-28030-2-git-send-email-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456393547-28030-1-git-send-email-p.zabel@pengutronix.de>
References: <1456393547-28030-1-git-send-email-p.zabel@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <p.zabel@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.Org
Original-Recipient: rfc822;linux-mips@linux-mips.Org
X-archive-position: 52233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.zabel@pengutronix.de
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

The reset_ops structure is never modified. Make it const.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/mips/lantiq/xway/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index bc29bb3..1f34608 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -258,7 +258,7 @@ static int ltq_reset_device(struct reset_controller_dev *rcdev,
 	return ltq_deassert_device(rcdev, id);
 }
 
-static struct reset_control_ops reset_ops = {
+static const struct reset_control_ops reset_ops = {
 	.reset = ltq_reset_device,
 	.assert = ltq_assert_device,
 	.deassert = ltq_deassert_device,
-- 
2.7.0
