Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 10:22:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53134 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27033322AbcEWIVudth5G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 10:21:50 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id EA6F16EEB2B8F;
        Mon, 23 May 2016 09:21:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 23 May 2016 09:21:44 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 23 May 2016 09:21:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Marek <mmarek@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-kbuild@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 1/2] kbuild, x86: Track generated headers with generated-y
Date:   Mon, 23 May 2016 09:21:20 +0100
Message-ID: <1463991681-3531-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1463991681-3531-1-git-send-email-james.hogan@imgtec.com>
References: <1463991681-3531-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53607
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

Track generated header files which aren't already in genhdr-y, alongside
generic-y wrappers in the */include/generated/[uapi/]asm/ directories.
Currently only x86 generates extra headers in these directories, for the
purposes of enumerating system calls for different ABIs, and xen
hypercalls.

This will allow the asm-generic wrapper handling code to remove stale
wrappers when files are removed from generic-y, without also removing
these headers which are generated separately.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Michal Marek <mmarek@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
---
Changes in v2:
- New patch (thanks to kbuild test robot).
---
 Documentation/kbuild/makefiles.txt | 14 ++++++++++++++
 arch/x86/include/asm/Kbuild        |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 13f888a02a3d..385a5ef41c17 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -47,6 +47,7 @@ This document describes the Linux kernel Makefiles.
 		--- 7.2 genhdr-y
 		--- 7.3 destination-y
 		--- 7.4 generic-y
+		--- 7.5 generated-y
 
 	=== 8 Kbuild Variables
 	=== 9 Makefile language
@@ -1319,6 +1320,19 @@ See subsequent chapter for the syntax of the Kbuild file.
 		Example: termios.h
 			#include <asm-generic/termios.h>
 
+	--- 7.5 generated-y
+
+	If an architecture generates other header files alongside generic-y
+	wrappers, and not included in genhdr-y, then generated-y specifies
+	them.
+
+	This prevents them being treated as stale asm-generic wrappers and
+	removed.
+
+		Example:
+			#arch/x86/include/asm/Kbuild
+			generated-y += syscalls_32.h
+
 === 8 Kbuild Variables
 
 The top Makefile exports the following variables:
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index aeac434c9feb..2cfed174e3c9 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -1,5 +1,11 @@
 
 
+generated-y += syscalls_32.h
+generated-y += syscalls_64.h
+generated-y += unistd_32_ia32.h
+generated-y += unistd_64_x32.h
+generated-y += xen-hypercalls.h
+
 genhdr-y += unistd_32.h
 genhdr-y += unistd_64.h
 genhdr-y += unistd_x32.h
-- 
2.4.10
