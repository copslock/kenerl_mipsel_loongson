Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 12:02:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38253 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992043AbcIBKAbOsxHz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 12:00:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3041111CE9AC;
        Fri,  2 Sep 2016 11:00:13 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Sep 2016 11:00:15 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <lisa.parratt@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 6/6] MIPS: Deprecate VPE Loader
Date:   Fri, 2 Sep 2016 10:59:55 +0100
Message-ID: <1472810395-21381-7-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472810395-21381-1-git-send-email-matt.redfearn@imgtec.com>
References: <1472810395-21381-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54978
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

 arch/mips/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2094cbcea0d4..071fc4585265 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2263,7 +2263,7 @@ comment "MIPS R2-to-R6 emulator is only available for UP kernels"
 	depends on SMP && CPU_MIPSR6
 
 config MIPS_VPE_LOADER
-	bool "VPE loader support."
+	bool "VPE loader support. (DEPRECATED)"
 	depends on SYS_SUPPORTS_MULTITHREADING && MODULES
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
@@ -2272,6 +2272,9 @@ config MIPS_VPE_LOADER
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
