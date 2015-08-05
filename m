Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 17:51:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12982 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012392AbbHEPtdKGV70 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 17:49:33 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 14F1158BAF5E8;
        Wed,  5 Aug 2015 16:49:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 16:49:27 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 5 Aug 2015 16:49:26 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/7] test_user_copy: Check __copy_{to,from}_user_inatomic()
Date:   Wed, 5 Aug 2015 16:48:53 +0100
Message-ID: <1438789735-4643-6-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 48602
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

Add basic success/failure checking of __copy_to_user_inatomic() and
__copy_from_user_inatomic(). For testing purposes these are similar to
their non-atomic non-checking friends, so the new tests match those for
__copy_to_user() and __copy_from_user().

New tests:
- legitimate __copy_from_user_inatomic
- legitimate __copy_to_user_inatomic
- illegal all-kernel __copy_from_user_inatomic
- illegal reversed __copy_from_user_inatomic
- illegal all-kernel __copy_to_user_inatomic
- illegal reversed __copy_to_user_inatomic
- legitimate all-kernel __copy_from_user_inatomic
- legitimate all-kernel __copy_to_user_inatomic

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/test_user_copy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 310e796beef6..6cbdb0a15ca2 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -79,8 +79,12 @@ static int __init test_user_copy_init(void)
 		    "legitimate access_ok VERIFY_WRITE failed");
 	ret |= test(__copy_from_user(kmem, usermem, PAGE_SIZE),
 		    "legitimate __copy_from_user failed");
+	ret |= test(__copy_from_user_inatomic(kmem, usermem, PAGE_SIZE),
+		    "legitimate __copy_from_user_inatomic failed");
 	ret |= test(__copy_to_user(usermem, kmem, PAGE_SIZE),
 		    "legitimate __copy_to_user failed");
+	ret |= test(__copy_to_user_inatomic(usermem, kmem, PAGE_SIZE),
+		    "legitimate __copy_to_user_inatomic failed");
 	ret |= test(__copy_in_user(usermem, usermem + PAGE_SIZE, PAGE_SIZE),
 		    "legitimate __copy_in_user failed");
 	ret |= test(__get_user(value, (unsigned long __user *)usermem),
@@ -137,12 +141,25 @@ static int __init test_user_copy_init(void)
 	ret |= test(!__copy_from_user(bad_usermem, (char __user *)kmem,
 				      PAGE_SIZE),
 		    "illegal reversed __copy_from_user passed");
+	ret |= test(!__copy_from_user_inatomic(kmem,
+					(char __user *)(kmem + PAGE_SIZE),
+					PAGE_SIZE),
+		    "illegal all-kernel __copy_from_user_inatomic passed");
+	ret |= test(!__copy_from_user_inatomic(bad_usermem, (char __user *)kmem,
+					       PAGE_SIZE),
+		    "illegal reversed __copy_from_user_inatomic passed");
 	ret |= test(!__copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
 				    PAGE_SIZE),
 		    "illegal all-kernel __copy_to_user passed");
 	ret |= test(!__copy_to_user((char __user *)kmem, bad_usermem,
 				    PAGE_SIZE),
 		    "illegal reversed __copy_to_user passed");
+	ret |= test(!__copy_to_user_inatomic((char __user *)kmem,
+					     kmem + PAGE_SIZE, PAGE_SIZE),
+		    "illegal all-kernel __copy_to_user_inatomic passed");
+	ret |= test(!__copy_to_user_inatomic((char __user *)kmem, bad_usermem,
+					     PAGE_SIZE),
+		    "illegal reversed __copy_to_user_inatomic passed");
 	ret |= test(!__copy_in_user((char __user *)kmem,
 				    (char __user *)(kmem + PAGE_SIZE),
 				    PAGE_SIZE),
@@ -193,9 +210,16 @@ static int __init test_user_copy_init(void)
 	ret |= test(__copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
 				     PAGE_SIZE),
 		    "legitimate all-kernel __copy_from_user failed");
+	ret |= test(__copy_from_user_inatomic(kmem,
+					      (char __user *)(kmem + PAGE_SIZE),
+					      PAGE_SIZE),
+		    "legitimate all-kernel __copy_from_user_inatomic failed");
 	ret |= test(__copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
 				   PAGE_SIZE),
 		    "legitimate all-kernel __copy_to_user failed");
+	ret |= test(__copy_to_user_inatomic((char __user *)kmem,
+					    kmem + PAGE_SIZE, PAGE_SIZE),
+		    "legitimate all-kernel __copy_to_user_inatomic failed");
 	ret |= test(__copy_in_user((char __user *)kmem,
 				   (char __user *)(kmem + PAGE_SIZE),
 				   PAGE_SIZE),
-- 
2.3.6
