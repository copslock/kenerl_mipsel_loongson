Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Sep 2009 01:58:10 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16136 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493610AbZIJX5r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Sep 2009 01:57:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4aa9926d0002>; Thu, 10 Sep 2009 16:57:33 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 10 Sep 2009 16:57:05 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 10 Sep 2009 16:57:04 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n8ANuvpw002959;
	Thu, 10 Sep 2009 16:56:57 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n8ANupK1002957;
	Thu, 10 Sep 2009 16:56:51 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:	linux-kernel@vger.kernel.org,
	David Daney <ddaney@caviumnetworks.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux390@de.ibm.com, linux-s390@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linux-am33-list@redhat.com, Kyle McMartin <kyle@mcmartin.ca>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-alpha@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Mike Frysinger <vapier@gentoo.org>,
	uclinux-dist-devel@blackfin.uclinux.org
Subject: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable() to compiler.h
Date:	Thu, 10 Sep 2009 16:56:42 -0700
Message-Id: <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4AA991C1.1050800@caviumnetworks.com>
References: <4AA991C1.1050800@caviumnetworks.com>
X-OriginalArrivalTime: 10 Sep 2009 23:57:04.0797 (UTC) FILETIME=[65BC24D0:01CA3272]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Starting with version 4.5, GCC has a new built-in function
__builtin_unreachable() that can be used in places like the kernel's
BUG() where inline assembly is used to transfer control flow.  This
eliminated the need for an endless loop in these places.

The patch adds a new macro 'unreachable()' that will expand to either
__builtin_unreachable() or an endless loop depending on the compiler
version.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: ralf@linux-mips.org
CC: linux-mips@linux-mips.org
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: linux390@de.ibm.com
CC: linux-s390@vger.kernel.org
CC: David Howells <dhowells@redhat.com>
CC: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
CC: linux-am33-list@redhat.com
CC: Kyle McMartin <kyle@mcmartin.ca>
CC: Helge Deller <deller@gmx.de>
CC: linux-parisc@vger.kernel.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@ozlabs.org
CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: linux-alpha@vger.kernel.org
CC: Haavard Skinnemoen <hskinnemoen@atmel.com>
CC: Mike Frysinger <vapier@gentoo.org>
CC: uclinux-dist-devel@blackfin.uclinux.org
---
 include/linux/compiler-gcc4.h |   14 ++++++++++++++
 include/linux/compiler.h      |    5 +++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 450fa59..ab3af40 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -36,4 +36,18 @@
    the kernel context */
 #define __cold			__attribute__((__cold__))
 
+
+#if __GNUC_MINOR__ >= 5
+/*
+ * Mark a position in code as unreachable.  This can be used to
+ * suppress control flow warnings after asm blocks that transfer
+ * control elsewhere.
+ *
+ * Early snapshots of gcc 4.5 don't support this and we can't detect
+ * this in the preprocessor, but we can live with this because they're
+ * unreleased.  Really, we need to have autoconf for the kernel.
+ */
+#define unreachable() __builtin_unreachable()
+#endif
+
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 04fb513..7efd73f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -144,6 +144,11 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 # define barrier() __memory_barrier()
 #endif
 
+/* Unreachable code */
+#ifndef unreachable
+# define unreachable() do { for (;;) ; } while (0)
+#endif
+
 #ifndef RELOC_HIDE
 # define RELOC_HIDE(ptr, off)					\
   ({ unsigned long __ptr;					\
-- 
1.6.2.5
