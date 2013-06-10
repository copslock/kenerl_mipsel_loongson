Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:30:27 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2703 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820510Ab3FJH3FAf3wr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:29:05 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:19:48 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:28:47 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:28:47 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id D8643F2D74; Mon, 10
 Jun 2013 00:28:45 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 3/5] MIPS: Netlogic: Fix nlm_read_c2_status() definition
Date:   Mon, 10 Jun 2013 13:00:02 +0530
Message-ID: <1370849404-4918-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849404-4918-1-git-send-email-jchandra@broadcom.com>
References: <1370849404-4918-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DABA19E2L830675769-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36771
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

The sel argument os nlm_read_c2_status() was not used and the macro
returned the sel 0 in all cases. Fix this by defining two macros:
nlm_read_c2_status0() and nlm_read_c2_status1() to return the two
status registers.

Add functions to write to the status registers as well.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlr/fmn.h |    8 ++++++--
 arch/mips/netlogic/xlr/fmn.c             |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlr/fmn.h b/arch/mips/include/asm/netlogic/xlr/fmn.h
index 2a78929..56c7b85 100644
--- a/arch/mips/include/asm/netlogic/xlr/fmn.h
+++ b/arch/mips/include/asm/netlogic/xlr/fmn.h
@@ -175,6 +175,10 @@
 #define nlm_write_c2_cc14(s, v)		__write_32bit_c2_register($30, s, v)
 #define nlm_write_c2_cc15(s, v)		__write_32bit_c2_register($31, s, v)
 
+#define nlm_read_c2_status0()		__read_32bit_c2_register($2, 0)
+#define nlm_write_c2_status0(v)		__write_32bit_c2_register($2, 0, v)
+#define nlm_read_c2_status1()		__read_32bit_c2_register($2, 1)
+#define nlm_write_c2_status1(v)		__write_32bit_c2_register($2, 1, v)
 #define nlm_read_c2_status(sel)		__read_32bit_c2_register($2, 0)
 #define nlm_read_c2_config()		__read_32bit_c2_register($3, 0)
 #define nlm_write_c2_config(v)		__write_32bit_c2_register($3, 0, v)
@@ -296,7 +300,7 @@ static inline int nlm_fmn_send(unsigned int size, unsigned int code,
 	 */
 	for (i = 0; i < 8; i++) {
 		nlm_msgsnd(dest);
-		status = nlm_read_c2_status(0);
+		status = nlm_read_c2_status0();
 		if ((status & 0x2) == 1)
 			pr_info("Send pending fail!\n");
 		if ((status & 0x4) == 0)
@@ -316,7 +320,7 @@ static inline int nlm_fmn_receive(int bucket, int *size, int *code, int *stid,
 
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
