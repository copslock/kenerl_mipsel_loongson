Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 23:22:41 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994002AbeGVVU3r33eS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 23:20:29 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2715DAFCE;
        Sun, 22 Jul 2018 21:20:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Damien Horsley <damien.horsley@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: [PATCH 09/15] dmaengine: img-mdc: Handle early status read
Date:   Sun, 22 Jul 2018 23:20:04 +0200
Message-Id: <20180722212010.3979-10-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <afaerber@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afaerber@suse.de
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

From: Damien Horsley <damien.horsley@imgtec.com>

It is possible that mdc_tx_status may be called before the first
node has been read from memory.

In this case, the residue value stored in the register is undefined.
Return the transfer size instead.

Signed-off-by: Damien Horsley <damien.horsley@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/dma/img-mdc-dma.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index 25cec9c243e1..0f2f0f52d83a 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -621,25 +621,33 @@ static enum dma_status mdc_tx_status(struct dma_chan *chan,
 			(MDC_CMDS_PROCESSED_CMDS_DONE_MASK + 1);
 
 		/*
-		 * If the command loaded event hasn't been processed yet, then
-		 * the difference above includes an extra command.
+		 * If the first node has not yet been read from memory,
+		 * the residue register value is undefined
 		 */
-		if (!mdesc->cmd_loaded)
-			cmds--;
-		else
-			cmds += mdesc->list_cmds_done;
-
-		bytes = mdesc->list_xfer_size;
-		ldesc = mdesc->list;
-		for (i = 0; i < cmds; i++) {
-			bytes -= ldesc->xfer_size + 1;
-			ldesc = ldesc->next_desc;
-		}
-		if (ldesc) {
-			if (residue != MDC_TRANSFER_SIZE_MASK)
-				bytes -= ldesc->xfer_size - residue;
+		if (!mdesc->cmd_loaded && !cmds) {
+			bytes = mdesc->list_xfer_size;
+		} else {
+			/*
+			 * If the command loaded event hasn't been processed yet, then
+			 * the difference above includes an extra command.
+			 */
+			if (!mdesc->cmd_loaded)
+				cmds--;
 			else
+				cmds += mdesc->list_cmds_done;
+
+			bytes = mdesc->list_xfer_size;
+			ldesc = mdesc->list;
+			for (i = 0; i < cmds; i++) {
 				bytes -= ldesc->xfer_size + 1;
+				ldesc = ldesc->next_desc;
+			}
+			if (ldesc) {
+				if (residue != MDC_TRANSFER_SIZE_MASK)
+					bytes -= ldesc->xfer_size - residue;
+				else
+					bytes -= ldesc->xfer_size + 1;
+			}
 		}
 	}
 	spin_unlock_irqrestore(&mchan->vc.lock, flags);
-- 
2.16.4
