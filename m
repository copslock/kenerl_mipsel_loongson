Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2012 00:09:44 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:48202 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903748Ab2CWXJ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2012 00:09:27 +0100
Received: by ghbf11 with SMTP id f11so3639522ghb.36
        for <multiple recipients>; Fri, 23 Mar 2012 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Gz7V3egu57DYS3+tkjFGqvc7hcgiciWtQbwSmJzSL2Y=;
        b=KQI79gd1gxbYq44/pBYy48XFyb8vfGapYXg1+LfZtHna8v1UdILCqvtDZAwuxLcAYY
         tNeizTvm3uavaelxGKc3djOGM4U6UnPSNeALW1S/2YTeWsnwekiDl83BoBwtxWOWgsIJ
         gVRG5TAUyoZTcjxBF02VzKjM/+Y3rSopMLhp0ShsIwqS8kuQ1uC6UC5+KgdHoLq1haKU
         gtu25ir5e+pIe1BP+sU/lN+Q51yt1iIzBGuVe8eubriGLoNj0pkmzxOmCdjLcZ4WoCxf
         p/X6ksgvaFpxFxcLYClG3njcbg8pshhniQ6M1ZNSAke+BlCm5mFHlhtjQun9rjgg5Wyc
         A2Cw==
Received: by 10.60.29.10 with SMTP id f10mr16553565oeh.32.1332544160878;
        Fri, 23 Mar 2012 16:09:20 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id v10sm9081848obb.4.2012.03.23.16.09.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 16:09:20 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q2NN9Ikh020411;
        Fri, 23 Mar 2012 16:09:18 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q2NN9G0B020410;
        Fri, 23 Mar 2012 16:09:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v7] of/lib: Allow scripts/dtc/libfdt to be used from kernel code
Date:   Fri, 23 Mar 2012 16:09:15 -0700
Message-Id: <1332544155-20380-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

libfdt is part of the device tree support in scripts/dtc/libfdt.  For
some platforms that use the Device Tree, we want to be able to edit
the flattened device tree form.

We don't want to burden kernel builds that do not require it, so we
gate compilation of libfdt files with CONFIG_LIBFDT.  So if it is
needed, you need to do this in your Kconfig:

	select LIBFDT

And in the Makefile of the code using libfdt something like:

ccflags-y := -I$(src)/../../../scripts/dtc/libfdt

Signed-off-by: David Daney <david.daney@cavium.com>
---

This patch has been seen several times before as part of a larger
patch set for my OCTEON Device Tree work.  After further refinement to
my patches that depend on core Device Tree functionality, this is the
only remaining patch to the common 'core' code.

Here is the history:

v7: No changes other that to split from other, now unneeded, patches.

v6: No changes other than to split these out of the MIPS/OCTEON patch
    set to allow them to be merged separately if desired.

v5: Build libfdt in the lib directory instead of devices/of, and
    include all libfdt files.

    Changes to of_find_node_by_path() requested by Grant Likely.

v4: No changes to these two patches.

v3: libfdt building moved to devices/of/libfdt.  Cleanup and style
    improvements as suggested by Grant Likely.

v2: No changes to these two patches.

There are a couple of possibility for merging this.

1) Via the Device Tree maintainers, thus blocking the follow-ons until
   it is merged.

2) Via Ralf's Linux/MIPS tree with the rest of the patches after
   Device Tree maintainer sign-off.

 include/linux/libfdt.h     |    8 ++++++++
 include/linux/libfdt_env.h |   13 +++++++++++++
 lib/Kconfig                |    6 ++++++
 lib/Makefile               |    5 +++++
 lib/fdt.c                  |    2 ++
 lib/fdt_ro.c               |    2 ++
 lib/fdt_rw.c               |    2 ++
 lib/fdt_strerror.c         |    2 ++
 lib/fdt_sw.c               |    2 ++
 lib/fdt_wip.c              |    2 ++
 10 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/libfdt.h
 create mode 100644 include/linux/libfdt_env.h
 create mode 100644 lib/fdt.c
 create mode 100644 lib/fdt_ro.c
 create mode 100644 lib/fdt_rw.c
 create mode 100644 lib/fdt_strerror.c
 create mode 100644 lib/fdt_sw.c
 create mode 100644 lib/fdt_wip.c

diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
new file mode 100644
index 0000000..4c0306c
--- /dev/null
+++ b/include/linux/libfdt.h
@@ -0,0 +1,8 @@
+#ifndef _INCLUDE_LIBFDT_H_
+#define _INCLUDE_LIBFDT_H_
+
+#include <linux/libfdt_env.h>
+#include "../../scripts/dtc/libfdt/fdt.h"
+#include "../../scripts/dtc/libfdt/libfdt.h"
+
+#endif /* _INCLUDE_LIBFDT_H_ */
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
new file mode 100644
index 0000000..01508c7
--- /dev/null
+++ b/include/linux/libfdt_env.h
@@ -0,0 +1,13 @@
+#ifndef _LIBFDT_ENV_H
+#define _LIBFDT_ENV_H
+
+#include <linux/string.h>
+
+#include <asm/byteorder.h>
+
+#define fdt32_to_cpu(x) be32_to_cpu(x)
+#define cpu_to_fdt32(x) cpu_to_be32(x)
+#define fdt64_to_cpu(x) be64_to_cpu(x)
+#define cpu_to_fdt64(x) cpu_to_be64(x)
+
+#endif /* _LIBFDT_ENV_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 028aba9..e2da829 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -316,4 +316,10 @@ config SIGNATURE
 	  Digital signature verification. Currently only RSA is supported.
 	  Implementation is done using GnuPG MPI library
 
+#
+# libfdt files, only selected if needed.
+#
+config LIBFDT
+	bool
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index 18515f0..1c6c198 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -123,6 +123,11 @@ obj-$(CONFIG_SIGNATURE) += digsig.o
 
 obj-$(CONFIG_CLZ_TAB) += clz_tab.o
 
+libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o
+$(foreach file, $(libfdt_files), \
+	$(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt))
+lib-$(CONFIG_LIBFDT) += $(libfdt_files)
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
diff --git a/lib/fdt.c b/lib/fdt.c
new file mode 100644
index 0000000..97f2006
--- /dev/null
+++ b/lib/fdt.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt.c"
diff --git a/lib/fdt_ro.c b/lib/fdt_ro.c
new file mode 100644
index 0000000..f73c04e
--- /dev/null
+++ b/lib/fdt_ro.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt_ro.c"
diff --git a/lib/fdt_rw.c b/lib/fdt_rw.c
new file mode 100644
index 0000000..0c1f0f4
--- /dev/null
+++ b/lib/fdt_rw.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt_rw.c"
diff --git a/lib/fdt_strerror.c b/lib/fdt_strerror.c
new file mode 100644
index 0000000..8713e3f
--- /dev/null
+++ b/lib/fdt_strerror.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt_strerror.c"
diff --git a/lib/fdt_sw.c b/lib/fdt_sw.c
new file mode 100644
index 0000000..9ac7e50
--- /dev/null
+++ b/lib/fdt_sw.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt_sw.c"
diff --git a/lib/fdt_wip.c b/lib/fdt_wip.c
new file mode 100644
index 0000000..45b3fc3
--- /dev/null
+++ b/lib/fdt_wip.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt_wip.c"
-- 
1.7.2.3
