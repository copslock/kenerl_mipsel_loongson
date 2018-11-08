Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 22:57:30 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:39600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993030AbeKHV5Sbr4yj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Nov 2018 22:57:18 +0100
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA5F220892;
        Thu,  8 Nov 2018 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714236;
        bh=qmzza5Wuq3KTp/kzgYC9I56VBGY8sAAxZT1/hRtFKgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qszJgXAc7Nw+N1oZl5tGR2t9k1FdeWPkcYHXlyWHyvxMzgNDGjVPOzLGLe9nLfVUF
         efVIjDz3Zk1hgBoj8FBD0R45XichF4c+po7ugxPtnCturNqOUr+RwqhjpmfaluCW/M
         W/c02hjChtOmi1aU1VHLh/xD5p4N5mn/n634EwJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Niklas Cassel <niklass@axis.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 098/144] MIPS: Fix up obsolete cpu_set usage
Date:   Thu,  8 Nov 2018 13:51:09 -0800
Message-Id: <20181108215104.760339510@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=nC3z=NT=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
