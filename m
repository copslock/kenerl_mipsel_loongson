Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 15:02:03 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:47671 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6871414AbaBTOA0rtrFn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Feb 2014 15:00:26 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 4/5] MIPS: Default NR_CPUS=8 for malta SMP defconfigs
Date:   Thu, 20 Feb 2014 14:00:27 +0000
Message-ID: <1392904828-12969-5-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_20_14_00_24
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39362
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

The previous NR_CPUS=2 default is not an optimal default for current
Malta setups where it is common to have more than 2 CPUs available. It
makes sense to increase this to a number which covers all common setups
currently in use, such that all of those cores are usable. 8 seems to
fit that description.

If the user has less than 8 CPUs & they wish to have a more optimal
kernel they can simply reduce this in their config. It makes sense for
the default to work on as many systems as possible.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/configs/malta_defconfig     | 2 +-
 arch/mips/configs/malta_kvm_defconfig | 2 +-
 arch/mips/configs/maltasmvp_defconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 28323b7..b745b6a 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -3,7 +3,7 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=8
 CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index bc19ebb..4f7d952 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -3,7 +3,7 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=8
 CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 203c563..10ef3be 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -5,7 +5,7 @@ CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_MIPS_CMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=8
 CONFIG_HZ_100=y
 CONFIG_LOCALVERSION="cmp"
 CONFIG_SYSVIPC=y
-- 
1.8.5.5
