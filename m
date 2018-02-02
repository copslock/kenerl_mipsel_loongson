Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 23:16:31 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993497AbeBBWPPe671g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Feb 2018 23:15:15 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42907217A9;
        Fri,  2 Feb 2018 22:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42907217A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 3/4] MIPS: generic: Fix Makefile alignment
Date:   Fri,  2 Feb 2018 22:14:11 +0000
Message-Id: <aca836516478a60b0f3d68251448ec96014a610e.1517609353.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
In-Reply-To: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Fix whitespace of generic platform Makefile so that obj-y values align.

Fixes: f2d0b0d5c171 ("MIPS: ranchu: Add Ranchu as a new generic-based board")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Goran Ferenc <goran.ferenc@mips.com>
Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/generic/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index 5fb60c86537b..5c31e0c4697d 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -15,4 +15,4 @@ obj-y += proc.o
 obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
 obj-$(CONFIG_KEXEC)			+= kexec.o
-obj-$(CONFIG_VIRT_BOARD_RANCHU)	+= board-ranchu.o
+obj-$(CONFIG_VIRT_BOARD_RANCHU)		+= board-ranchu.o
-- 
git-series 0.9.1
