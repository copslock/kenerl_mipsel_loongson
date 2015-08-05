Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 17:50:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2229 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012080AbbHEPtcv42c0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 17:49:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 66533443975B4;
        Wed,  5 Aug 2015 16:49:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 16:49:26 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Aug 2015 16:49:26 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/7] test_user_copy: Check __copy_in_user()/copy_in_user()
Date:   Wed, 5 Aug 2015 16:48:52 +0100
Message-ID: <1438789735-4643-5-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 48601
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

Add basic success/failure checking of copy_in_user() which copies data
from userspace to userspace (or kernel to kernel), and its unchecking
cousin __copy_in_user() which assumes that access_ok() has already been
used as appropriate.

The following cases are checked:
- __copy_in_user/copy_in_user from user to user should succeed.
- __copy_in_user/copy_in_user involving 1 or 2 kernel pointers should
  not succeed.
- __copy_in_user/copy_in_user from kernel to kernel should succeed when
  user address limit is set for kernel accesses.

New tests:
- legitimate copy_in_user
- legitimate __copy_in_user
- illegal all-kernel copy_in_user
- illegal copy_in_user to kernel
- illegal copy_in_user from kernel
- illegal all-kernel __copy_in_user
- illegal __copy_in_user to kernel
- illegal __copy_in_user from kernel
- legitimate all-kernel copy_in_user
- legitimate all-kernel __copy_in_user

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 4ec2cfa916c1..310e796beef6 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -64,6 +64,8 @@ static int __init test_user_copy_init(void)
 		    "legitimate copy_from_user failed");
 	ret |= test(copy_to_user(usermem, kmem, PAGE_SIZE),
 		    "legitimate copy_to_user failed");
+	ret |= test(copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
+		    "legitimate copy_in_user failed");
 	ret |= test(get_user(value, (unsigned long __user *)usermem),
 		    "legitimate get_user failed");
 	ret |= test(put_user(value, (unsigned long __user *)usermem),
@@ -79,6 +81,8 @@ static int __init test_user_copy_init(void)
 		    "legitimate __copy_from_user failed");
 	ret |= test(__copy_to_user(usermem, kmem, PAGE_SIZE),
 		    "legitimate __copy_to_user failed");
+	ret |= test(__copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
+		    "legitimate __copy_in_user failed");
 	ret |= test(__get_user(value, (unsigned long __user *)usermem),
 		    "legitimate __get_user failed");
 	ret |= test(__put_user(value, (unsigned long __user *)usermem),
@@ -99,6 +103,15 @@ static int __init test_user_copy_init(void)
 	ret |= test(!copy_to_user((char __user *)kmem, bad_usermem,
 				  PAGE_SIZE),
 		    "illegal reversed copy_to_user passed");
+	ret |= test(!copy_in_user((char __user *)kmem,
+				  (char __user *)(kmem + PAGE_SIZE), PAGE_SIZE),
+		    "illegal all-kernel copy_in_user passed");
+	ret |= test(!copy_in_user((char __user *)kmem, usermem,
+				  PAGE_SIZE),
+		    "illegal copy_in_user to kernel passed");
+	ret |= test(!copy_in_user(usermem, (char __user *)kmem,
+				  PAGE_SIZE),
+		    "illegal copy_in_user from kernel passed");
 	ret |= test(!get_user(value, (unsigned long __user *)kmem),
 		    "illegal get_user passed");
 	ret |= test(!put_user(value, (unsigned long __user *)kmem),
@@ -130,6 +143,16 @@ static int __init test_user_copy_init(void)
 	ret |= test(!__copy_to_user((char __user *)kmem, bad_usermem,
 				    PAGE_SIZE),
 		    "illegal reversed __copy_to_user passed");
+	ret |= test(!__copy_in_user((char __user *)kmem,
+				    (char __user *)(kmem + PAGE_SIZE),
+				    PAGE_SIZE),
+		    "illegal all-kernel __copy_in_user passed");
+	ret |= test(!__copy_in_user((char __user *)kmem, usermem,
+				    PAGE_SIZE),
+		    "illegal __copy_in_user to kernel passed");
+	ret |= test(!__copy_in_user(usermem, (char __user *)kmem,
+				    PAGE_SIZE),
+		    "illegal __copy_in_user from kernel passed");
 	ret |= test(!__get_user(value, (unsigned long __user *)kmem),
 		    "illegal __get_user passed");
 	ret |= test(!__put_user(value, (unsigned long __user *)kmem),
@@ -152,6 +175,9 @@ static int __init test_user_copy_init(void)
 	ret |= test(copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
 				 PAGE_SIZE),
 		    "legitimate all-kernel copy_to_user failed");
+	ret |= test(copy_in_user((char __user *)kmem,
+				 (char __user *)(kmem + PAGE_SIZE), PAGE_SIZE),
+		    "legitimate all-kernel copy_in_user failed");
 	ret |= test(get_user(value, (unsigned long __user *)kmem),
 		    "legitimate kernel get_user failed");
 	ret |= test(put_user(value, (unsigned long __user *)kmem),
@@ -170,6 +196,10 @@ static int __init test_user_copy_init(void)
 	ret |= test(__copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
 				   PAGE_SIZE),
 		    "legitimate all-kernel __copy_to_user failed");
+	ret |= test(__copy_in_user((char __user *)kmem,
+				   (char __user *)(kmem + PAGE_SIZE),
+				   PAGE_SIZE),
+		    "legitimate all-kernel __copy_in_user failed");
 	ret |= test(__get_user(value, (unsigned long __user *)kmem),
 		    "legitimate kernel __get_user failed");
 	ret |= test(__put_user(value, (unsigned long __user *)kmem),
-- 
2.3.6
