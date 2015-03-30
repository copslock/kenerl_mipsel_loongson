Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 01:47:24 +0200 (CEST)
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:32844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010169AbbC3XrQzmdC- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 01:47:16 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CFF19351F02;
        Mon, 30 Mar 2015 23:47:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pin73_2259415ea6e55
X-Filterd-Recvd-Size: 1410
Received: from joe-laptop.perches.com (pool-71-119-66-80.lsanca.fios.verizon.net [71.119.66.80])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Mar 2015 23:47:15 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 05/25] mips: Use bool function return values of true/false not 1/0
Date:   Mon, 30 Mar 2015 16:46:03 -0700
Message-Id: <2249121b5518fc8e74796729546f0e0854dddbac.1427759009.git.joe@perches.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1427759009.git.joe@perches.com>
References: <cover.1427759009.git.joe@perches.com>
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/include/asm/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 06412aa..fd1b4a1 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -23,7 +23,7 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
-		return 0;
+		return false;
 
 	return addr + size <= *dev->dma_mask;
 }
-- 
2.1.2
