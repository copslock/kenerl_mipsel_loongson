Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Apr 2018 16:09:53 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994665AbeDVOJqKxpfl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Apr 2018 16:09:46 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A08FB412;
        Sun, 22 Apr 2018 14:09:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.14 141/164] MIPS: uaccess: Add micromips clobbers to bzero invocation
Date:   Sun, 22 Apr 2018 15:53:28 +0200
Message-Id: <20180422135141.222343620@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit b3d7e55c3f886493235bfee08e1e5a4a27cbcce8 upstream.

The micromips implementation of bzero additionally clobbers registers t7
& t8. Specify this in the clobbers list when invoking bzero.

Fixes: 26c5e07d1478 ("MIPS: microMIPS: Optimise 'memset' core library function.")
Reported-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.10+
Patchwork: https://patchwork.linux-mips.org/patch/19110/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/uaccess.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -654,6 +654,13 @@ __clear_user(void __user *addr, __kernel
 {
 	__kernel_size_t res;
 
+#ifdef CONFIG_CPU_MICROMIPS
+/* micromips memset / bzero also clobbers t7 & t8 */
+#define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$15", "$24", "$31"
+#else
+#define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$31"
+#endif /* CONFIG_CPU_MICROMIPS */
+
 	if (eva_kernel_access()) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
@@ -663,7 +670,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	} else {
 		might_fault();
 		__asm__ __volatile__(
@@ -674,7 +681,7 @@ __clear_user(void __user *addr, __kernel
 			"move\t%0, $6"
 			: "=r" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	}
 
 	return res;
