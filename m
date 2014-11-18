Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 07:35:09 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:36201 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007304AbaKRGfGl0UmF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 07:35:06 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id sAI6YwWI011569
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 17 Nov 2014 22:35:00 -0800 (PST)
Received: from pek-git.wrs.com (128.224.153.11) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.174.1; Mon, 17 Nov 2014
 22:34:58 -0800
From:   <bin.jiang@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     <bin.jiang@windriver.com>, <ralf@linux-mips.org>
Subject: [PATCH] MIPS: get_user: set the parameter @x to zero on error
Date:   Tue, 18 Nov 2014 14:34:56 +0800
Message-ID: <1416292496-6149-1-git-send-email-bin.jiang@windriver.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Bin.Jiang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bin.jiang@windriver.com
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

From: Bin Jiang <bin.jiang@windriver.com>

The following compile warning is caused to use uninitialized variables:

fs/compat_ioctl.c: In function 'compat_SyS_ioctl':
arch/mips/include/asm/uaccess.h:451:2: warning: 'length' may be used \
                uninitialized in this function [-Wmaybe-uninitialized]
  __asm__ __volatile__(      \
  ^
fs/compat_ioctl.c:208:6: note: 'length' was declared here
  int length, err;
      ^

In get_user function, the parameter @x is used to store result. If the
function return error, the @x won't be set and cause above warning.

According to the description of get_user function, the parameter @x should
be set to zero on error.

Signed-off-by: Bin Jiang <bin.jiang@windriver.com>
---
 arch/mips/include/asm/uaccess.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index a109510..07e9755 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -301,7 +301,8 @@ do {									\
 			__get_kernel_common((x), size, __gu_ptr);	\
 		else							\
 			__get_user_common((x), size, __gu_ptr);		\
-	}								\
+	} else								\
+		(x) = (__typeof__(*(ptr)))0;				\
 									\
 	__gu_err;							\
 })
-- 
1.7.10.4
