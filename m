Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 11:50:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42374 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025973AbcDAJtyJ-lka (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Apr 2016 11:49:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u319neO8023049;
        Fri, 1 Apr 2016 11:49:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u319neNY023048;
        Fri, 1 Apr 2016 11:49:40 +0200
Message-Id: <a3a7e99203ceaf662dc61895418c76e837eaf6ab.1459501014.git.ralf@linux-mips.org>
In-Reply-To: <cover.1459501014.git.ralf@linux-mips.org>
References: <cover.1459501014.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Fri, 1 Apr 2016 10:56:57 +0200
Subject: [PATCH v3 3/3] perf tools: Hook up MIPS unwind and dwarf-regs in the
 Makefile
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 tools/perf/config/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index f7d7f5a..713c69c 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -51,6 +51,11 @@ ifeq ($(NO_PERF_REGS),0)
   $(call detected,CONFIG_PERF_REGS)
 endif
 
+ifeq ($(ARCH),mips)
+  NO_PERF_REGS := 0
+  LIBUNWIND_LIBS = -lunwind -lunwind-mips
+endif
+
 # So far there's only x86 and arm libdw unwind support merged in perf.
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
-- 
2.5.5
