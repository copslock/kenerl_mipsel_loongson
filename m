Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A45C04EB8
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D7C2082B
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D7C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLDUU0 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:20:26 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41672 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLDUU0 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 4 Dec 2018 15:20:26 -0500
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 313F6B001C;
        Tue,  4 Dec 2018 22:12:49 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/6] MIPS: OCTEON: cvmx_pko_mem_debug8: use oldest forward compatible definition
Date:   Tue,  4 Dec 2018 22:12:17 +0200
Message-Id: <20181204201220.12667-4-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181204201220.12667-1-aaro.koskinen@iki.fi>
References: <20181204201220.12667-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

cn58xx is compatible with cn52xx, so use the latter.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c | 2 +-
 arch/mips/include/asm/octeon/cvmx-pko.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
index 8241fc6aa17d..3839feba68f2 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
@@ -266,7 +266,7 @@ int cvmx_cmd_queue_length(cvmx_cmd_queue_id_t queue_id)
 		} else {
 			union cvmx_pko_mem_debug8 debug8;
 			debug8.u64 = cvmx_read_csr(CVMX_PKO_MEM_DEBUG8);
-			return debug8.cn58xx.doorbell;
+			return debug8.cn50xx.doorbell;
 		}
 	case CVMX_CMD_QUEUE_ZIP:
 	case CVMX_CMD_QUEUE_DFA:
diff --git a/arch/mips/include/asm/octeon/cvmx-pko.h b/arch/mips/include/asm/octeon/cvmx-pko.h
index 5f47f76ed510..20eb9c46a75a 100644
--- a/arch/mips/include/asm/octeon/cvmx-pko.h
+++ b/arch/mips/include/asm/octeon/cvmx-pko.h
@@ -611,7 +611,7 @@ static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
 		pko_reg_read_idx.s.index = cvmx_pko_get_base_queue(port_num);
 		cvmx_write_csr(CVMX_PKO_REG_READ_IDX, pko_reg_read_idx.u64);
 		debug8.u64 = cvmx_read_csr(CVMX_PKO_MEM_DEBUG8);
-		status->doorbell = debug8.cn58xx.doorbell;
+		status->doorbell = debug8.cn50xx.doorbell;
 	}
 }
 
-- 
2.17.0

