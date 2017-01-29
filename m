Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2017 04:24:54 +0100 (CET)
Received: from resqmta-ch2-01v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:33]:37712
        "EHLO resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdA2DYrFQnlR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jan 2017 04:24:47 +0100
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
        by resqmta-ch2-01v.sys.comcast.net with SMTP
        id Xg6XctacdRNZDXg6fc9PbC; Sun, 29 Jan 2017 03:24:45 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-02v.sys.comcast.net with SMTP
        id Xg6ec62vKWkBdXg6ecEjOG; Sun, 29 Jan 2017 03:24:45 +0000
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH] MIPS: Disable stack checks on MIPS kernels
Message-ID: <8d0e3484-c8bd-2559-0809-2631474a11f8@gentoo.org>
Date:   Sat, 28 Jan 2017 22:24:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHl12E6/vQl5rcnznWxvezTmrCYbZTT0xfqMze6OfVOgBjaI0nHjA1mVQjGKBoue4XuWQu3n8KSn0oXJ2sgyUCNC9FcQAcVMfGIhwdK5Wz7Gq+RVe9QH
 z2AZ9TofqwCyjZOpRCl7Lh6K1rNBa0Hu4zeW93aOFR3UJdRV4z2zX/y6AoFVGTEWz2HQ0VY9HwPBqNciEzhMr37IHtXv/czwRGoOTwQeocK1sQ6ztGXvGsLj
 WbVKOYFCcEdzqDIQVUeD61d1w1JzWTMdsVM7ci5Kpho=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Disable stack checking on MIPS kernels.  Some distribution toolchains
might pass the -fstack-check option to gcc.  This results in a
store-doubleword instruction being emitted at the top of all
functions that checks the available stack space.  E.g.,

  a80000000001d740 <per_cpu_init>:
  a80000000001d740:       ffa0bfc0        sd      zero,-16448(sp)
  a80000000001d744:       2405ffc9        li      a1,-55
  a80000000001d748:       67bdffc0        daddiu  sp,sp,-64

Generally, this is undesirable, and especially on the SGI IP27
platform, it will trigger a NULL pointer dereference in
'_raw_spin_lock_irq' during early init.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Suggested-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/Makefile |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

linux-mips-4.10-disable-stack-check.patch
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1a6bac7b076f..6b2a30442105 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -131,6 +131,21 @@ cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= $(shell $(CC) -dumpmachine |grep -q 'mips.
 
 cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
 				   -fno-omit-frame-pointer
+
+# Some distribution-specific toolchains might pass the -fstack-check
+# option during the build, which adds a simple stack-probe at the beginning
+# of every function.  This stack probe is to ensure that there is enough
+# stack space, else a SEGV is generated.  This is not desirable for MIPS
+# as kernel stacks are small, placed in unmapped virtual memory, and do not
+# grow when overflowed.  Especially on SGI IP27 platforms, this check will
+# lead to a NULL pointer dereference in _raw_spin_lock_irq.
+#
+# In disassembly, this stack probe appears at the top of a function as:
+#    sd		zero,<offset>(sp)
+# Where <offset> is a negative value.
+#
+cflags-y += -fno-stack-check
+
 #
 # CPU-dependent compiler/assembler options for optimization.
 #
