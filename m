Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2012 17:37:25 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2026 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903444Ab2IFPhO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2012 17:37:14 +0200
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 06 Sep 2012 08:34:49 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Thu, 6 Sep 2012 08:36:23 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 7C57E9F9F6; Thu, 6
 Sep 2012 08:36:59 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     ddaney.cavm@gmail.com, cernekee@gmail.com,
        "Jim Quinlan" <jim2101024@gmail.com>
Subject: [PATCH V5 1/3] MIPS: bitops.h: change use of 'unsigned short'
 to 'int'
Date:   Thu, 6 Sep 2012 11:36:54 -0400
Message-ID: <1346945816-13984-2-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1346945816-13984-1-git-send-email-jim2101024@gmail.com>
References: <1346945816-13984-1-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7C561D1349827917988-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/include/asm/bitops.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 82ad35c..455664c 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -57,7 +57,7 @@
 static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-	unsigned short bit = nr & SZLONG_MASK;
+	int bit = nr & SZLONG_MASK;
 	unsigned long temp;
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
@@ -118,7 +118,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 {
 	unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-	unsigned short bit = nr & SZLONG_MASK;
+	int bit = nr & SZLONG_MASK;
 	unsigned long temp;
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
@@ -191,7 +191,7 @@ static inline void clear_bit_unlock(unsigned long nr, volatile unsigned long *ad
  */
 static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	int bit = nr & SZLONG_MASK;
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
@@ -244,7 +244,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 static inline int test_and_set_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	int bit = nr & SZLONG_MASK;
 	unsigned long res;
 
 	smp_mb__before_llsc();
@@ -310,7 +310,7 @@ static inline int test_and_set_bit(unsigned long nr,
 static inline int test_and_set_bit_lock(unsigned long nr,
 	volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	int bit = nr & SZLONG_MASK;
 	unsigned long res;
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
@@ -373,7 +373,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 static inline int test_and_clear_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	int bit = nr & SZLONG_MASK;
 	unsigned long res;
 
 	smp_mb__before_llsc();
@@ -457,7 +457,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 static inline int test_and_change_bit(unsigned long nr,
 	volatile unsigned long *addr)
 {
-	unsigned short bit = nr & SZLONG_MASK;
+	int bit = nr & SZLONG_MASK;
 	unsigned long res;
 
 	smp_mb__before_llsc();
-- 
1.7.6
