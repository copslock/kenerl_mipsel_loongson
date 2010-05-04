Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:55:55 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:46335 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492181Ab0EDJzE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:04 +0200
Received: by qyk30 with SMTP id 30so5119707qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:54:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.39.76 with SMTP id f12mr7273232qae.304.1272966897806; Tue, 
        04 May 2010 02:54:57 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:54:57 -0700 (PDT)
Date:   Tue, 4 May 2010 17:54:57 +0800
Message-ID: <v2w180e2c241005040254h59bd552fv160cee08beaa01ca@mail.gmail.com>
Subject: [PATCH 1/12] remove set_irq_trigger_mode to mach_init_irq
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>
Cc:     wuzhangjin@gmail.com, apatard@mandriva.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

The function set_irq_trigger_mode is used to set the interrupt trigger
level and it should be machine specific. That means we need to remove
this function from common/irq.c to irq.c of different loongson
machines.


Signed-off-by: yajin <yajin@vm-kernel.org>
---
 arch/mips/loongson/common/irq.c     |    3 ---
 arch/mips/loongson/fuloong-2e/irq.c |    3 +++
 arch/mips/loongson/lemote-2f/irq.c  |    3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
index 20e7328..987feeb 100644
--- a/arch/mips/loongson/common/irq.c
+++ b/arch/mips/loongson/common/irq.c
@@ -56,9 +56,6 @@ void __init arch_init_irq(void)
 	 */
 	clear_c0_status(ST0_IM | ST0_BEV);

-	/* setting irq trigger mode */
-	set_irq_trigger_mode();
-
 	/* no steer */
 	LOONGSON_INTSTEER = 0;

diff --git a/arch/mips/loongson/fuloong-2e/irq.c
b/arch/mips/loongson/fuloong-2e/irq.c
index 320e937..3881bd3 100644
--- a/arch/mips/loongson/fuloong-2e/irq.c
+++ b/arch/mips/loongson/fuloong-2e/irq.c
@@ -59,6 +59,9 @@ void __init mach_init_irq(void)
 	 *   32-63        ------> bonito irq
 	 */

+	/* setting irq trigger mode */
+	set_irq_trigger_mode();
+
 	/* Sets the first-level interrupt dispatcher. */
 	mips_cpu_irq_init();
 	init_i8259_irqs();
diff --git a/arch/mips/loongson/lemote-2f/irq.c
b/arch/mips/loongson/lemote-2f/irq.c
index 1d8b4d2..f3eee56 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -122,6 +122,9 @@ void __init mach_init_irq(void)
 	 *   32-63        ------> bonito irq
 	 */

+	/* setting irq trigger mode */
+	set_irq_trigger_mode();
+
 	/* Sets the first-level interrupt dispatcher. */
 	mips_cpu_irq_init();
 	init_i8259_irqs();
-- 
1.5.6.5
