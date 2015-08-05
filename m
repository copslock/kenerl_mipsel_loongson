Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 17:50:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10691 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012327AbbHEPtbi0Uq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 17:49:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3F6C97EEB35EA;
        Wed,  5 Aug 2015 16:49:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 16:49:25 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Aug 2015 16:49:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/7] test_user_copy: Check unchecked accessors
Date:   Wed, 5 Aug 2015 16:48:50 +0100
Message-ID: <1438789735-4643-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48599
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

Currently the test_user_copy module only tests the user accessors which
already check the address with access_ok(). Corresponding unchecked
accessors exist however which may be used after access_ok() is checked.
Since the addresses the test uses are known to be valid kernel
addresses, test these unchecked accessors too, as well as access_ok()
itself.

For legitimate user accesses we test the corresponding unchecked macros.
They should all work just as well as the checking versions.

Similarly, for legitimate kernel accesses the unchecked macros are
expected to succeed, and access kernel rather than user memory.

For invalid user accesses we only test the corresponding unchecked
macros in configurations where the behaviour is both known and
important to verify the implementation. Currently this is only enabled
for MIPS with Enhanced Virtual Addressing (EVA) enabled, where user
accesses MUST use the EVA loads/stores, which can only access valid user
mode memory anyway.

New tests:
- legitimate access_ok VERIFY_READ
- legitimate access_ok VERIFY_WRITE
- legitimate __copy_from_user
- legitimate __copy_to_user
- legitimate __get_user
- legitimate __put_user
- illegal all-kernel __copy_from_user
- illegal reversed __copy_from_user
- illegal all-kernel __copy_to_user
- illegal reversed __copy_to_user
- illegal __get_user
- illegal __put_user
- legitimate kernel access_ok VERIFY_READ
- legitimate kernel access_ok VERIFY_WRITE
- legitimate all-kernel __copy_from_user
- legitimate all-kernel __copy_to_user
- legitimate kernel __get_user
- legitimate kernel __put_user

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 445ca92b0b80..23fb9d15f50c 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -69,6 +69,19 @@ static int __init test_user_copy_init(void)
 	ret |= test(put_user(value, (unsigned long __user *)usermem),
 		    "legitimate put_user failed");
 
+	ret |= test(!access_ok(VERIFY_READ, usermem, PAGE_SIZE * 2),
+		    "legitimate access_ok VERIFY_READ failed");
+	ret |= test(!access_ok(VERIFY_WRITE, usermem, PAGE_SIZE * 2),
+		    "legitimate access_ok VERIFY_WRITE failed");
+	ret |= test(__copy_from_user(kmem, usermem, PAGE_SIZE),
+		    "legitimate __copy_from_user failed");
+	ret |= test(__copy_to_user(usermem, kmem, PAGE_SIZE),
+		    "legitimate __copy_to_user failed");
+	ret |= test(__get_user(value, (unsigned long __user *)usermem),
+		    "legitimate __get_user failed");
+	ret |= test(__put_user(value, (unsigned long __user *)usermem),
+		    "legitimate __put_user failed");
+
 	/* Invalid usage: none of these should succeed. */
 	ret |= test(!copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
 				    PAGE_SIZE),
@@ -88,6 +101,36 @@ static int __init test_user_copy_init(void)
 		    "illegal put_user passed");
 
 	/*
+	 * If unchecked user accesses (__*) on this architecture cannot access
+	 * kernel mode (i.e. access_ok() is redundant), and usually faults when
+	 * attempted, check this behaviour.
+	 *
+	 * These tests are enabled for:
+	 * - MIPS with Enhanced Virtual Addressing (EVA): user accesses use EVA
+	 *   instructions which can only access user mode accessible memory. It
+	 *   is assumed to be unlikely that user address space mappings will
+	 *   intersect the kernel buffer address.
+	 */
+#if defined(CONFIG_MIPS) && defined(CONFIG_EVA)
+	ret |= test(!__copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+				      PAGE_SIZE),
+		    "illegal all-kernel __copy_from_user passed");
+	ret |= test(!__copy_from_user(bad_usermem, (char __user *)kmem,
+				      PAGE_SIZE),
+		    "illegal reversed __copy_from_user passed");
+	ret |= test(!__copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
+				    PAGE_SIZE),
+		    "illegal all-kernel __copy_to_user passed");
+	ret |= test(!__copy_to_user((char __user *)kmem, bad_usermem,
+				    PAGE_SIZE),
+		    "illegal reversed __copy_to_user passed");
+	ret |= test(!__get_user(value, (unsigned long __user *)kmem),
+		    "illegal __get_user passed");
+	ret |= test(!__put_user(value, (unsigned long __user *)kmem),
+		    "illegal __put_user passed");
+#endif
+
+	/*
 	 * Test access to kernel memory by adjusting address limit.
 	 * This is used by the kernel to invoke system calls with kernel
 	 * pointers.
@@ -106,6 +149,22 @@ static int __init test_user_copy_init(void)
 	ret |= test(put_user(value, (unsigned long __user *)kmem),
 		    "legitimate kernel put_user failed");
 
+	ret |= test(!access_ok(VERIFY_READ, (char __user *)kmem, PAGE_SIZE * 2),
+		    "legitimate kernel access_ok VERIFY_READ failed");
+	ret |= test(!access_ok(VERIFY_WRITE, (char __user *)kmem,
+			       PAGE_SIZE * 2),
+		    "legitimate kernel access_ok VERIFY_WRITE failed");
+	ret |= test(__copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+				     PAGE_SIZE),
+		    "legitimate all-kernel __copy_from_user failed");
+	ret |= test(__copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
+				   PAGE_SIZE),
+		    "legitimate all-kernel __copy_to_user failed");
+	ret |= test(__get_user(value, (unsigned long __user *)kmem),
+		    "legitimate kernel __get_user failed");
+	ret |= test(__put_user(value, (unsigned long __user *)kmem),
+		    "legitimate kernel __put_user failed");
+
 	/* Restore previous address limit. */
 	set_fs(fs);
 
-- 
2.3.6
