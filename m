Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:42:49 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4697 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823073Ab3FJHkHxuRVN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:07 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:36:20 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:39:59 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:39:59 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 197C1F2D73; Mon, 10
 Jun 2013 00:39:57 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 07/11] MIPS: Netlogic: Fix sign extension in PIC write
Date:   Mon, 10 Jun 2013 13:11:06 +0530
Message-ID: <1370850070-5127-8-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5E7E31W33902870-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36784
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

This does not cause a problem yet, but we do not want to write 1
to reserved bits.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pic.h b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
index a981f46..4b5108d 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pic.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pic.h
@@ -315,7 +315,7 @@ nlm_pic_send_ipi(uint64_t base, int hwt, int irq, int nmi)
 {
 	uint64_t ipi;
 
-	ipi = (nmi << 31) | (irq << 20);
+	ipi = ((uint64_t)nmi << 31) | (irq << 20);
 	ipi |= ((hwt >> 4) << 16) | (1 << (hwt & 0xf)); /* cpuset and mask */
 	nlm_write_pic_reg(base, PIC_IPI_CTL, ipi);
 }
-- 
1.7.9.5
