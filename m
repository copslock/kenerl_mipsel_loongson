Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2018 14:56:39 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992953AbeKDNyqLszSg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Nov 2018 14:54:46 +0100
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42883204FD;
        Sun,  4 Nov 2018 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339685;
        bh=Zlm4PKuz8OFnwugoDcg0ZME2aoIIqhan+w9p5e+jLqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghJaBaSPryWzcJ2YF3RZKoDgD8WUUnmmi8Iq7zpiwpBLOzM3JEx/XgYdN8ISq1ag9
         i8Gg20XF4w/l/LC3qtL5tdl/6BmOHvCkQ6BK+dNWFCBYFQnZkvZOXzqszacQ5zquc+
         OGtawpToeVNQZe1JGwhyE5EVOHpHd8Vm7k31gEMg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <paul.burton@mips.com>, pburton@wavecomp.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        rachel.mozes@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 10/13] MIPS: kexec: Mark CPU offline before disabling local IRQ
Date:   Sun,  4 Nov 2018 08:54:30 -0500
Message-Id: <20181104135433.88734-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135433.88734-1-sashal@kernel.org>
References: <20181104135433.88734-1-sashal@kernel.org>
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sashal@kernel.org
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

From: Dengcheng Zhu <dzhu@wavecomp.com>

[ Upstream commit dc57aaf95a516f70e2d527d8287a0332c481a226 ]

After changing CPU online status, it will not be sent any IPIs such as in
__flush_cache_all() on software coherency systems. Do this before disabling
local IRQ.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20571/
Cc: pburton@wavecomp.com
Cc: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Cc: rachel.mozes@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/crash.c         | 3 +++
 arch/mips/kernel/machine_kexec.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 26c7786d1407..e7d886b6a032 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -34,6 +34,9 @@ static void crash_shutdown_secondary(void *passed_regs)
 	if (!cpu_online(cpu))
 		return;
 
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
 	local_irq_disable();
 	if (!cpu_isset(cpu, cpus_in_crash))
 		crash_save_cpu(regs, cpu);
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 50980bf3983e..92bc066e47a3 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -95,6 +95,9 @@ machine_kexec(struct kimage *image)
 			*ptr = (unsigned long) phys_to_virt(*ptr);
 	}
 
+	/* Mark offline BEFORE disabling local irq. */
+	set_cpu_online(smp_processor_id(), false);
+
 	/*
 	 * we do not want to be bothered.
 	 */
-- 
2.17.1
