Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Feb 2012 20:22:36 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:40118 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903790Ab2B2TVa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Feb 2012 20:21:30 +0100
Received: by ggnf2 with SMTP id f2so3583544ggn.36
        for <multiple recipients>; Wed, 29 Feb 2012 11:21:24 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.46.232 as permitted sender) client-ip=10.236.46.232;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.46.232 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.236.46.232])
        by 10.236.46.232 with SMTP id r68mr2497412yhb.80.1330543284394 (num_hops = 1);
        Wed, 29 Feb 2012 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ugqyalD8OBSI61707kFdj2pLUacyCBiyr43X4aKE0jk=;
        b=nYGAii4+wNqw2DKJEr0lTiNE/H/cEix2rfq+avtM8Q6dgusmuSGmgtr7on55coXrzf
         DpKtRg3128IZtBzDcMSDeaRR0weXmwH4jbhIKlbm/sKNJmfQalaF9PP8cb2PIoOXCha7
         pQPNmuDAiU8V/Jp+f6wZjB9aSYoRDOstSYJjg=
Received: by 10.236.46.232 with SMTP id r68mr1981140yhb.80.1330543284343;
        Wed, 29 Feb 2012 11:21:24 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id q55sm58232297yhi.0.2012.02.29.11.21.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 11:21:22 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q1TJLKW2018141;
        Wed, 29 Feb 2012 11:21:20 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q1TJLKGl018140;
        Wed, 29 Feb 2012 11:21:20 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 1/2] of/lib: Allow scripts/dtc/libfdt to be used from kernel code
Date:   Wed, 29 Feb 2012 11:21:03 -0800
Message-Id: <1330543264-18103-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>
References: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32581
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
index 43359bb..5b4444e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -369,4 +369,10 @@ config SIGNATURE
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
