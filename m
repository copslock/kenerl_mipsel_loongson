Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 17:07:41 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:48603 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835808Ab3GQS4rJKWof (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jul 2013 20:56:47 +0200
Received: by mail-ee0-f49.google.com with SMTP id b57so1225555eek.8
        for <multiple recipients>; Wed, 17 Jul 2013 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=WJebr6rXe2cWpkT4TEWRmSDqt7VPPcHLErP5p19RWDw=;
        b=LjdTGHZdHCNKkGd8VFiWHGxSzEODW1Tk2W8N81RXgfomNYJ3KnnJ5EADTNQuGfdkVF
         h4zmPthmMVvr5BrE9RsHsOQNRXRVREhpFYASpCQxshQUxR4Uv3rLSpsLwnl1yeKQ7EnN
         m59Yb+wabh1M5kQ8y9mVsIVv3sB9YjFu/QSgXsXdT3Mzl/gH+yYMRGZPMKC2EBy+dFEL
         vmMmnHGsh+yv0xut2XC4Yv3K4pimyWEtvXKz6uf730QfEnYpf5m4t80WXtWp6366KvEJ
         DzsPh5CKleKbbpRtsWuexlJ5Ho+p9SKfbVv6a86K6MQVYgKSjzJL+mapTY/MNkzbsLhu
         3mEQ==
X-Received: by 10.14.204.137 with SMTP id h9mr7801456eeo.13.1374087401308;
        Wed, 17 Jul 2013 11:56:41 -0700 (PDT)
Received: from localhost.localdomain (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id n5sm12995504eed.9.2013.07.17.11.56.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 11:56:40 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        cernekee@gmail.com, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3.11-rc2] MIPS: BMIPS: fix thinko to release slave TP from reset
Date:   Wed, 17 Jul 2013 19:56:31 +0100
Message-Id: <1374087391-5650-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Commit 4df715aa ("MIPS: BMIPS: support booting from physical CPU other
than 0") introduced a thinko which will prevents slave CPUs from being
released from reset on systems where we boot from TP0. The problem is
that we are checking whether the slave CPU logical CPU map is 0, which
is never true for systems booting from TP0, so we do not release the
slave TP from reset and we are just stuck. Fix this by properly checking
that the CPU we intend to boot really is the physical slave CPU (logical
and physical value being 1).

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ralf, John,

This 3.11-rc2 material since the offending commit is in 3.11-rc1. Thanks!

 arch/mips/kernel/smp-bmips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index aea6c08..6744537 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -173,7 +173,7 @@ static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 	else {
 #if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
 		/* Reset slave TP1 if booting from TP0 */
-		if (cpu_logical_map(cpu) == 0)
+		if (cpu_logical_map(cpu) == 1)
 			set_c0_brcm_cmt_ctrl(0x01);
 #elif defined(CONFIG_CPU_BMIPS5000)
 		if (cpu & 0x01)
-- 
1.8.1.2
