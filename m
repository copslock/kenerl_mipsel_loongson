Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2016 15:43:19 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:24493 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992161AbcJKNmttA1gK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2016 15:42:49 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 0F3736D8FF6F3;
        Tue, 11 Oct 2016 14:42:41 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Oct 2016
 14:42:43 +0100
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 11 Oct 2016 14:42:43 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-remoteproc@vger.kernel.org>,
        <lisa.parratt@imgtec.com>, <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH v3 4/4] MIPS: Deprecate VPE Loader
Date:   Tue, 11 Oct 2016 14:42:36 +0100
Message-ID: <1476193356-1350-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1476193356-1350-1-git-send-email-matt.redfearn@imgtec.com>
References: <1476193356-1350-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55383
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

The MIPS remote processor driver (CONFIG_MIPS_RPROC) provides a more
standard mechanism for using one or more VPs as coprocessors running
separate firmware.

Here we deprecate this mechanism before it is removed.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fd2468e71e63..3e767c373c7b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2264,7 +2264,7 @@ comment "MIPS R2-to-R6 emulator is only available for UP kernels"
 	depends on SMP && CPU_MIPSR6
 
 config MIPS_VPE_LOADER
-	bool "VPE loader support."
+	bool "VPE loader support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MULTITHREADING && MODULES
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
@@ -2273,6 +2273,9 @@ config MIPS_VPE_LOADER
 	  Includes a loader for loading an elf relocatable object
 	  onto another VPE and running it.
 
+	  Unless you have a specific need, you should use CONFIG_MIPS_RPROC
+          instead of this.
+
 config MIPS_VPE_LOADER_CMP
 	bool
 	default "y"
-- 
2.7.4
