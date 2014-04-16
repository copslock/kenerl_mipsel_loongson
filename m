Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:09:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:59262 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837164AbaDPNHLMHgVx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:07:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6EF0BCE5B4EAA
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 14:07:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:07:04 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:07:03 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 39/39] MIPS: Malta: CPS SMP by default
Date:   Wed, 16 Apr 2014 14:06:58 +0100
Message-ID: <1397653618-5033-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The CONFIG_MIPS_CPS SMP implementation should be able to handle all
cases the CONFIG_MIPS_CMP implementation does, but without requiring
bootloader assistance. It is also required in order to make use of
features such as hotplug & cpuidle core power gating. Enable it by
default for Malta configs that previously enabled the now deprecated
CONFIG_MIPS_CMP, and disable the latter. The local version suffix "cmp"
is removed rather than replaced with "cps" since there are other ways to
tell that the CPS SMP implementation is in use (the "VPE topology" line
in the boot log being one).

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/configs/maltasmvp_defconfig     | 3 +--
 arch/mips/configs/maltasmvp_eva_defconfig | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index 10ef3be..f8a3231 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -4,10 +4,9 @@ CONFIG_CPU_MIPS32_R2=y
 CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMP=y
 CONFIG_SCHED_SMT=y
-CONFIG_MIPS_CMP=y
+CONFIG_MIPS_CPS=y
 CONFIG_NR_CPUS=8
 CONFIG_HZ_100=y
-CONFIG_LOCALVERSION="cmp"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 2d3002c..c83338a 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -5,10 +5,9 @@ CONFIG_CPU_MIPS32_3_5_FEATURES=y
 CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMP=y
 CONFIG_SCHED_SMT=y
-CONFIG_MIPS_CMP=y
+CONFIG_MIPS_CPS=y
 CONFIG_NR_CPUS=8
 CONFIG_HZ_100=y
-CONFIG_LOCALVERSION="cmp"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
-- 
1.8.5.3
