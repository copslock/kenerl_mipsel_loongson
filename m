Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jun 2013 22:27:17 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2239 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832029Ab3FOU1O4Uf1O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Jun 2013 22:27:14 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 15 Jun 2013 13:17:54 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 15 Jun 2013 13:26:58 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 15 Jun 2013 13:26:58 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 652BBF2D72; Sat, 15
 Jun 2013 13:26:57 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH] MIPS: Fix include guard macro in uapi/asm/fcntl.h
Date:   Sun, 16 Jun 2013 01:58:44 +0530
Message-ID: <1371328124-29926-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7DA214782L833778522-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

The commit d7f15bb42274a12ac95c237d6d9cb46b691881fa
"MIPS: <uapi/asm/fcntl.h>: Don't reference CONFIG_* symbols."
in linux-mips.org master, causes userspace to break: 

udevd[324]: error getting socket: Invalid argument
udevd[324]: error initializing udev control socket

This is because the include guard in asm/fcntl.h is the same as the one
in uapi/asm/fcntl.h Fix the issue by using _UAPI_ASM_FCNTL_H as include
guard in the uapi file.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
[ I don't see the same commit in kernel.org git. If the patch are not
 yet sent upstream - then this change can be merged to the commit
 d7f15bb]


 arch/mips/include/uapi/asm/fcntl.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 898b953..97e56a5 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -5,8 +5,8 @@
  *
  * Copyright (C) 1995, 96, 97, 98, 99, 2003, 05 Ralf Baechle
  */
-#ifndef _ASM_FCNTL_H
-#define _ASM_FCNTL_H
+#ifndef _UAPI_ASM_FCNTL_H
+#define _UAPI_ASM_FCNTL_H
 
 
 #define O_APPEND	0x0008
@@ -50,4 +50,4 @@
 
 #include <asm-generic/fcntl.h>
 
-#endif /* _ASM_FCNTL_H */
+#endif /* _UAPI_ASM_FCNTL_H */
-- 
1.7.9.5
