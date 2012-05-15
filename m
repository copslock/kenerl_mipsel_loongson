Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 02:05:52 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:44088 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903678Ab2EOAFB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 02:05:01 +0200
Received: by dadm1 with SMTP id m1so7456777dad.36
        for <multiple recipients>; Mon, 14 May 2012 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HZFM0wmYBEleevn1dv2Sj01Rbj2rnlOCS14WedU1qso=;
        b=eibETcAKTi+0eowRUfmLemobMNWMH5LW9bYTfVQwqq5/xsXKyYyB05r1nEFcFNnx97
         1ZGdi2KNjGJCGkvctG9kiAxUj4OVNVAcqwgtzzQgn8fJ66z4jK8qGruzX6JyJvjSrNIJ
         NuoN0ICQhT01QXN5/iN5lMxRkcQ+n1GzGgZc9du9qfNV3WYdW2pOPTcRmFdIn7bpdH9K
         XwcuzV0Dwiig89SWBi3tQLt1sWdBRruTXb98itRF0wDvUtkIpalDQ9w8w6sbzGpRG3mL
         aStDx8hkU5kfBk6XCPzle/kZqH/snO3pusi+VUt8Lb0u4yDoww9i7yCVK2QxQJk6wIcF
         RYXw==
Received: by 10.68.203.66 with SMTP id ko2mr27740293pbc.84.1337040295325;
        Mon, 14 May 2012 17:04:55 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pd3sm23689250pbc.53.2012.05.14.17.04.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 17:04:53 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4F04qKF016057;
        Mon, 14 May 2012 17:04:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4F04qM4016056;
        Mon, 14 May 2012 17:04:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/5] MIPS: Introduce board_cache_error_setup() hook.
Date:   Mon, 14 May 2012 17:04:46 -0700
Message-Id: <1337040290-16015-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

This is used in subsequent patches.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/traps.h |    1 +
 arch/mips/kernel/traps.c      |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index ff74aec..420ca06 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -25,6 +25,7 @@ extern void (*board_nmi_handler_setup)(void);
 extern void (*board_ejtag_handler_setup)(void);
 extern void (*board_bind_eic_interrupt)(int irq, int regset);
 extern void (*board_ebase_setup)(void);
+extern void (*board_cache_error_setup)(void);
 
 extern int register_nmi_notifier(struct notifier_block *nb);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9fd636b..b931eba 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -105,7 +105,7 @@ void (*board_nmi_handler_setup)(void);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 void (*board_ebase_setup)(void);
-
+void __cpuinitdata(*board_cache_error_setup)(void);
 
 static void show_raw_backtrace(unsigned long reg29)
 {
@@ -1845,6 +1845,9 @@ void __init trap_init(void)
 
 	set_except_vector(26, handle_dsp);
 
+	if (board_cache_error_setup)
+		board_cache_error_setup();
+
 	if (cpu_has_vce)
 		/* Special exception: R4[04]00 uses also the divec space. */
 		memcpy((void *)(ebase + 0x180), &except_vec3_r4000, 0x100);
-- 
1.7.2.3
