Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:01:42 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:2639 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825877Ab2JaM6wX01Vv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:52 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:57:29 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:06 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 745F340FE3; Wed, 31
 Oct 2012 05:58:34 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 08/15] MIPS: Netlogic: Fix interrupt table entry init
Date:   Wed, 31 Oct 2012 18:31:34 +0530
Message-ID: <c496ca33d7e5e64c30218539b27b5f8a41a44a3c.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFFB32102191042-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Used the hardware thread id passed in while writing to IRT in
nlm_pic_init_irt()

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index ad8b802..49ee15c 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -404,7 +404,7 @@ nlm_pic_ack(uint64_t base, int irt_num)
 static inline void
 nlm_pic_init_irt(uint64_t base, int irt, int irq, int hwt)
 {
-	nlm_pic_write_irt_direct(base, irt, 0, 0, 0, irq, 0);
+	nlm_pic_write_irt_direct(base, irt, 0, 0, 0, irq, hwt);
 }
 
 extern uint64_t nlm_pic_base;
-- 
1.7.9.5
