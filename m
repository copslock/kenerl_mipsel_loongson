Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2018 18:55:31 +0200 (CEST)
Received: from mail-lj1-x241.google.com ([IPv6:2a00:1450:4864:20::241]:39779
        "EHLO mail-lj1-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993946AbeI0QzYi7ty8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2018 18:55:24 +0200
Received: by mail-lj1-x241.google.com with SMTP id 5-v6so3108869lju.6
        for <linux-mips@linux-mips.org>; Thu, 27 Sep 2018 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=49wXlcerrPjlxaXkpnVoDSpfeMIp1j+DSh7IGOFznrI=;
        b=LsVpGK6fkezRp+u3OE79CuxpP4rF1KkX5mG/wraLBkr9NXFJFgckCj+7JdW5DEFr6m
         OMPrAo1M/5C98BeFpIOY1IP+4RMMswYB2trN3v3N9JfEA0+E4LLooY/hMLgfYbeDbdA8
         bjr9ufc780c4YPgHOatfKYzclQOOhq/qvXK68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=49wXlcerrPjlxaXkpnVoDSpfeMIp1j+DSh7IGOFznrI=;
        b=b37kUpUKufbnPZ//Uj2GMKgWTgupdFcMa0dMQbO0GHexvljfXF6dEQkbZNRe6xupiS
         /Pr88hhYMDYelxvKyCqJbOqqAs5CcOOfuFVun12yx5TO6zr1TSvPdT9FP51LfukS3p9W
         u+uy3F+1pv1o1wfWWscSEkzyP5ZsmTqL5UBnpM/deuthiWIl+v1iuSpCCTVjl2nF2iSO
         S5Otu9XqyECMHJUWLZTlAxz4vTDHD3C6LqG2rYuT9hZkwbUaaMJ3ukwdCl4oJktMawKJ
         c5cpa4MGxTYz24nGApzshUJMYHYeHwKsjhJC/+uoF3+21MBksQoxF4/VqYQUnAor6JJL
         9xfg==
X-Gm-Message-State: ABuFfogQoqoe0xRYT/xX8smLlPYsFq/eO1jaSabAC3/fdQXbhlPg26J8
        JcC74pm6hNjL9Q4F/4eXgfwh6A==
X-Google-Smtp-Source: ACcGV63Z3NxB54KY20OcqOFBWA6VwORhQLePT0oza5GScUXErsmWH8C1z3mjG6MtmuC4bSlTBPL9/g==
X-Received: by 2002:a2e:870b:: with SMTP id m11-v6mr9127380lji.2.1538067318641;
        Thu, 27 Sep 2018 09:55:18 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id n3-v6sm533529lfi.96.2018.09.27.09.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:55:18 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] add generic builtin command line
Date:   Thu, 27 Sep 2018 19:55:09 +0300
Message-Id: <1538067309-5711-2-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
Return-Path: <maksym.kokhan@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksym.kokhan@globallogic.com
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

From: Daniel Walker <danielwa@cisco.com>

This code allows architectures to use a generic builtin command line.
The state of the builtin command line options across architecture is
diverse. On x86 and mips they have pretty much the same code and the
code prepends the builtin command line onto the boot loader provided
one. On powerpc there is only a builtin override and nothing else.

The code in this commit unifies the mips and x86 code into a generic
header file under the CONFIG_GENERIC_CMDLINE option. When this
option is enabled the architecture can call the cmdline_add_builtin()
to add the builtin command line.

[maksym.kokhan@globallogic.com: fix cmdline_add_builtin() macro]
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 include/linux/cmdline.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++
 init/Kconfig            | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 include/linux/cmdline.h

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 0000000..75ef278
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+
+/*
+ *
+ * Copyright (C) 2015. Cisco Systems, Inc.
+ *
+ * Generic Append/Prepend cmdline support.
+ */
+
+#if defined(CONFIG_GENERIC_CMDLINE) && defined(CONFIG_CMDLINE_BOOL)
+
+#ifndef CONFIG_CMDLINE_OVERRIDE
+/*
+ * This function will append or prepend a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dest: The destination of the final appended/prepended string
+ * @src: The starting string or NULL if there isn't one.
+ * @tmp: temporary space used for prepending
+ * @length: the maximum length of the strings above.
+ */
+static inline void
+_cmdline_add_builtin(char *dest, char *src, char *tmp, unsigned long length)
+{
+	if (src != dest && src != NULL) {
+		strlcpy(dest, " ", length);
+		strlcat(dest, src, length);
+	}
+
+	strlcat(dest, " ", length);
+
+	if (sizeof(CONFIG_CMDLINE_APPEND) > 1)
+		strlcat(dest, CONFIG_CMDLINE_APPEND, length);
+
+	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {
+		strlcpy(tmp, CONFIG_CMDLINE_PREPEND, length);
+		strlcat(tmp, " ", length);
+		strlcat(tmp, dest, length);
+		strlcpy(dest, tmp, length);
+	}
+}
+
+#define cmdline_add_builtin(dest, src, length)				    \
+{									    \
+	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {			    \
+		static char cmdline_tmp_space[length] __initdata;	    \
+		_cmdline_add_builtin(dest, src, cmdline_tmp_space, length); \
+	} else {							    \
+		_cmdline_add_builtin(dest, src, NULL, length);		    \
+	}								    \
+}
+#else
+#define cmdline_add_builtin(dest, src, length)				   \
+{									   \
+	strlcpy(dest, CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND,    \
+		length);						   \
+}
+#endif /* !CONFIG_CMDLINE_OVERRIDE */
+
+#else
+#define cmdline_add_builtin(dest, src, length) { \
+	if (src != NULL)						   \
+		strlcpy(dest, src, length);				   \
+}
+#endif /* CONFIG_GENERIC_CMDLINE */
+
+
+#endif /* _LINUX_CMDLINE_H */
diff --git a/init/Kconfig b/init/Kconfig
index 1e234e2..e5aa676 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1751,6 +1751,74 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+config GENERIC_CMDLINE
+	bool
+
+if GENERIC_CMDLINE
+
+config CMDLINE_BOOL
+	bool "Built-in kernel command line"
+	help
+	  Allow for specifying boot arguments to the kernel at
+	  build time.  On some systems (e.g. embedded ones), it is
+	  necessary or convenient to provide some or all of the
+	  kernel boot arguments with the kernel itself (that is,
+	  to not rely on the boot loader to provide them.)
+
+	  To compile command line arguments into the kernel,
+	  set this option to 'Y', then fill in the
+	  the boot arguments in CONFIG_CMDLINE.
+
+	  Systems with fully functional boot loaders (i.e. non-embedded)
+	  should leave this option set to 'N'.
+
+config CMDLINE_APPEND
+	string "Built-in kernel command string append"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, this string is appended to it to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config CMDLINE_PREPEND
+	string "Built-in kernel command string prepend"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, this string is prepended to it to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config CMDLINE_OVERRIDE
+	bool "Built-in command line overrides boot loader arguments"
+	depends on CMDLINE_BOOL
+	help
+	  Set this option to 'Y' to have the kernel ignore the boot loader
+	  command line, and use ONLY the built-in command line. In this case
+	  append and prepend strings are concatenated to form the full
+	  command line.
+
+	  This is used to work around broken boot loaders.  This should
+	  be set to 'N' under normal conditions.
+endif
+
 endmenu		# General setup
 
 source "arch/Kconfig"
-- 
2.7.4
