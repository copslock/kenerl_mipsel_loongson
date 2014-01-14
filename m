Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 07:09:01 +0100 (CET)
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35071 "EHLO
        mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825752AbaANGIhSrwLw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jan 2014 07:08:37 +0100
Received: by mail-ob0-f180.google.com with SMTP id wm4so2438909obc.39
        for <multiple recipients>; Mon, 13 Jan 2014 22:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4awxHx13Vd+cH8C9SmCIZvKo3lBk8uC5JIXnHeDfghg=;
        b=f7EAMXAamil1cHePMx8AuL9s8LgUAG7x9oPc4aSW42PBK7geM6LhxRtqZ6ENDlsFnh
         SancrlqPCaHgXofJAMu7SNZ3bpRQytHN6A+PuDBbVXSgpcgN7cB+ZtAYcVqUVFfSxnkr
         OR3gCGNM3MHik92y3h2kzBeOfGlk70PHRTYamkLx4M48YtTmQbUNwEam4l3VD0YmA5up
         847rQ+L11ucwHVkglVHMDvrppeUo5CPjGRbZNX9O14UvRcTqnvShCboZI/XdHhvu8siM
         ss/+ScDdW7E8olEhcu6DBp8aG6G27WAAGh/GoQqo5qfpujiiFrynklDydS2Nrf4YSSug
         GRSg==
X-Received: by 10.60.51.102 with SMTP id j6mr23214995oeo.6.1389679711246;
        Mon, 13 Jan 2014 22:08:31 -0800 (PST)
Received: from localhost.localdomain (ip68-5-18-231.oc.oc.cox.net. [68.5.18.231])
        by mx.google.com with ESMTPSA id nw5sm24074812obc.9.2014.01.13.22.08.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 Jan 2014 22:08:30 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        mbizon@freebox.fr, cernekee@gmail.com, dgcbueu@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v3 1/3] MIPS: introduce MIPS_L1_CACHE_SHIFT_<N>
Date:   Mon, 13 Jan 2014 22:07:30 -0800
Message-Id: <1389679652-14269-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1389679652-14269-1-git-send-email-f.fainelli@gmail.com>
References: <1389679652-14269-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <florian@openwrt.org>

In order to avoid keeping an ever growing list of chips which need to
select a specific MIPS_L1_CACHE_SHIFT value introduce multiple internal
and non-exposed Kconfig symbols for the various MIPS_L1_CACHE_SHIFT
values out there and update the relevant Kconfig symbols to select them.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v2:
- rebased on top of john's mips-next-3.14

Changes since v1:
- do not make MIPS_L1_CACHE_SHIFT_5 the def_bool y

 arch/mips/Kconfig              | 18 ++++++++++++++++++
 arch/mips/pmcs-msp71xx/Kconfig |  1 +
 arch/mips/ralink/Kconfig       |  1 +
 3 files changed, 20 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 17cc7ff..3b7a2be 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -183,6 +183,7 @@ config MACH_DECSTATION
 	select SYS_SUPPORTS_128HZ
 	select SYS_SUPPORTS_256HZ
 	select SYS_SUPPORTS_1024HZ
+	select MIPS_L1_CACHE_SHIFT_4
 	help
 	  This enables support for DEC's MIPS based workstations.  For details
 	  see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the
@@ -468,6 +469,7 @@ config SGI_IP22
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select MIPS_L1_CACHE_SHIFT_7
 	help
 	  This are the SGI Indy, Challenge S and Indigo2, as well as certain
 	  OEM variants like the Tandem CMN B006S. To compile a Linux kernel
@@ -488,6 +490,7 @@ config SGI_IP27
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SMP
+	select MIPS_L1_CACHE_SHIFT_7
 	help
 	  This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
 	  workstations.  To compile a Linux kernel that runs on these, say Y
@@ -694,6 +697,7 @@ config MIKROTIK_RB532
 	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select ARCH_REQUIRE_GPIOLIB
+	select MIPS_L1_CACHE_SHIFT_4
 	help
 	  Support the Mikrotik(tm) RouterBoard 532 series,
 	  based on the IDT RC32434 SoC.
@@ -1088,6 +1092,18 @@ config FW_SNIPROM
 config BOOT_ELF32
 	bool
 
+config MIPS_L1_CACHE_SHIFT_4
+	bool
+
+config MIPS_L1_CACHE_SHIFT_5
+	bool
+
+config MIPS_L1_CACHE_SHIFT_6
+	bool
+
+config MIPS_L1_CACHE_SHIFT_7
+	bool
+
 config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL || SOC_RT288X
@@ -1372,6 +1388,7 @@ config CPU_CAVIUM_OCTEON
 	select LIBFDT
 	select USE_OF
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select MIPS_L1_CACHE_SHIFT_7
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
@@ -1794,6 +1811,7 @@ config IP22_CPU_SCACHE
 config MIPS_CPU_SCACHE
 	bool
 	select BOARD_SCACHE
+	select MIPS_L1_CACHE_SHIFT_6
 
 config R5000_CPU_SCACHE
 	bool
diff --git a/arch/mips/pmcs-msp71xx/Kconfig b/arch/mips/pmcs-msp71xx/Kconfig
index 3482b8c..6073ca4 100644
--- a/arch/mips/pmcs-msp71xx/Kconfig
+++ b/arch/mips/pmcs-msp71xx/Kconfig
@@ -6,6 +6,7 @@ config PMC_MSP4200_EVAL
 	bool "PMC-Sierra MSP4200 Eval Board"
 	select IRQ_MSP_SLP
 	select HW_HAS_PCI
+	select MIPS_L1_CACHE_SHIFT_4
 
 config PMC_MSP4200_GW
 	bool "PMC-Sierra MSP4200 VoIP Gateway"
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 424f034..1bfd1c1 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -15,6 +15,7 @@ choice
 
 	config SOC_RT288X
 		bool "RT288x"
+		select MIPS_L1_CACHE_SHIFT_4
 
 	config SOC_RT305X
 		bool "RT305x"
-- 
1.8.3.2
