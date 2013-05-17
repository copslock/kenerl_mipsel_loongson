Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 21:01:18 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:63040 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835009Ab3EQTAxcrk95 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 May 2013 21:00:53 +0200
Received: by mail-pa0-f47.google.com with SMTP id kl13so3853121pab.34
        for <multiple recipients>; Fri, 17 May 2013 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=v3iL58ebNl89YEBVswVAwbnFQ1KrQXLH4Y+Jej6th44=;
        b=liyJzbjA6ZZ1b8cUwoTT/d0kvZQs61C/KTqg0NZO39nBHVgVeHD7ZYGUAQZiBUYwT2
         bZxhV4SFLHfpZZiBQMmN8krpY0xysZYqFd3r8TyAGGvHWulmGYyjHCimMGn2S802PpOl
         s1ULCOWsEdZAvfN/GiYnC56muf/wbxu1FwcH8XtguOXtirbxMIfau7Kbstrl0tyXJgMw
         nigCuabz5KbJ99eNnoUApTiFlFVmeTp7gALNQb2pLqwlGBEGVfa1c/keBgY6PtLW/ec9
         tDF5XR4qVxeC52vsir4bKEoTgT0iDzp0oYJaG/bgpJZKTV2/fJbHcIcMIvgUhXXaffkQ
         DA3g==
X-Received: by 10.68.177.33 with SMTP id cn1mr49949988pbc.189.1368817246810;
        Fri, 17 May 2013 12:00:46 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id 3sm5980346pbj.46.2013.05.17.12.00.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 12:00:45 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4HJ0hTG011588;
        Fri, 17 May 2013 12:00:43 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4HJ0hvb011587;
        Fri, 17 May 2013 12:00:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] perf tools: Add support for MIPS userspace DWARF callchains.
Date:   Fri, 17 May 2013 12:00:37 -0700
Message-Id: <1368817238-11548-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1368817238-11548-1-git-send-email-ddaney.cavm@gmail.com>
References: <1368817238-11548-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
---
 tools/perf/Makefile                      |  3 ++
 tools/perf/arch/mips/Makefile            |  7 +++
 tools/perf/arch/mips/include/perf_regs.h | 84 ++++++++++++++++++++++++++++++++
 tools/perf/arch/mips/util/dwarf-regs.c   | 37 ++++++++++++++
 tools/perf/arch/mips/util/unwind.c       | 20 ++++++++
 5 files changed, 151 insertions(+)
 create mode 100644 tools/perf/arch/mips/Makefile
 create mode 100644 tools/perf/arch/mips/include/perf_regs.h
 create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/mips/util/unwind.c

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 55b42b2..b1aaca2 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -505,6 +505,9 @@ ifeq ($(NO_PERF_REGS),0)
   ifeq ($(ARCH),x86)
     LIB_H += arch/x86/include/perf_regs.h
   endif
+  ifeq ($(ARCH),mips)
+    LIB_H += arch/mips/include/perf_regs.h
+  endif
 endif
 
 ifndef NO_LIBNUMA
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
diff --git a/tools/perf/arch/mips/util/unwind.c b/tools/perf/arch/mips/util/unwind.c
new file mode 100644
index 0000000..612949b
--- /dev/null
+++ b/tools/perf/arch/mips/util/unwind.c
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
1.7.11.7
