Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 20:02:14 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:41369 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S21407998AbYJMTCM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Oct 2008 20:02:12 +0100
Received: (qmail invoked by alias); 13 Oct 2008 19:01:53 -0000
Received: from p548B3450.dip0.t-ipconnect.de (EHLO [192.168.120.26]) [84.139.52.80]
  by mail.gmx.net (mp058) with SMTP; 13 Oct 2008 21:01:53 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX19K6D9YNBJKYKHuQdzs2gkBmnobrHXk7Z+GztPwbt
	V1sJHGmLwKNn9A
Message-ID: <48F39B18.9030601@gmx.de>
Date:	Mon, 13 Oct 2008 21:01:44 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 2.0.0.17 (X11/20080922)
MIME-Version: 1.0
To:	ralf Baechle <ralf@linux-mips.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Questions for CONFIG_WEAK_ORDERING  and CONFIG_WEAK_REORDERING_BEYOND_LLSC
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

If a cpu is WEAK_ORDERING schouldn't it do a sync independent of CONFIG_SMP ?

And if it is a SMP system schouldn't it do a sync independent of CONFIG_WEAK_ORDERING ?

And if a cpu has no sync with LLSC schouldn't it do a sync independent of CONFIG_SMP ?

All together, is the following the right thing to do ?
---
 arch/mips/include/asm/barrier.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 8e9ac31..46b2364 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -130,12 +130,13 @@
 
 #endif /* !CONFIG_CPU_HAS_WB */
 
-#if defined(CONFIG_WEAK_ORDERING) && defined(CONFIG_SMP)
+#if defined(CONFIG_WEAK_ORDERING) || defined(CONFIG_SMP)
 #define __WEAK_ORDERING_MB	"       sync	\n"
 #else
 #define __WEAK_ORDERING_MB	"		\n"
 #endif
-#if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC) && defined(CONFIG_SMP)
+
+#if defined(CONFIG_WEAK_REORDERING_BEYOND_LLSC)
 #define __WEAK_LLSC_MB		"       sync	\n"
 #else
 #define __WEAK_LLSC_MB		"		\n"
-- 
1.6.0.2
