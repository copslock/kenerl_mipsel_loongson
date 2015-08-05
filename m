Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 17:42:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21143 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012325AbbHEPmN7Jxm0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 17:42:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1C291632BF49A;
        Wed,  5 Aug 2015 16:42:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 16:42:08 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Aug 2015 16:42:07 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Leonid Yegoshin" <leonid.yegoshin@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/3] MIPS: uaccess: Fix strlen_user with EVA
Date:   Wed, 5 Aug 2015 16:41:37 +0100
Message-ID: <1438789299-1608-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1438789299-1608-1-git-send-email-james.hogan@imgtec.com>
References: <1438789299-1608-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15.x-
---
 arch/mips/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 5305d694ffe5..3f959c01bfdb 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1384,7 +1384,7 @@ static inline long strlen_user(const char __user *s)
 		might_fault();
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
-			__MODULE_JAL(__strlen_kernel_asm)
+			__MODULE_JAL(__strlen_user_asm)
 			"move\t%0, $2"
 			: "=r" (res)
 			: "r" (s)
-- 
2.3.6
