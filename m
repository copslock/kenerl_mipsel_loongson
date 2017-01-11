Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 16:36:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44492 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993900AbdAKPerJVjGf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 16:34:47 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D311B52BD077D;
        Wed, 11 Jan 2017 15:34:37 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 11 Jan 2017 15:34:40 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-remoteproc@vger.kernel.org>,
        <lisa.parratt@imgtec.com>, <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH v5 4/4] MIPS: Deprecate VPE Loader
Date:   Wed, 11 Jan 2017 15:34:12 +0000
Message-ID: <1484148852-29783-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484148852-29783-1-git-send-email-matt.redfearn@imgtec.com>
References: <1484148852-29783-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The MIPS remote processor driver (CONFIG_MIPS_REMOTEPROC) provides a
more standard mechanism for using one or more VPs as coprocessors
running separate firmware.

Here we deprecate this mechanism before it is removed.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/mips/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6faf7c96ee15..d5b5a25a49e8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2298,7 +2298,7 @@ comment "MIPS R2-to-R6 emulator is only available for UP kernels"
 	depends on SMP && CPU_MIPSR6
 
 config MIPS_VPE_LOADER
-	bool "VPE loader support."
+	bool "VPE loader support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MULTITHREADING && MODULES
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
@@ -2307,6 +2307,9 @@ config MIPS_VPE_LOADER
 	  Includes a loader for loading an elf relocatable object
 	  onto another VPE and running it.
 
+	  Unless you have a specific need, you should use CONFIG_MIPS_REMOTEPROC
+          instead of this.
+
 config MIPS_VPE_LOADER_CMP
 	bool
 	default "y"
-- 
2.7.4
