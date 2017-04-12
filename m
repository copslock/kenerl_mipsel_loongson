Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2017 07:21:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26491 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993201AbdDLFVu2TWz2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Apr 2017 07:21:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 026367D7CFC11;
        Wed, 12 Apr 2017 06:21:42 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 12 Apr 2017 06:21:43 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH] MIPS: smp-cps: add missing include
Date:   Wed, 12 Apr 2017 07:21:39 +0200
Message-ID: <1491974499-28414-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

An earlier change ('MIPS: Use common outgoing-CPU-notification code')
is missing a required header with cpu notification method declarations
leading to build failures.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---

Ralf,
 Could you squash this patch together with the original commit?

 arch/mips/kernel/smp-cps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 0aee71b..306b4a6 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -8,6 +8,7 @@
  * option) any later version.
  */
 
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irqchip/mips-gic.h>
-- 
2.7.4
