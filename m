Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 02:06:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55088 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27024612AbbDHAGI5N8FO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Apr 2015 02:06:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t38068AH014794;
        Wed, 8 Apr 2015 02:06:08 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t38068x3014793;
        Wed, 8 Apr 2015 02:06:08 +0200
Message-Id: <f43306ea57733a711b66a92a5e5f17fd1a6f3f8a.1428450297.git.ralf@linux-mips.org>
In-Reply-To: <cover.1428450297.git.ralf@linux-mips.org>
References: <cover.1428450297.git.ralf@linux-mips.org>
From:   David Daney <david.daney@cavium.com>
Date:   Wed, 08 Apr 2015 01:58:47 +0200
Subject: [PATCH 2/2] perf tools: Hook up MIPS unwind and dwarf-regs in the
 Makefile
To:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

From: David Daney <david.daney@cavium.com>

Define a new symbol (ARCH_SUPPORTS_LIBUNWIND) in config/Makefile.
Use this from x86 and MIPS to gate testing of libunwind.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Patchwork: https://patchwork.linux-mips.org/patch/5250/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 tools/perf/config/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index cc22408..0d0595e 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -27,19 +27,29 @@ ifeq ($(ARCH),x86)
   else
     LIBUNWIND_LIBS = -lunwind -lunwind-x86
   endif
+  ARCH_SUPPORTS_LIBUNWIND := 1
   NO_PERF_REGS := 0
 endif
 
 ifeq ($(ARCH),arm)
   NO_PERF_REGS := 0
+  ARCH_SUPPORTS_LIBUNWIND := 1
   LIBUNWIND_LIBS = -lunwind -lunwind-arm
 endif
 
 ifeq ($(ARCH),arm64)
   NO_PERF_REGS := 0
+  ARCH_SUPPORTS_LIBUNWIND := 1
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
 
+# Additional ARCH settings for MIPS
+ifeq ($(ARCH),mips)
+  ARCH_SUPPORTS_LIBUNWIND := 1
+  NO_PERF_REGS := 0
+  LIBUNWIND_LIBS = -lunwind -lunwind-mips
+endif
+
 # So far there's only x86 and arm libdw unwind support merged in perf.
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
-- 
1.9.3
