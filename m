Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2009 19:43:03 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:32870 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20024675AbZDJSm5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Apr 2009 19:42:57 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49df931f0000>; Fri, 10 Apr 2009 14:42:39 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Apr 2009 11:41:42 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Apr 2009 11:41:41 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n3AIfb2T027331;
	Fri, 10 Apr 2009 11:41:37 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n3AIfadA027329;
	Fri, 10 Apr 2009 11:41:36 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Include linux/errno.h from arch/mips/include/asm/compat.h
Date:	Fri, 10 Apr 2009 11:41:35 -0700
Message-Id: <1239388895-27305-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 10 Apr 2009 18:41:41.0850 (UTC) FILETIME=[FD93D3A0:01C9BA0B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The recent change that added #include <linux/seccomp.h> breaks
(because EINVAL is not defined) when building
arch/mips/kernel/asm-offsets.s if CONFIG_SECCOMP is not defined.
Including errno.h fixes the problem.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/compat.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 6c5b409..b88434e 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -3,6 +3,7 @@
 /*
  * Architecture specific compatibility types
  */
+#include <linux/errno.h>
 #include <linux/seccomp.h>
 #include <linux/thread_info.h>
 #include <linux/types.h>
-- 
1.6.0.6
