Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 17:17:47 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:36863
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992239AbdI0PQWwTell (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 17:16:22 +0200
Received: by mail-pg0-x244.google.com with SMTP id d8so9486980pgt.3;
        Wed, 27 Sep 2017 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=74097xtbYADaNfNF2igGnQAmzb31w133Cnb4Kzpi2N8=;
        b=Q6UoLoUGNY6u5hModH/+WYi39/DsDCA9DMh/M4DTRDaY8DBuXHiFADVnL5w0dTZWNQ
         /+YDPJ93weB1Utq524Xb238QzE8LasxOLDVNxvIZ4kSLQvZnEV1xmTpolkrdksGenPFg
         TvwbxSSDPD178EQxepPNAkTgfnsUOWUQODKuw8/KpT5W/Vq9/4LIP0/+V3ujnv6wqbCt
         9m01/5d0LKiOdcW6kMILZTr8wesyOjoveveLuOjXApgN3PYk9DH31Uz0AtRYLDlSudmh
         JqEsSb6pIutbSLpfeIDX2PdqpfwduDqLHRU7iS0fnFgUKPZQ887YkgyJ/l6h8ylyfgUM
         Pocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=74097xtbYADaNfNF2igGnQAmzb31w133Cnb4Kzpi2N8=;
        b=aU4MEpy/9c0tkuxy5dWcCeLZOnhwr1knczeksVLornSPU9yE+msvqk3LeDec7HJTfs
         u+tF/NbyChsUY23MhTOPxE6jecO0A1P0fqvCkA6CgHVQlWdIlpUO+/oBBfyfoCFfTRFF
         ikuboHOEKX0Hf6Jw8v1srGpDpbgK6sLtZP4LQhmt0HWFsaFP4XUmNxyBmHB3sgA0Budk
         Pbji4DmxPRX/lWSd2iKAye2WbZTtQIXRc9WtKH/smTufdQ1x6ayKgwnjV5PXXM2OvuvL
         JpbIRFD1ZumqYirsh2g1Rbu1vuekUt5nxU3/gM8Sx5QZk3kXCCN5+cd/3X/G8ZpLi3aO
         p5xw==
X-Gm-Message-State: AHPjjUjLwyUKYlD+50qD01aQXXQWz52OC38A2AhDBhV52D/vX5702VAq
        lnIgSMjL1lbXnI/2TeUjCkU=
X-Google-Smtp-Source: AOwi7QCuY8J4KCh6TxVpuRLPuL3WUuKfksg0dgzvZLoZPV6AFuwQ5n0lLzbbJJLNe0bbCUjEqypCBQ==
X-Received: by 10.99.110.141 with SMTP id j135mr1669210pgc.242.1506525376789;
        Wed, 27 Sep 2017 08:16:16 -0700 (PDT)
Received: from linux.local ([42.109.141.25])
        by smtp.gmail.com with ESMTPSA id b65sm21289624pfj.97.2017.09.27.08.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 08:16:16 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, malat@debian.org, dom.peklo@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [RFC 4/4] MIPS: Ingenic: Add Halley2 development board support
Date:   Wed, 27 Sep 2017 20:45:27 +0530
Message-Id: <20170927151527.25570-5-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Halley2 is a development board from Ingenic using X1000 SoC. It comes
with either 32MB or 64MB of RAM. Add support for halley2 development
board.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/boot/dts/ingenic/Makefile    |  1 +
 arch/mips/boot/dts/ingenic/halley2.dts | 46 +++++++++++++++++++++++++
 arch/mips/configs/halley2_defconfig    | 61 ++++++++++++++++++++++++++++++++++
 arch/mips/jz4740/Kconfig               |  4 +++
 4 files changed, 112 insertions(+)
 create mode 100644 arch/mips/boot/dts/ingenic/halley2.dts
 create mode 100644 arch/mips/configs/halley2_defconfig

diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index f2b864f..68e942c 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -1,5 +1,6 @@
 dtb-$(CONFIG_JZ4740_QI_LB60)	+= qi_lb60.dtb
 dtb-$(CONFIG_JZ4780_CI20)	+= ci20.dtb
+dtb-$(CONFIG_X1000_HALLEY2)	+= halley2.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/ingenic/halley2.dts b/arch/mips/boot/dts/ingenic/halley2.dts
new file mode 100644
index 0000000..9b37119
--- /dev/null
+++ b/arch/mips/boot/dts/ingenic/halley2.dts
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2016 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+#include "x1000.dtsi"
+
+/ {
+	compatible = "ingenic,halley2", "ingenic,x1000";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x2000000>;
+	};
+};
+
+&ext {
+	clock-frequency = <24000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
diff --git a/arch/mips/configs/halley2_defconfig b/arch/mips/configs/halley2_defconfig
new file mode 100644
index 0000000..2c49fb7
--- /dev/null
+++ b/arch/mips/configs/halley2_defconfig
@@ -0,0 +1,61 @@
+CONFIG_MACH_INGENIC=y
+CONFIG_X1000_HALLEY2=y
+CONFIG_MACH_X1000=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=3
+CONFIG_SERIAL_8250_RUNTIME_UARTS=3
+CONFIG_SERIAL_8250_INGENIC=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_EARLY_PRINTK is not set
+CONFIG_MEMORY=y
+
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PANIC_TIMEOUT=10
+CONFIG_STACKTRACE=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="earlycon console=ttyS2,115200n8 clk_ignore_unused"
+
+CONFIG_HZ_100=y
+CONFIG_HIGHMEM=y
+CONFIG_PREEMPT=y
+CONFIG_KERNEL_XZ=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_FHANDLE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_MEMCG=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+CONFIG_SLAB=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_LEGACY_PTY_COUNT=2
+
+# CONFIG_SUSPEND is not set
+# CONFIG_HIBERNATION is not set
+# CONFIG_PM is not set
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 338bc3f..7c66a4b 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -11,6 +11,10 @@ config JZ4780_CI20
 	bool "MIPS Creator CI20"
 	select MACH_JZ4780
 
+config X1000_HALLEY2
+	bool "Ingenic X1000 Halley2 Development board"
+	select MACH_X1000
+
 endchoice
 
 config MACH_JZ4740
-- 
2.10.0
