Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2013 23:23:47 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:51681 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827435Ab3JDVXlK1piw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Oct 2013 23:23:41 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VSCqS-0000uc-Vk; Fri, 04 Oct 2013 16:23:32 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Clean up MIPS MT and CMP configuration options.
Date:   Fri,  4 Oct 2013 16:23:28 -0500
Message-Id: <1380921808-22344-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

This patch accomplishes the following:

  * Clean up wording on all MIPS MT configuration menu items.
  * Simplify and neaten up options selected by MIPS_MT_SMP.
  * Make MIPS_MT_SMTC support as deprecated.
  * Make MIPS_CMP support to depend on MIPS_MT_SMP also.
  * Remove redundant options selected by MIPS_CMP.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/Kconfig                     |   61 +++++++++++++--------------------
 arch/mips/configs/maltasmvp_defconfig |    3 +-
 2 files changed, 24 insertions(+), 40 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 17cc7ff..6905d9c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1830,59 +1830,48 @@ choice
 	prompt "MIPS MT options"
 
 config MIPS_MT_DISABLED
-	bool "Disable multithreading support."
+	bool "Disable multithreading support"
 	help
-	  Use this option if your workload can't take advantage of
-	  MIPS hardware multithreading support.  On systems that don't have
-	  the option of an MT-enabled processor this option will be the only
-	  option in this menu.
+	  Use this option if your platform does not support the MT ASE
+	  which is hardware multithreading support. On systems without
+	  an MT-enabled processor, this will be the only option that is
+	  available in this menu.
 
 config MIPS_MT_SMP
 	bool "Use 1 TC on each available VPE for SMP"
 	depends on SYS_SUPPORTS_MULTITHREADING
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
+	select SYNC_R4K
 	select MIPS_MT
 	select SMP
-	select SYS_SUPPORTS_SCHED_SMT if SMP
-	select SYS_SUPPORTS_SMP
 	select SMP_UP
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_SCHED_SMT
 	select MIPS_PERF_SHARED_TC_COUNTERS
 	help
-	  This is a kernel model which is known a VSMP but lately has been
-	  marketesed into SMVP.
-	  Virtual SMP uses the processor's VPEs  to implement virtual
-	  processors. In currently available configuration of the 34K processor
-	  this allows for a dual processor. Both processors will share the same
-	  primary caches; each will obtain the half of the TLB for it's own
-	  exclusive use. For a layman this model can be described as similar to
-	  what Intel calls Hyperthreading.
-
-	  For further information see http://www.linux-mips.org/wiki/34K#VSMP
+	  This is a kernel model which is known as SMVP. This is supported
+	  on cores with the MT ASE and uses the available VPEs to implement
+	  virtual processors which supports SMP. This is equivalent to the
+	  Intel Hyperthreading feature. For further information go to
+	  <http://www.imgtec.com/mips/mips-multithreading.asp>.
 
 config MIPS_MT_SMTC
-	bool "SMTC: Use all TCs on all VPEs for SMP"
+	bool "Use all TCs on all VPEs for SMP (DEPRECATED)"
 	depends on CPU_MIPS32_R2
-	#depends on CPU_MIPS64_R2		# once there is hardware ...
 	depends on SYS_SUPPORTS_MULTITHREADING
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select MIPS_MT
-	select NR_CPUS_DEFAULT_8
 	select SMP
-	select SYS_SUPPORTS_SMP
 	select SMP_UP
+	select SYS_SUPPORTS_SMP
+	select NR_CPUS_DEFAULT_8
 	help
-	  This is a kernel model which is known a SMTC or lately has been
-	  marketesed into SMVP.
-	  is presenting the available TC's of the core as processors to Linux.
-	  On currently available 34K processors this means a Linux system will
-	  see up to 5 processors. The implementation of the SMTC kernel differs
-	  significantly from VSMP and cannot efficiently coexist in the same
-	  kernel binary so the choice between VSMP and SMTC is a compile time
-	  decision.
-
-	  For further information see http://www.linux-mips.org/wiki/34K#SMTC
+	  This is a kernel model which is known as SMTC. This is
+	  supported on cores with the MT ASE and presents all TCs
+	  available on all VPEs to support SMP. For further
+	  information see <http://www.linux-mips.org/wiki/34K#SMTC>.
 
 endchoice
 
@@ -1959,17 +1948,13 @@ config MIPS_VPE_APSP_API
 	help
 
 config MIPS_CMP
-	bool "MIPS CMP framework support"
-	depends on SYS_SUPPORTS_MIPS_CMP
-	select SMP
+	bool "MIPS CMP support"
+	depends on SYS_SUPPORTS_MIPS_CMP && MIPS_MT_SMP
 	select SYNC_R4K
-	select SYS_SUPPORTS_SMP
-	select SYS_SUPPORTS_SCHED_SMT if SMP
 	select WEAK_ORDERING
 	default n
 	help
-	  This is a placeholder option for the GCMP work. It will need to
-	  be handled differently...
+	  Enable Coherency Manager processor (CMP) support.
 
 config SB1_PASS_1_WORKAROUNDS
 	bool
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 8a66602..d759318 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -4,7 +4,7 @@ CONFIG_CPU_MIPS32_R2=y
 CONFIG_MIPS_MT_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_MIPS_CMP=y
-CONFIG_NR_CPUS=8
+CONFIG_NR_CPUS=2
 CONFIG_HZ_100=y
 CONFIG_LOCALVERSION="cmp"
 CONFIG_SYSVIPC=y
@@ -58,7 +58,6 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
-- 
1.7.9.5
