Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:32:21 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43658 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870556AbaA0UYUlrAWA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:24:20 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 36/58] MIPS: asm: checksum: Split kernel and user copy operations
Date:   Mon, 27 Jan 2014 20:19:23 +0000
Message-ID: <1390853985-14246-37-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_24_15
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

In EVA mode, different instructions need to be used to read/write
from kernel and userland. In non-EVA mode, there is no functional
difference. The current address limit is checked to decide the
type of operation that will be performed.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/checksum.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 3c9aea5..f5602c6 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -37,7 +37,6 @@ __wsum __csum_partial_copy_from_user(const void *src, void *dst,
 				     int len, __wsum sum, int *err_ptr);
 __wsum __csum_partial_copy_to_user(const void *src, void *dst,
 				   int len, __wsum sum, int *err_ptr);
-
 /*
  * this is a new version of the above that records errors it finds in *errp,
  * but continues and zeros the rest of the buffer.
@@ -47,8 +46,12 @@ __wsum csum_partial_copy_from_user(const void __user *src, void *dst, int len,
 				   __wsum sum, int *err_ptr)
 {
 	might_fault();
-	return __csum_partial_copy_from_user((__force void *)src, dst,
-					     len, sum, err_ptr);
+	if (segment_eq(get_fs(), get_ds()))
+		return __csum_partial_copy_kernel((__force void *)src, dst,
+						  len, sum, err_ptr);
+	else
+		return __csum_partial_copy_from_user((__force void *)src, dst,
+						     len, sum, err_ptr);
 }
 
 /*
@@ -60,9 +63,16 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
 			     __wsum sum, int *err_ptr)
 {
 	might_fault();
-	if (access_ok(VERIFY_WRITE, dst, len))
-		return __csum_partial_copy_to_user(src, (__force void *)dst,
-						   len, sum, err_ptr);
+	if (access_ok(VERIFY_WRITE, dst, len)) {
+		if (segment_eq(get_fs(), get_ds()))
+			return __csum_partial_copy_kernel(src,
+							  (__force void *)dst,
+							  len, sum, err_ptr);
+		else
+			return __csum_partial_copy_to_user(src,
+							   (__force void *)dst,
+							   len, sum, err_ptr);
+	}
 	if (len)
 		*err_ptr = -EFAULT;
 
-- 
1.8.5.3
