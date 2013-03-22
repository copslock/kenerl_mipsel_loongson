Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Mar 2013 17:24:45 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4063 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823991Ab3CVQXif9U7F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Mar 2013 17:23:38 +0100
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 22 Mar 2013 09:16:30 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 22 Mar 2013 09:23:24 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 22 Mar 2013 09:23:24 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 65F2D3928A; Fri, 22
 Mar 2013 09:23:23 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 3/5] MIPS: Netlogic: Fix nlm_read_c2_status() definition
Date:   Fri, 22 Mar 2013 21:55:00 +0530
Message-ID: <51da273d1930e9017ee49947223d14f5b40f2685.1363966534.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1363966534.git.jchandra@broadcom.com>
References: <cover.1363966534.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D525C543YC7239996-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35942
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

The sel argument os nlm_read_c2_status() was not used and the macro
returned the sel 0 in all cases. Fix this by defining two macros:
nlm_read_c2_status0() and nlm_read_c2_status1() to return the two
status registers.

Add functions to write to the status registers as well.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlr/fmn.h |    9 ++++++---
 arch/mips/netlogic/xlr/fmn.c             |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlr/fmn.h b/arch/mips/include/asm/netlogic/xlr/fmn.h
index 2a78929..90e1126 100644
--- a/arch/mips/include/asm/netlogic/xlr/fmn.h
+++ b/arch/mips/include/asm/netlogic/xlr/fmn.h
@@ -175,7 +175,10 @@
 #define nlm_write_c2_cc14(s, v)		__write_32bit_c2_register($30, s, v)
 #define nlm_write_c2_cc15(s, v)		__write_32bit_c2_register($31, s, v)
 
-#define nlm_read_c2_status(sel)		__read_32bit_c2_register($2, 0)
+#define nlm_read_c2_status0()		__read_32bit_c2_register($2, 0)
+#define nlm_write_c2_status0(v)		__write_32bit_c2_register($2, 0, v)
+#define nlm_read_c2_status1()		__read_32bit_c2_register($2, 1)
+#define nlm_write_c2_status1(v)		__write_32bit_c2_register($2, 1, v)
 #define nlm_read_c2_config()		__read_32bit_c2_register($3, 0)
 #define nlm_write_c2_config(v)		__write_32bit_c2_register($3, 0, v)
 #define nlm_read_c2_bucksize(b)		__read_32bit_c2_register($4, b)
@@ -296,7 +299,7 @@ static inline int nlm_fmn_send(unsigned int size, unsigned int code,
 	 */
 	for (i = 0; i < 8; i++) {
 		nlm_msgsnd(dest);
-		status = nlm_read_c2_status(0);
+		status = nlm_read_c2_status0();
 		if ((status & 0x2) == 1)
 			pr_info("Send pending fail!\n");
 		if ((status & 0x4) == 0)
@@ -316,7 +319,7 @@ static inline int nlm_fmn_receive(int bucket, int *size, int *code, int *stid,
 
 	/* wait for load pending to clear */
 	do {
-		status = nlm_read_c2_status(1);
+		status = nlm_read_c2_status0();
 	} while ((status & 0x08) != 0);
 
 	/* receive error bits */
diff --git a/arch/mips/netlogic/xlr/fmn.c b/arch/mips/netlogic/xlr/fmn.c
index 4d74f03..0fdce61 100644
--- a/arch/mips/netlogic/xlr/fmn.c
+++ b/arch/mips/netlogic/xlr/fmn.c
@@ -80,7 +80,7 @@ static irqreturn_t fmn_message_handler(int irq, void *data)
 	while (1) {
 		/* 8 bkts per core, [24:31] each bit represents one bucket
 		 * Bit is Zero if bucket is not empty */
-		bkt_status = (nlm_read_c2_status() >> 24) & 0xff;
+		bkt_status = (nlm_read_c2_status0() >> 24) & 0xff;
 		if (bkt_status == 0xff)
 			break;
 		for (bucket = 0; bucket < 8; bucket++) {
-- 
1.7.9.5
