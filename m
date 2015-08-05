Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 17:42:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63381 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012327AbbHEPmROzdL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 17:42:17 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3557D39385C39;
        Wed,  5 Aug 2015 16:42:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 16:42:11 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Aug 2015 16:42:10 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Leonid Yegoshin" <leonid.yegoshin@imgtec.com>
Subject: [PATCH 2/3] MIPS: uaccess: Take EVA into account in __copy_from_user()
Date:   Wed, 5 Aug 2015 16:41:38 +0100
Message-ID: <1438789299-1608-3-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 48595
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

When EVA is in use, __copy_from_user() was unconditionally using the EVA
instructions to read the user address space, however this can also be
used for kernel access. If the address isn't a valid user address it
will cause an address error or TLB exception, and if it is then user
memory may be read instead of kernel memory.

For example in the following stack trace from Linux v3.10 (changes since
then will prevent this particular one still happening) kernel_sendmsg()
set the user address limit to KERNEL_DS, and tcp_sendmsg() goes on to
use __copy_from_user() with a kernel address in KSeg0.

[<8002d434>] __copy_fromuser_common+0x10c/0x254
[<805710e0>] tcp_sendmsg+0x5f4/0xf00
[<804e8e3c>] sock_sendmsg+0x78/0xa0
[<804e8f28>] kernel_sendmsg+0x24/0x38
[<804ee0f8>] sock_no_sendpage+0x70/0x7c
[<8017c820>] pipe_to_sendpage+0x80/0x98
[<8017c6b0>] splice_from_pipe_feed+0xa8/0x198
[<8017cc54>] __splice_from_pipe+0x4c/0x8c
[<8017e844>] splice_from_pipe+0x58/0x78
[<8017e884>] generic_splice_sendpage+0x20/0x2c
[<8017d690>] do_splice_from+0xb4/0x110
[<8017d710>] direct_splice_actor+0x24/0x30
[<8017d394>] splice_direct_to_actor+0xd8/0x208
[<8017d51c>] do_splice_direct+0x58/0x7c
[<8014eaf4>] do_sendfile+0x1dc/0x39c
[<8014f82c>] SyS_sendfile+0x90/0xf8

Add the eva_kernel_access() check in __copy_from_user() like the one in
copy_from_user().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
I've not Cc'd stable on this patch as eva_kernel_access() was only added
in 4.2. I'll submit a backport once it is merged.
---
 arch/mips/include/asm/uaccess.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 3f959c01bfdb..5014e187df23 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1122,9 +1122,15 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	might_fault();							\
-	__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,		\
-					   __cu_len);			\
+	if (eva_kernel_access()) {					\
+		__cu_len = __invoke_copy_from_kernel(__cu_to,		\
+						     __cu_from,		\
+						     __cu_len);		\
+	} else {							\
+		might_fault();						\
+		__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,	\
+						   __cu_len);		\
+	}								\
 	__cu_len;							\
 })
 
-- 
2.3.6
