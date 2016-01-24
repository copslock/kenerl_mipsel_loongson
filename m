Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jan 2016 23:03:20 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:43020 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009713AbcAXWDSbXxbB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Jan 2016 23:03:18 +0100
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1aNSkf-0000XM-6s; Sun, 24 Jan 2016 22:03:17 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 050/128] MIPS: uaccess: Take EVA into account in __copy_from_user()
Date:   Sun, 24 Jan 2016 22:00:05 +0000
Message-Id: <1453672883-2708-51-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1453672883-2708-1-git-send-email-luis.henriques@canonical.com>
References: <1453672883-2708-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51344
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

commit 6f06a2c45d8d714ea3b11a360b4a7191e52acaa4 upstream.

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
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10843/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[james.hogan@imgtec.com: backport]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/include/asm/uaccess.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index b9ab717e3619..81d4d7e012ca 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1092,9 +1092,15 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	might_fault();							\
-	__cu_len = __invoke_copy_from_user(__cu_to, __cu_from,		\
-					   __cu_len);			\
+	if (segment_eq(get_fs(), get_ds())) {				\
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
 
