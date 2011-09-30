Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2011 20:49:47 +0200 (CEST)
Received: from a-pb-sasl-sd.pobox.com ([74.115.168.62]:42642 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491071Ab1I3Stm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2011 20:49:42 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 365797256
        for <linux-mips@linux-mips.org>; Fri, 30 Sep 2011 14:49:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id; s=sasl; bh=moaW8BYkkwYXOfkON6tdmUl7NUU
        =; b=vcv4AaIb1O78AIKZETW+ygP8wQzYRsE3thH/zde4iWaLQ9QT/zL6SaYrivy
        HZbVG7SfZnDPRunxRODTklxwcSGp4AAESswNXi3kFUBTdGdjnMf2btczWySVU/R3
        QTfcVYfMKyXWVyoIvkM35XhSg7h1mO2JBpFq02wjBUVHLC8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id; q=dns; s=sasl; b=iWbfEEemMOsbyvVB0K15wyZOMIKkf
        9P76mPRq5OdgG/DVMFtuKF7uw8oDvxQrywj+sRpiy52nTQx3lp79Pq7ebvJiDslu
        6XKEJaSxTc9BJlRzIEldf9thhyLv2fgwnAhO0loKFC+lG0tSZ9S8ZUHXO2sv6ls0
        L5HqBDfJwr2jR4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
        by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DDC47254
        for <linux-mips@linux-mips.org>; Fri, 30 Sep 2011 14:49:37 -0400 (EDT)
Received: from orca.stoopid.dyndns.org (unknown [99.12.192.254]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F8C37252 for
 <linux-mips@linux-mips.org>; Fri, 30 Sep 2011 14:49:36 -0400 (EDT)
From:   Nathan Lynch <ntl@pobox.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] mips: call oops_enter, oops_exit in die
Date:   Fri, 30 Sep 2011 13:49:35 -0500
Message-Id: <1317408575-14855-1-git-send-email-ntl@pobox.com>
X-Mailer: git-send-email 1.7.6.2
X-Pobox-Relay-ID: F1E72A58-EB94-11E0-92C4-65B1DE995924-04752483!a-pb-sasl-sd.pobox.com
X-archive-position: 31187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ntl@pobox.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19020

This allows pause_on_oops and mtdoops to work.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/mips/kernel/traps.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b7517e3..dc31056 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -14,6 +14,7 @@
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -374,6 +375,8 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	unsigned long dvpret = dvpe();
 #endif /* CONFIG_MIPS_MT_SMTC */
 
+	oops_enter();
+
 	if (notify_die(DIE_OOPS, str, regs, 0, regs_to_trapnr(regs), SIGSEGV) == NOTIFY_STOP)
 		sig = 0;
 
@@ -389,6 +392,8 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	add_taint(TAINT_DIE);
 	spin_unlock_irq(&die_lock);
 
+	oops_exit();
+
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
-- 
1.7.6.2
