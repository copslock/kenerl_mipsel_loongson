Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2012 01:55:56 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62688 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903597Ab2HQXzu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2012 01:55:50 +0200
Received: by pbbrq8 with SMTP id rq8so4323322pbb.36
        for <multiple recipients>; Fri, 17 Aug 2012 16:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KrVsgqL6xbIRMUCIK4BqQxzONkuEL3/3Z3tPldL+UYQ=;
        b=OLXhs/jQOu79Dcb2R7rbdxxWslzsSmVGZpUFXvWASR72VVxjTV86760F3J62lJB16f
         PgheyfJTVryCbPfH+1IpGfczSTu2coTVuhfFEyqtagzqAEzMikPMomyCHxqus0k3qylv
         uVT+tr85xdLSjPeA5mbu7xhNdo+WU6+Xwj+nr60AGhHivz87N/lCVcxplLOQjlKDcPI/
         gBpRJkCWERV72W4iJqsJF88ovHFVpfOwr+Ly4B7NPpCVb6n2uwgqjAA4aBx8pp1b+eRa
         yU7/a/U9tN+O7PyAP9s4eVSvgGnvdmWjX8/9NjJlXLQPXPJ2dOmkMOWHE3PMJOZcBihE
         F0Jg==
Received: by 10.68.197.228 with SMTP id ix4mr15787976pbc.40.1345247743520;
        Fri, 17 Aug 2012 16:55:43 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id wn1sm5838297pbc.57.2012.08.17.16.55.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 16:55:42 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7HNseF6025130;
        Fri, 17 Aug 2012 16:54:40 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7HNsevK025129;
        Fri, 17 Aug 2012 16:54:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org, linux-ide@vger.kernel.org,
        Jeff Garzik <jgarzik@pobox.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] ata: pata_octeon_cf: Use correct byte order for DMA in when built little-endian.
Date:   Fri, 17 Aug 2012 16:54:33 -0700
Message-Id: <1345247673-25086-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

We need to set the 'endian' bit in this case.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/ata/pata_octeon_cf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 652d035..4e1194b 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <scsi/scsi_host.h>
 
+#include <asm/byteorder.h>
 #include <asm/octeon/octeon.h>
 
 /*
@@ -589,6 +590,9 @@ static void octeon_cf_dma_start(struct ata_queued_cmd *qc)
 
 	/* Set the direction of the DMA */
 	mio_boot_dma_cfg.u64 = 0;
+#ifdef __LITTLE_ENDIAN
+	mio_boot_dma_cfg.s.endian = 1;
+#endif
 	mio_boot_dma_cfg.s.en = 1;
 	mio_boot_dma_cfg.s.rw = ((qc->tf.flags & ATA_TFLAG_WRITE) != 0);
 
-- 
1.7.11.2
