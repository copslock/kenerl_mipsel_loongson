Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 23:15:44 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992404AbeBBWPMElD-g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Feb 2018 23:15:12 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9AA9217A7;
        Fri,  2 Feb 2018 22:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AA9217A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 1/4] MIPS: generic: Fix machine compatible matching
Date:   Fri,  2 Feb 2018 22:14:09 +0000
Message-Id: <4d44540130007c278068ea4870e3c4efbd171ee6.1517609353.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
In-Reply-To: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62428
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

We now have a platform (Ranchu) in the "generic" platform which matches
based on the FDT compatible string using mips_machine_is_compatible(),
however that function doesn't stop at a blank struct
of_device_id::compatible as that is an array in the struct, not a
pointer to a string.

Fix the loop completion to check the first byte of the compatible array
rather than the address of the compatible array in the struct.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/machine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/machine.h b/arch/mips/include/asm/machine.h
index e0d9b373d415..f83879dadd1e 100644
--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -52,7 +52,7 @@ mips_machine_is_compatible(const struct mips_machine *mach, const void *fdt)
 	if (!mach->matches)
 		return NULL;
 
-	for (match = mach->matches; match->compatible; match++) {
+	for (match = mach->matches; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, 0, match->compatible) == 0)
 			return match;
 	}
-- 
git-series 0.9.1
