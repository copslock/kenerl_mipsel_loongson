Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 17:51:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35810 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012442AbbHEPtdtBVs0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 17:49:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9950F5427090A;
        Wed,  5 Aug 2015 16:49:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 16:49:27 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Aug 2015 16:49:27 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/7] test_user_copy: Check user string accessors
Date:   Wed, 5 Aug 2015 16:48:54 +0100
Message-ID: <1438789735-4643-7-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 48603
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

Add basic success/failure checking of the user string functions which
copy or find the length of userland strings.

The following cases are checked:
- strncpy_from_user() with legitimate user to kernel addresses, illegal
  all-kernel and reversed addresses, and legitimate all-kernel
  addresses.
- strnlen_user()/strlen_user() with a legitimate user address, an
  illegal kernel address, and a legitimate kernel address.

This caught a bug in the MIPS Enhanced Virtual Memory (EVA)
implementation:
test_user_copy: illegal strlen_user passed

Due to strlen_user() accidentally always using normal kernel loads, and
the EVA user/kernel address ranges overlapping.

New tests:
- legitimate strncpy_from_user
- legitimate strnlen_user
- legitimate strlen_user
- illegal all-kernel strncpy_from_user
- illegal reversed strncpy_from_user
- illegal strnlen_user
- illegal strlen_user
- legitimate all-kernel strncpy_from_user
- legitimate kernel strnlen_user
- legitimate kernel strlen_user

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 6cbdb0a15ca2..6d05ec5f6cfa 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -72,6 +72,12 @@ static int __init test_user_copy_init(void)
 		    "legitimate put_user failed");
 	ret |= test(clear_user(usermem, PAGE_SIZE) != 0,
 		    "legitimate clear_user passed");
+	ret |= test(strncpy_from_user(kmem, usermem, PAGE_SIZE) < 0,
+		    "legitimate strncpy_from_user failed");
+	ret |= test(strnlen_user(usermem, PAGE_SIZE) == 0,
+		    "legitimate strnlen_user failed");
+	ret |= test(strlen_user(usermem) == 0,
+		    "legitimate strlen_user failed");
 
 	ret |= test(!access_ok(VERIFY_READ, usermem, PAGE_SIZE * 2),
 		    "legitimate access_ok VERIFY_READ failed");
@@ -122,6 +128,16 @@ static int __init test_user_copy_init(void)
 		    "illegal put_user passed");
 	ret |= test(clear_user((char __user *)kmem, PAGE_SIZE) != PAGE_SIZE,
 		    "illegal kernel clear_user passed");
+	ret |= test(strncpy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+				      PAGE_SIZE) >= 0,
+		    "illegal all-kernel strncpy_from_user passed");
+	ret |= test(strncpy_from_user(bad_usermem, (char __user *)kmem,
+				      PAGE_SIZE) >= 0,
+		    "illegal reversed strncpy_from_user passed");
+	ret |= test(strnlen_user((char __user *)kmem, PAGE_SIZE) != 0,
+		    "illegal strnlen_user passed");
+	ret |= test(strlen_user((char __user *)kmem) != 0,
+		    "illegal strlen_user passed");
 
 	/*
 	 * If unchecked user accesses (__*) on this architecture cannot access
@@ -201,6 +217,13 @@ static int __init test_user_copy_init(void)
 		    "legitimate kernel put_user failed");
 	ret |= test(clear_user((char __user *)kmem, PAGE_SIZE) != 0,
 		    "legitimate kernel clear_user failed");
+	ret |= test(strncpy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
+				      PAGE_SIZE) < 0,
+		    "legitimate all-kernel strncpy_from_user failed");
+	ret |= test(strnlen_user((char __user *)kmem, PAGE_SIZE) == 0,
+		    "legitimate kernel strnlen_user failed");
+	ret |= test(strlen_user((char __user *)kmem) == 0,
+		    "legitimate kernel strlen_user failed");
 
 	ret |= test(!access_ok(VERIFY_READ, (char __user *)kmem, PAGE_SIZE * 2),
 		    "legitimate kernel access_ok VERIFY_READ failed");
-- 
2.3.6
