Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 19:47:09 +0000 (GMT)
Received: from static-72-72-73-123.bstnma.east.verizon.net ([72.72.73.123]:23562
	"EHLO mail.sicortex.com") by ftp.linux-mips.org with ESMTP
	id S20021632AbXCITrF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Mar 2007 19:47:05 +0000
Received: from srv050.sicortex.com (srv050.sicortex.com [10.2.0.50])
	by mail.sicortex.com (Postfix) with ESMTP id 8CE421615FE;
	Fri,  9 Mar 2007 14:46:26 -0500 (EST)
Received: by srv050.sicortex.com (Postfix, from userid 1065)
	id 6E5F65314A; Fri,  9 Mar 2007 14:46:26 -0500 (EST)
From:	Peter Watkins <pwatkins@sicortex.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Peter Watkins <pwatkins@sicortex.com>
Subject: [PATCH] Have sigpoll and sigio band field match glibc for n64.
Date:	Fri,  9 Mar 2007 14:46:26 -0500
Message-Id: <1173469586790-git-send-email-pwatkins@sicortex.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <1173469586997-git-send-email-pwatkins@sicortex.com>
References: [PATCH] Have sigpoll and sigio band field match glibc for n64 <1173469586997-git-send-email-pwatkins@sicortex.com>
Return-Path: <pwatkins@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pwatkins@sicortex.com
Precedence: bulk
X-list: linux-mips

From: Peter Watkins <pwatkins@gsrv020.sicortex.com>

---
 include/asm-mips/siginfo.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/siginfo.h b/include/asm-mips/siginfo.h
index 2e32949..37a0e1f 100644
--- a/include/asm-mips/siginfo.h
+++ b/include/asm-mips/siginfo.h
@@ -32,6 +32,8 @@ #ifdef CONFIG_64BIT
 #define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
 #endif
 
+#define __ARCH_SI_BAND_T int
+
 #include <asm-generic/siginfo.h>
 
 typedef struct siginfo {
-- 
1.4.2.4
