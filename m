Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2018 16:20:57 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:45310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994654AbeJYOUpXfR1D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Oct 2018 16:20:45 +0200
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8A5214ED;
        Thu, 25 Oct 2018 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477239;
        bh=voPVtmi5Psb82y3VOxnXPsApORsVNEZ5aBnqcdZ3Pik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiktR36WAavXbvaIBPB5boOk0Mp/Tk2L3BGDSZIcc+HibHpydFbyzyLRrAKTuRJ72
         la0pGSh+Q2fht7p4JjQrb49VZl74HWJ9JVEdrOYQGvhz9FdsO7cgqLxetlgjMqO8i8
         detWpFRnHGb3Nw6m/KafQXC22XY8IHE5yo7JxuxU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 69/98] MIPS: Fix up obsolete cpu_set usage
Date:   Thu, 25 Oct 2018 10:18:24 -0400
Message-Id: <20181025141853.214051-69-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66947
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

From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

[ Upstream commit 7363cb7de3999e84243bca79ffea257fd86a2cc6 ]

cpu_set was removed (along with a bunch of cpumask helpers) by
commit 2f0f267ea072 ("cpumask: remove deprecated functions.").

Fix this by replacing cpu_set with cpumask_set_cpu. Without this
fix the following error is triggered when CONFIG_MIPS_MT_FPAFF=y.

  arch/mips/kernel/smp-cps.c: In function 'cps_smp_setup':
  arch/mips/kernel/smp-cps.c:95:3: error: implicit declaration of function 'cpu_set' [-Werror=implicit-function-declaration]

Fixes: 90db024f140d ("MIPS: smp-cps: cpu_set FPU mask if FPU present")
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Acked-by: Niklas Cassel <niklass@axis.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9912/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/smp-cps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 0854f17829f3..5680ff0eb599 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -92,7 +92,7 @@ static void __init cps_smp_setup(void)
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
-		cpu_set(0, mt_fpu_cpumask);
+		cpumask_set_cpu(0, &mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 }
 
-- 
2.17.1
