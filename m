Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 10:14:19 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38784 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903730Ab2FGION (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 10:14:13 +0200
Received: by pbbrq13 with SMTP id rq13so748925pbb.36
        for <linux-mips@linux-mips.org>; Thu, 07 Jun 2012 01:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding:x-gm-message-state;
        bh=FRysA/vAd4QdbJphNuobgq47WLUGj03hnFNLQ46zo+s=;
        b=VhlyiY3cbTazXFWSrVa3Kqf3ndSQhlzq5pOusZF4OdZM0SnaHoVvEPu6AjcLrfpHIy
         mGQJGNslCvkaNSd73eZG9+YVTv3Aq4zwostpkQ/0piPui6SzLbKh+LzrAUCxbRmjhZy8
         TKV1evTG2yZkO0Tp3fnmnfnAje+qYzgoIHCPV61Ci2TbCAS01B5yZ9xHHBcEfB24rzaR
         93iAE8ZKK1Po4tpXx2zod8nG0IS2bJMFnuXtiTbPJSqWlZuho/hcj6cffo9fLxzqFnby
         AiIMwP+G2mJ2cQfiHvYjiVfX41iZijfOY0FFBp8y1+1dpzD+hyXCORGVWT6b0vu2xPS8
         TpDQ==
Received: by 10.68.222.133 with SMTP id qm5mr5956862pbc.113.1339056846408;
        Thu, 07 Jun 2012 01:14:06 -0700 (PDT)
Received: from [10.0.0.4] ([115.118.107.144])
        by mx.google.com with ESMTPS id qp3sm3326439pbc.17.2012.06.07.01.14.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 01:14:05 -0700 (PDT)
Subject: [PATCH 1/2] Octeon 6xxx: Initial commit porting executive files
 from sdk2.3
From:   philby john <pjohn@mvista.com>
To:     linux-mips@linux-mips.org
Cc:     david.daney@caviumnetworks.com, ralf@linux-mips.org,
        prasun.kapoor@caviumnetworks.com
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 07 Jun 2012 13:45:40 +0530
Message-ID: <1339056940.15045.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-1.fc14)
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkBnZ/oBUPv/RP9KnZipWibgSC7Kyo4xaZ0iPQnbbX3Oiplt639QUskE35NMvQy2IudoCRo
X-archive-position: 33595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

>From eb9d86c9ac6d23f36f01e6b8b364c3922e550fff Mon Sep 17 00:00:00 2001
From: Philby John <pjohn@mvista.com>
Date: Thu, 7 Jun 2012 11:49:32 +0530
Subject: [PATCH] Octeon 6xxx: Initial commit porting executive files from sdk2.3

Initial commit that sets up the internal functions
needed for implementing Power Throttling for Octeon
6xxx and above.

Additional functionality such as setting throttle feedback
cvmx_init_throttle_feedback(), calculating throttle percentage
cvmx_power_throttle_get_powlim(), and other bugfixes not present
in the SDK have been implemented.

Signed-off-by: Philby John <pjohn@mvista.com>
---
 arch/mips/cavium-octeon/executive/Makefile         |    2 +-
 .../cavium-octeon/executive/cvmx-power-throttle.c  |  287 ++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-power-throttle.h |  103 +++++++
 3 files changed, 391 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-power-throttle.c
 create mode 100644 arch/mips/include/asm/octeon/cvmx-power-throttle.h

diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
index b6d6e84..659cd9e 100644
--- a/arch/mips/cavium-octeon/executive/Makefile
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -14,6 +14,6 @@ obj-y += cvmx-pko.o cvmx-spi.o cvmx-cmd-queue.o \
 	cvmx-helper-board.o cvmx-helper.o cvmx-helper-xaui.o \
 	cvmx-helper-rgmii.o cvmx-helper-sgmii.o cvmx-helper-npi.o \
 	cvmx-helper-loop.o cvmx-helper-spi.o cvmx-helper-util.o \
-	cvmx-interrupt-decodes.o cvmx-interrupt-rsl.o
+	cvmx-interrupt-decodes.o cvmx-interrupt-rsl.o cvmx-power-throttle.o
 
 obj-y += cvmx-helper-errata.o cvmx-helper-jtag.o
diff --git a/arch/mips/cavium-octeon/executive/cvmx-power-throttle.c b/arch/mips/cavium-octeon/executive/cvmx-power-throttle.c
new file mode 100644
index 0000000..daa7f5a
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-power-throttle.c
@@ -0,0 +1,287 @@
+/***********************license start***************
+ * Copyright (c) 2003-2010  Cavium Inc. (support@cavium.com). All rights
+ * reserved.
+ *
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *
+ *   * Redistributions in binary form must reproduce the above
+ *     copyright notice, this list of conditions and the following
+ *     disclaimer in the documentation and/or other materials provided
+ *     with the distribution.
+
+ *   * Neither the name of Cavium Inc. nor the names of
+ *     its contributors may be used to endorse or promote products
+ *     derived from this software without specific prior written
+ *     permission.
+
+ * This Software, including technical data, may be subject to U.S. export
+ * control laws, including the U.S. Export Administration Act and its
+ * associated regulations, and may be subject to export or import  regulations
+ * in other countries.
+
+ * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
+ * AND WITH ALL FAULTS AND CAVIUM INC. MAKES NO PROMISES, REPRESENTATIONS OR
+ * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
+ * TO THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY
+ * REPRESENTATION OR DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT
+ * DEFECTS, AND CAVIUM SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY)
+ * WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
+ * PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS, QUIET
+ * ENJOYMENT QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION. THE ENTIRE
+ * RISK ARISING OUT OF USE OR PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
+ ***********************license end**************************************/
+
+/**
+ * @file
+ *
+ * Interface to power-throttle control, measurement, and debugging
+ * facilities.
+ *
+ */
+
+#include <asm/octeon/cvmx.h>
+#include <asm/octeon/cvmx-asm.h>
+#include <asm/octeon/cvmx-power-throttle.h>
+#include <asm/octeon/octeon.h>
+
+#define CVMX_PTH_GET_MASK(len, pos)	\
+	((((uint64_t)1 << (len)) - 1) << (pos))
+
+#define CVMX_PTH_AVAILABLE		\
+	(cvmx_power_throttle_get_register(0) != (uint64_t)-1)
+
+/*
+ * a field of the POWTHROTTLE register
+ */
+static struct cvmx_power_throttle_rfield_t {
+	char	name[16];	/* the field's name */
+	int32_t	pos;		/* position of the field's LSb */
+	int32_t	len;		/* the field's length */
+	int	present;	/* 1 for present */
+} cvmx_power_throttle_rfield[] = {
+	{"MAXPOW",   56,  8, 0},
+	{"POWER" ,   48,  8, 0},
+	{"THROTT",   40,  8, 0},
+	{"Reserved", 28, 12, 0},
+	{"DISTAG",   27,  1, 0},
+	{"PERIOD",   24,  3, 0},
+	{"POWLIM",   16,  8, 0},
+	{"MAXTHR",    8,  8, 0},
+	{"MINTHR",    0,  8, 0},
+	{"HRMPOWADJ", 32,  8, 0},
+	{"OVRRD",    28,  1, 0}
+};
+
+static uint64_t cvmx_power_throttle_csr_addr(int ppid);
+
+static int cvmx_power_throttle_initialized;
+
+/*
+ * @INTERNAL
+ * Initialize cvmx_power_throttle_rfield[] based on model.
+ */
+static void cvmx_power_throttle_init(void)
+{
+	/* Turn on the fields for a model */
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		int i;
+		struct cvmx_power_throttle_rfield_t *p;
+
+		for (i = 0; i < CVMX_PTH_INDEX_MAX; i++)
+			cvmx_power_throttle_rfield[i].present = 1;
+
+		if (OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+			/*
+			 * These fields do not come with o63
+			 */
+			p =
+			&cvmx_power_throttle_rfield[CVMX_PTH_INDEX_HRMPOWADJ];
+			p->present = 0;
+			p = &cvmx_power_throttle_rfield[CVMX_PTH_INDEX_OVRRD];
+			p->present = 0;
+		} else {
+			/*
+			 * The reserved field shrinks in models newer than o63
+			 */
+			p =
+			&cvmx_power_throttle_rfield[CVMX_PTH_INDEX_RESERVED];
+			p->pos = 29;
+			p->len = 3;
+		}
+	}
+}
+
+uint64_t cvmx_power_throttle_get_field(uint64_t r,
+	enum cvmx_power_throttle_field_index i)
+{
+	uint64_t m;
+	struct cvmx_power_throttle_rfield_t *p;
+
+	if (i > CVMX_PTH_INDEX_MAX)
+		return -EINVAL;
+
+	p = &cvmx_power_throttle_rfield[i];
+	if (!p->present)
+		return (uint64_t) -1;
+	m = CVMX_PTH_GET_MASK(p->len, p->pos);
+
+	return (r & m) >> p->pos;
+}
+
+/*
+ * @INTERNAL
+ * Set the i'th field of power-throttle register r to v.
+ */
+static int cvmx_power_throttle_set_field(int i, uint64_t r, uint64_t v)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		uint64_t m;
+		struct cvmx_power_throttle_rfield_t *p;
+
+		if (i > CVMX_PTH_INDEX_MAX)
+			return -EINVAL;
+
+		p = &cvmx_power_throttle_rfield[i];
+		m = CVMX_PTH_GET_MASK(p->len, p->pos);
+
+		return (~m & r) | ((v << p->pos) & m);
+	}
+	return 0;
+}
+
+int cvmx_init_throttle_feedback(cpu)
+{
+	uint64_t csr_addr, r;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		csr_addr = cvmx_power_throttle_csr_addr(cpu);
+		r = cvmx_read_csr(csr_addr);
+		r =
+		cvmx_power_throttle_set_field(CVMX_PTH_INDEX_MINTHR, r, 0x0);
+		cvmx_write_csr(csr_addr, r);
+		r = cvmx_read_csr(csr_addr);
+		r =
+		cvmx_power_throttle_set_field(CVMX_PTH_INDEX_MAXTHR, r, 0xFF);
+		cvmx_write_csr(csr_addr, r);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+/**
+ * @INTERNAL
+ * Get the POWLIM field as percentage% of the MAXPOW field in r.
+ */
+int cvmx_power_throttle_get_powlim(int cpu)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		uint64_t t, csr_addr, r, s;
+
+		csr_addr = cvmx_power_throttle_csr_addr(cpu);
+		r = cvmx_read_csr(csr_addr);
+
+		t = cvmx_power_throttle_get_field(r, CVMX_PTH_INDEX_MAXPOW);
+		if (!OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+			s = cvmx_power_throttle_get_field(r,
+				CVMX_PTH_INDEX_HRMPOWADJ);
+			if (t < s)
+				return -EINVAL;
+			t = t - s;
+		}
+		s = cvmx_power_throttle_get_field(r, CVMX_PTH_INDEX_POWLIM);
+		return (s * 100)/t;
+	}
+	return 0;
+}
+
+/**
+ * @INTERNAL
+ * Set the POWLIM field as percentage% of the MAXPOW field in r.
+ */
+static uint64_t cvmx_power_throttle_set_powlim(int ppid,
+	uint8_t percentage)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		uint64_t t, csr_addr, r;
+
+		if (percentage > 101)
+			return -EINVAL;
+		csr_addr = cvmx_power_throttle_csr_addr(ppid);
+		r = cvmx_read_csr(csr_addr);
+		t = cvmx_power_throttle_get_field(r, CVMX_PTH_INDEX_MAXPOW);
+		if (!OCTEON_IS_MODEL(OCTEON_CN63XX)) {
+			uint64_t s;
+			s = cvmx_power_throttle_get_field(r,
+				CVMX_PTH_INDEX_HRMPOWADJ);
+			if (t < s)
+				return -EINVAL;
+			t = t - s;
+		}
+		if (percentage > 0)
+			t = percentage * t / 100;
+		else
+			t = 0;
+		r = cvmx_power_throttle_set_field(CVMX_PTH_INDEX_POWLIM, r, t);
+		cvmx_write_csr(csr_addr, r);
+		return r;
+	}
+	return 0;
+}
+
+/*
+ * @INTERNAL
+ * Given ppid, calculate its PowThrottle register's L2C_COP0_MAP CSR
+ * address. (ppid == PTH_PPID_BCAST is for broadcasting)
+ */
+static uint64_t cvmx_power_throttle_csr_addr(int ppid)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+		uint64_t csr_addr, reg_num, reg_reg, reg_sel;
+
+		if (ppid > CVMX_MAX_CORES)
+			return -EINVAL;
+		/*
+		 * register 11 selection 6
+		 */
+		reg_reg = 11;
+		reg_sel = 6;
+		reg_num = (ppid << 8) + (reg_reg << 3) + reg_sel;
+		csr_addr = CVMX_L2C_COP0_MAPX(0) + ((reg_num) << 3);
+		return csr_addr;
+	}
+	return 0;
+}
+
+int cvmx_power_throttle(uint8_t percentage, uint64_t cpu)
+{
+	int ret = 0;
+
+	if (!CVMX_PTH_AVAILABLE)
+		return -EINVAL;
+
+	if (cvmx_power_throttle_set_powlim(cpu, percentage) == 0)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+uint64_t cvmx_power_throttle_get_register(int ppid)
+{
+	uint64_t csr_addr;
+
+	if (!cvmx_power_throttle_initialized) {
+		cvmx_power_throttle_init();
+		cvmx_power_throttle_initialized = 1;
+	}
+	csr_addr = cvmx_power_throttle_csr_addr(ppid);
+	if (csr_addr == 0)
+		return -EINVAL;
+
+	return cvmx_read_csr(csr_addr);
+}
diff --git a/arch/mips/include/asm/octeon/cvmx-power-throttle.h b/arch/mips/include/asm/octeon/cvmx-power-throttle.h
new file mode 100644
index 0000000..f0e6bb8
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-power-throttle.h
@@ -0,0 +1,103 @@
+/***********************license start***************
+ * Copyright (c) 2003-2010  Cavium Inc. (support@cavium.com). All rights
+ * reserved.
+ *
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *
+ *   * Redistributions in binary form must reproduce the above
+ *     copyright notice, this list of conditions and the following
+ *     disclaimer in the documentation and/or other materials provided
+ *     with the distribution.
+
+ *   * Neither the name of Cavium Inc. nor the names of
+ *     its contributors may be used to endorse or promote products
+ *     derived from this software without specific prior written
+ *     permission.
+
+ * This Software, including technical data, may be subject to U.S. export
+ * control laws, including the U.S. Export Administration Act and its
+ * associated regulations, and may be subject to export or import  regulations
+ * in other countries.
+
+ * TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
+ * AND WITH ALL FAULTS AND CAVIUM INC. MAKES NO PROMISES, REPRESENTATIONS OR
+ * WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
+ * TO THE SOFTWARE, INCLUDING ITS CONDITION, ITS CONFORMITY TO ANY
+ * REPRESENTATION OR DESCRIPTION, OR THE EXISTENCE OF ANY LATENT OR PATENT
+ * DEFECTS, AND CAVIUM SPECIFICALLY DISCLAIMS ALL IMPLIED (IF ANY)
+ * WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
+ * PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS, QUIET
+ * ENJOYMENT QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION. THE ENTIRE
+ * RISK ARISING OUT OF USE OR PERFORMANCE OF THE SOFTWARE LIES WITH YOU.
+ ***********************license end**************************************/
+
+/*
+ * @file
+ *
+ * Interface to power-throttle control, measurement, and debugging
+ * facilities.
+ *
+ */
+
+#ifndef __CVMX_POWER_THROTTLE_H__
+#define __CVMX_POWER_THROTTLE_H__
+
+enum cvmx_power_throttle_field_index {
+	CVMX_PTH_INDEX_MAXPOW,
+	CVMX_PTH_INDEX_POWER,
+	CVMX_PTH_INDEX_THROTT,
+	CVMX_PTH_INDEX_RESERVED,
+	CVMX_PTH_INDEX_DISTAG,
+	CVMX_PTH_INDEX_PERIOD,
+	CVMX_PTH_INDEX_POWLIM,
+	CVMX_PTH_INDEX_MAXTHR,
+	CVMX_PTH_INDEX_MINTHR,
+	CVMX_PTH_INDEX_HRMPOWADJ,
+	CVMX_PTH_INDEX_OVRRD,
+	CVMX_PTH_INDEX_MAX
+};
+
+extern int cvmx_power_throttle_get_powlim(int cpu);
+
+/*
+ * For maximum POWLIM feedback control freedom, set MINTHR = 0 and MAXTHR = 0xFF
+ */
+extern int cvmx_init_throttle_feedback(int cpu);
+
+/**
+ * Throttle power to percentage% of configured maximum (MAXPOW)
+ * for the cores identified in coremask.
+ *
+ * @param percentage	0 to 100
+ * @param coremask	bit mask where each bit identifies a core.
+ * @return 0 for success and -1 for error.
+ */
+extern int cvmx_power_throttle(uint8_t percentage, uint64_t coremask);
+
+/**
+ * Get the i'th field of the power throttle register
+ *
+ * @param r is the value of the power throttle register
+ * @param i is the index of the field
+ *
+ * @return (uint64_t)-1 on failure.
+ */
+extern uint64_t cvmx_power_throttle_get_field(uint64_t r,
+	enum cvmx_power_throttle_field_index i);
+
+/**
+ * Retrieve the content of the power throttle register of a core
+ *
+ * @param ppid is the core id
+ *
+ * @return (uint64_t)-1 on failure.
+ */
+extern uint64_t cvmx_power_throttle_get_register(int ppid);
+
+#endif /* __CVMX_POWER_THROTTLE_H__ */
-- 
1.6.3.3.338.ge89ce
