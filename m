Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 11:49:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42372 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025971AbcDAJtyKHR6a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Apr 2016 11:49:54 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u319net3023045;
        Fri, 1 Apr 2016 11:49:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u319newK023044;
        Fri, 1 Apr 2016 11:49:40 +0200
Message-Id: <13b2723b59281cacda362f261ba57b643f21a0d1.1459501014.git.ralf@linux-mips.org>
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
Date:   Fri, 1 Apr 2016 10:56:56 +0200
Subject: [PATCH v3 2/3] perf tools: Add support for MIPS userspace DWARF
 callchains.
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52825
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

Hack up the Makefile and add support code for mips unwinding
and dwarf-regs.

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
 tools/perf/arch/mips/Build                   |  2 +-
 tools/perf/arch/mips/Makefile                |  7 +++
 tools/perf/arch/mips/include/perf_regs.h     | 84 ++++++++++++++++++++++++++++
 tools/perf/arch/mips/util/Build              |  2 +
 tools/perf/arch/mips/util/dwarf-regs.c       | 37 ++++++++++++
 tools/perf/arch/mips/util/unwind-libunwind.c | 20 +++++++
 6 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/mips/Makefile
 create mode 100644 tools/perf/arch/mips/include/perf_regs.h
 create mode 100644 tools/perf/arch/mips/util/Build
 create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c

diff --git a/tools/perf/arch/mips/Build b/tools/perf/arch/mips/Build
index 1bb8bf6..54afe4a 100644
--- a/tools/perf/arch/mips/Build
+++ b/tools/perf/arch/mips/Build
@@ -1 +1 @@
-# empty
+libperf-y += util/
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
new file mode 100644
index 0000000..fe9b61e
--- /dev/null
+++ b/tools/perf/arch/mips/Makefile
@@ -0,0 +1,7 @@
+ifndef NO_DWARF
+PERF_HAVE_DWARF_REGS := 1
+LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
+endif
+ifndef NO_LIBUNWIND
+LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/unwind.o
+endif
diff --git a/tools/perf/arch/mips/include/perf_regs.h b/tools/perf/arch/mips/include/perf_regs.h
new file mode 100644
index 0000000..a91b904
--- /dev/null
+++ b/tools/perf/arch/mips/include/perf_regs.h
@@ -0,0 +1,84 @@
+#ifndef ARCH_PERF_REGS_H
+#define ARCH_PERF_REGS_H
+
+#include <stdlib.h>
+#include "../../util/types.h"
+#include <asm/perf_regs.h>
+
+#define PERF_REG_IP PERF_REG_MIPS_PC
+#define PERF_REG_SP PERF_REG_MIPS_R29
+
+#define PERF_REGS_MASK ((1ULL << PERF_REG_MIPS_MAX) - 1)
+
+static inline const char *perf_reg_name(int id)
+{
+	switch (id) {
+	case PERF_REG_MIPS_PC:
+		return "PC";
+	case PERF_REG_MIPS_R1:
+		return "$1";
+	case PERF_REG_MIPS_R2:
+		return "$2";
+	case PERF_REG_MIPS_R3:
+		return "$3";
+	case PERF_REG_MIPS_R4:
+		return "$4";
+	case PERF_REG_MIPS_R5:
+		return "$5";
+	case PERF_REG_MIPS_R6:
+		return "$6";
+	case PERF_REG_MIPS_R7:
+		return "$7";
+	case PERF_REG_MIPS_R8:
+		return "$8";
+	case PERF_REG_MIPS_R9:
+		return "$9";
+	case PERF_REG_MIPS_R10:
+		return "$10";
+	case PERF_REG_MIPS_R11:
+		return "$11";
+	case PERF_REG_MIPS_R12:
+		return "$12";
+	case PERF_REG_MIPS_R13:
+		return "$13";
+	case PERF_REG_MIPS_R14:
+		return "$14";
+	case PERF_REG_MIPS_R15:
+		return "$15";
+	case PERF_REG_MIPS_R16:
+		return "$16";
+	case PERF_REG_MIPS_R17:
+		return "$17";
+	case PERF_REG_MIPS_R18:
+		return "$18";
+	case PERF_REG_MIPS_R19:
+		return "$19";
+	case PERF_REG_MIPS_R20:
+		return "$20";
+	case PERF_REG_MIPS_R21:
+		return "$21";
+	case PERF_REG_MIPS_R22:
+		return "$22";
+	case PERF_REG_MIPS_R23:
+		return "$23";
+	case PERF_REG_MIPS_R24:
+		return "$24";
+	case PERF_REG_MIPS_R25:
+		return "$25";
+
+	case PERF_REG_MIPS_R28:
+		return "$28";
+	case PERF_REG_MIPS_R29:
+		return "$29";
+	case PERF_REG_MIPS_R30:
+		return "$30";
+	case PERF_REG_MIPS_R31:
+		return "$31";
+	default:
+		break;
+	}
+	return NULL;
+}
+
+
+#endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
new file mode 100644
index 0000000..baeccb0
--- /dev/null
+++ b/tools/perf/arch/mips/util/Build
@@ -0,0 +1,2 @@
+libperf-$(CONFIG_DWARF)		+= dwarf-regs.o
+libperf-$(CONFIG_LIBUNWIND)	+= unwind-libunwind.o
diff --git a/tools/perf/arch/mips/util/dwarf-regs.c b/tools/perf/arch/mips/util/dwarf-regs.c
new file mode 100644
index 0000000..165e017
--- /dev/null
+++ b/tools/perf/arch/mips/util/dwarf-regs.c
@@ -0,0 +1,37 @@
+/*
+ * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <libio.h>
+#include <dwarf-regs.h>
+
+static const char *mips_gpr_names[32] = {
+	"$0", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9",
+	"$10", "$11", "$12", "$13", "$14", "$15", "$16", "$17", "$18", "$19",
+	"$20", "$21", "$22", "$23", "$24", "$25", "$26", "$27", "$28", "$29",
+	"$30", "$31"
+};
+
+const char *get_arch_regstr(unsigned int n)
+{
+	if (n < 32)
+		return mips_gpr_names[n];
+	if (n == 64)
+		return "hi";
+	if (n == 65)
+		return "lo";
+	return NULL;
+}
diff --git a/tools/perf/arch/mips/util/unwind-libunwind.c b/tools/perf/arch/mips/util/unwind-libunwind.c
new file mode 100644
index 0000000..612949b
--- /dev/null
+++ b/tools/perf/arch/mips/util/unwind-libunwind.c
@@ -0,0 +1,20 @@
+
+#include <errno.h>
+#include <libunwind.h>
+#include "perf_regs.h"
+#include "../../util/unwind.h"
+
+int unwind__arch_reg_id(int regnum)
+{
+	switch (regnum) {
+	case UNW_MIPS_R1 ... UNW_MIPS_R25:
+		return regnum - UNW_MIPS_R1 + PERF_REG_MIPS_R1;
+	case UNW_MIPS_R28 ... UNW_MIPS_R31:
+		return regnum - UNW_MIPS_R28 + PERF_REG_MIPS_R28;
+	case UNW_MIPS_PC:
+		return PERF_REG_MIPS_PC;
+	default:
+		pr_err("unwind: invalid reg id %d\n", regnum);
+		return -EINVAL;
+	}
+}
-- 
2.5.5
