Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 02:11:27 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:37895 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011081AbcATBLZFgQVw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 02:11:25 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1aLhHq-00011z-BS; Wed, 20 Jan 2016 01:10:14 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1aLhHn-0000hR-Iu; Tue, 19 Jan 2016 17:10:11 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 127/160] MIPS: uaccess: Fix strlen_user with EVA
Date:   Tue, 19 Jan 2016 17:06:45 -0800
Message-Id: <1453252038-31915-128-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1453252038-31915-1-git-send-email-kamal@canonical.com>
References: <1453252038-31915-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt13 -stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index bf8b324..2398046 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1355,7 +1355,7 @@ static inline long strlen_user(const char __user *s)
 		might_fault();
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
-			__MODULE_JAL(__strlen_kernel_asm)
+			__MODULE_JAL(__strlen_user_asm)
 			"move\t%0, $2"
 			: "=r" (res)
 			: "r" (s)
-- 
1.9.1
