Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759C3C07E85
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C70020834
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C70020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbeLDUUZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:20:25 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41648 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeLDUUY (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 4 Dec 2018 15:20:24 -0500
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 92B0CB0045;
        Tue,  4 Dec 2018 22:12:49 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4/6] MIPS: OCTEON: cvmx_mio_fus_dat3: use oldest forward compatible definition
Date:   Tue,  4 Dec 2018 22:12:18 +0200
Message-Id: <20181204201220.12667-5-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181204201220.12667-1-aaro.koskinen@iki.fi>
References: <20181204201220.12667-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Chips up to cn5xxx are compatible with cn38xx. All cn6xxx chips, and also
cnf71xx, are compatible with cn61xx.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/octeon-model.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index 341052387b49..657dbad9644e 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -305,7 +305,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 				if (fus_dat3.s.nozip)
 					suffix = "SCP";
 
-				if (fus_dat3.cn56xx.bar2_en)
+				if (fus_dat3.cn38xx.bar2_en)
 					suffix = "NSPB2";
 			}
 			if (l2d_fus3)
@@ -344,7 +344,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 			suffix = "CP";
 		else if (fus_dat2.cn63xx.dorm_crypto)
 			suffix = "DAP";
-		else if (fus_dat3.cn63xx.nozip)
+		else if (fus_dat3.cn61xx.nozip)
 			suffix = "SCP";
 		else
 			suffix = "AAP";
@@ -359,18 +359,18 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 			suffix = "CP";
 		else if (fus_dat2.cn66xx.dorm_crypto)
 			suffix = "DAP";
-		else if (fus_dat3.cn66xx.nozip)
+		else if (fus_dat3.cn61xx.nozip)
 			suffix = "SCP";
 		else
 			suffix = "AAP";
 		break;
 	case 0x91:		/* CN68XX */
 		family = "68";
-		if (fus_dat2.cn68xx.nocrypto && fus_dat3.cn68xx.nozip)
+		if (fus_dat2.cn68xx.nocrypto && fus_dat3.cn61xx.nozip)
 			suffix = "CP";
 		else if (fus_dat2.cn68xx.dorm_crypto)
 			suffix = "DAP";
-		else if (fus_dat3.cn68xx.nozip)
+		else if (fus_dat3.cn61xx.nozip)
 			suffix = "SCP";
 		else if (fus_dat2.cn68xx.nocrypto)
 			suffix = "SP";
@@ -379,7 +379,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		break;
 	case 0x94:		/* CNF71XX */
 		family = "F71";
-		if (fus_dat3.cnf71xx.nozip)
+		if (fus_dat3.cn61xx.nozip)
 			suffix = "SCP";
 		else
 			suffix = "AAP";
-- 
2.17.0

