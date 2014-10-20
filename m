Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:57:21 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33560 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011971AbaJTUzNkaQ6V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:13 +0200
Received: by mail-pa0-f46.google.com with SMTP id fa1so5954516pad.33
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nGNfwPKDnEJCCZ+DPCGCw5UrwlosZoF72Y+OEXjkxrM=;
        b=fMPflMjn4In8P1H1iAGyodkdg1v5tUR5d/a9JtBh0fWnih13Paq0BEbVtWMiVbNpcF
         Y51X/eDTD2ufdtAGrDzbemQxntRO1sDAu1EbQpgEGpakdMaCyhl1jPhSYH4uyp36ioqd
         Jk4CA216LJJTa8YuFFKnmsdpUUKT0uTnNGw3AL2+DVXyr0NsLT+f/G8k+6oZG8qdZp9y
         lC0DwltkTptpZiCyrZOrB2+5kDDQUln3fsMGpbG83oS2FiOxpFXZ2MxBy5+8DrV+Odoh
         pXtGGyqLiNkdX11huABmYxeaoMtF4xg1qc+RVaMlr7TyCo+uTtR6jw8guTOIB4Hjic6q
         wsrA==
X-Received: by 10.70.128.40 with SMTP id nl8mr6156916pdb.131.1413838507698;
        Mon, 20 Oct 2014 13:55:07 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.55.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:55:06 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 8/9] tty: serial: of-serial: Allow OF earlycon to default to "on"
Date:   Mon, 20 Oct 2014 13:54:07 -0700
Message-Id: <1413838448-29464-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On many development systems it is very common to see failures during the
early stages of the boot process, e.g. SMP boot or PCIe initialization.
This is one likely reason why some existing earlyprintk implementations,
such as arch/mips/kernel/early_printk.c, are enabled unconditionally
at compile time.

Now that earlycon's operating parameters can be passed into the kernel
via DT, it is helpful to be able to configure the kernel to turn it on
automatically.  Introduce a new CONFIG_SERIAL_EARLYCON_FORCE option for
this purpose.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c           |  5 +++++
 drivers/tty/serial/Kconfig | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 20193cc..3e2ea1e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1013,6 +1013,11 @@ bool __init early_init_dt_verify(void *params)
 
 void __init early_init_dt_scan_nodes(void)
 {
+#ifdef CONFIG_SERIAL_EARLYCON_FORCE
+	if (early_init_dt_scan_chosen_serial() < 0)
+		pr_warn("Unable to set up earlycon from stdout-path\n");
+#endif
+
 	/* Retrieve various information from the /chosen node */
 	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
 
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fdd851e..bc4ebcc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -14,6 +14,17 @@ config SERIAL_EARLYCON
 	  the console before standard serial driver is probed. The console is
 	  enabled when early_param is processed.
 
+config SERIAL_EARLYCON_FORCE
+	bool "Always enable early console"
+	depends on SERIAL_EARLYCON
+	help
+	  Traditionally, enabling the early console has required passing in
+	  the "earlycon" parameter on the kernel command line.  On systems
+	  under development it may be desirable to enable earlycon
+	  unconditionally rather than to force the user to manually add it
+	  to the boot argument string, as boot failures often occur before
+	  the standard serial driver is probed.
+
 source "drivers/tty/serial/8250/Kconfig"
 
 comment "Non-8250 serial port support"
-- 
2.1.1
