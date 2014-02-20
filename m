Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 15:01:44 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:47671 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6871412AbaBTOA0dxFjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Feb 2014 15:00:26 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/5] MIPS: Set page size to 16KB for malta SMP defconfigs
Date:   Thu, 20 Feb 2014 14:00:26 +0000
Message-ID: <1392904828-12969-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_20_14_00_23
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

For Malta defconfigs which may run on an SMP configuration without
hardware cache anti-aliasing, a 16KB page size is a safer default.
Most notably at the moment it will avoid cache aliasing issues for
multicore proAptiv systems.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/configs/malta_defconfig     | 1 +
 arch/mips/configs/maltasmtc_defconfig | 1 +
 arch/mips/configs/maltasmvp_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 6bb89a3..28323b7 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -1,6 +1,7 @@
 CONFIG_MIPS_MALTA=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
+CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_HZ_100=y
diff --git a/arch/mips/configs/maltasmtc_defconfig b/arch/mips/configs/maltasmtc_defconfig
index 4e59730..eb31644 100644
--- a/arch/mips/configs/maltasmtc_defconfig
+++ b/arch/mips/configs/maltasmtc_defconfig
@@ -1,6 +1,7 @@
 CONFIG_MIPS_MALTA=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
+CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMTC=y
 # CONFIG_MIPS_MT_FPAFF is not set
 CONFIG_NR_CPUS=9
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index e867c9a..203c563 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -1,6 +1,7 @@
 CONFIG_MIPS_MALTA=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
+CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_MIPS_CMP=y
-- 
1.8.5.5
