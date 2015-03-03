Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 02:54:59 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:34669 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007628AbbCCBy5gprfF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Mar 2015 02:54:57 +0100
X-QQ-mid: bizesmtp2t1425347358t408t228
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 03 Mar 2015 09:49:13 +0800 (CST)
X-QQ-SSF: 01100000002000F0FI52000A0000000
X-QQ-FEAT: /peYvah/M2WpibvpFV3eOfXoTuOfpuumERNDZlXUaHXQpYAJdNbTH+OAf2KVm
        BMQrbwmNQ69G81CRXkocivf+S6mFSrp0bdB2jp8kLk4Vu7+frmHR+yLBUMfFIIIbixk99cs
        6pXl/RWqmh7dWriZGpWcHmud106ESf78s61n3cC+wq5EQsxVGdJr08ChAE4mQACbNonDESy
        NtT7Th/wk84D/CJYd45LNEAAMeLuBvp4=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Call mips_set_personality_fp() in all O32 cases
Date:   Tue,  3 Mar 2015 09:49:08 +0800
Message-Id: <1425347348-12334-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Commit 46490b572544f (MIPS: kernel: elf: Improve the overall ABI and
FPU mode checks) assumes mips_set_personality_fp() is only needed in
CONFIG_MIPS_O32_FP64_SUPPORT case. However, this assumption is wrong,
because O32 binaries always need the correct thread flags to set
FR/FRE, whether CONFIG_MIPS_O32_FP64_SUPPORT is configured or not.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/elf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index d2c09f6..cec5bc3 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -245,7 +245,7 @@ void mips_set_personality_fp(struct arch_elf_state *state)
 	 * not be worried about N32/N64 binaries.
 	 */
 
-	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
+	if (!config_enabled(CONFIG_32BIT) && !config_enabled(CONFIG_MIPS32_O32))
 		return;
 
 	switch (state->overall_fp_mode) {
-- 
1.7.7.3
