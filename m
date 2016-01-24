Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jan 2016 23:05:10 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:43313 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011041AbcAXWFHc7BJB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jan 2016 23:05:07 +0100
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1aNSmQ-0000gA-Pn; Sun, 24 Jan 2016 22:05:07 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 106/128] MIPS: uaccess: Fix strlen_user with EVA
Date:   Sun, 24 Jan 2016 22:01:01 +0000
Message-Id: <1453672883-2708-107-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1453672883-2708-1-git-send-email-luis.henriques@canonical.com>
References: <1453672883-2708-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt23 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: James Hogan <james.hogan@imgtec.com>

commit 5dc62fdd8383afbd2faca6b6e6ea1052b45b0124 upstream.

The strlen_user() function calls __strlen_kernel_asm in both branches of
the eva_kernel_access() conditional. For EVA it should be calling
__strlen_user_eva for user accesses, otherwise it will load from the
kernel address space instead of the user address space, and the access
checking will likely be ineffective at preventing it due to EVA's
overlapping user and kernel address spaces.

This was found after extending the test_user_copy module to cover user
string access functions, which gave the following error with EVA:

test_user_copy: illegal strlen_user passed

Fortunately the use of strlen_user() has been all but eradicated from
the mainline kernel, so only out of tree modules could be affected.

Fixes: e3a9b07a9caf ("MIPS: asm: uaccess: Add EVA support for str*_user operations")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10842/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 681331257bac..16e0ea6b99d8 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1397,7 +1397,7 @@ static inline long strlen_user(const char __user *s)
 		might_fault();
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
-			__MODULE_JAL(__strlen_kernel_asm)
+			__MODULE_JAL(__strlen_user_asm)
 			"move\t%0, $2"
 			: "=r" (res)
 			: "r" (s)
