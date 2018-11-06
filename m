Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 15:38:14 +0100 (CET)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:42229
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990697AbeKFOgk4Wuhb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 15:36:40 +0100
Received: by mail-pg1-x544.google.com with SMTP id i4-v6so5894795pgq.9;
        Tue, 06 Nov 2018 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uNGDvFPN4zXrSe9ynX/chysgNcrdJz+M6yhXOppEXqw=;
        b=IRuqjrLvFtNyyzsM69h7vDIEacAd3HwDNczvFQ2ugGYRaUuv1nUW1bSytwEc8m6Zgw
         oa6QsmW9F2TIoIsHIYdZJGbkI7BSr/xgTb6o33FU1oLset9FvUzuJxGpHmgAHRkne4NY
         PdgCP9ZHVc7svhOca9Tp5gEptb1Oc9RGXjO/rsBjSFgtn6M0vJGwyY9HK+3lE279O3Zz
         +B1pZ6S7R0u5jADQ8P9MUPTMhHN+w2EX11JvjilJel79l/57+sGSdpQoWdUb4ofI3zf4
         Y/vjz1sisXDXIJ57Nkshl3hAMILFKmnxypJgTtVqzetxVKsNn1TroOhSaXsimOThHkNx
         NyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uNGDvFPN4zXrSe9ynX/chysgNcrdJz+M6yhXOppEXqw=;
        b=Kb2GpkRVjLZhQD02RcAJNj/Mts9JChOeoTTP8N+TCW32c4TYiR8dV4q8o0kulw2+nC
         VU7hAtPCDhqQCV+Tnaq9Lh3AIxHP91+dmPcyOPNUcN0WJ5w5ZqB9Dh36aevBJguNsH97
         nS8Apio/PBcZdc3c9z2CIYMGYt6M1/Fgew6L3M10o0nr7h91MGRxKZqbho/Sk63vWLvi
         SeLwea95T7Y9H+NT7yhRoHPJF/hfqGj/YwUuUdRiRHMfK2Yo3p6WIMt176CfkLksySD6
         q9JdqNfAJfV1JxEBOY6qxXE3GojZB9MJSpi3/KN4xuvBqMjtpBSis97xTUL2T0S1DokY
         79bA==
X-Gm-Message-State: AGRZ1gKgzmXX5c7JI6UvmkbdHghyHUk8ApK+8GXSBvvsvQ1CbH8EryQh
        QMPpEwvMqqrLk7WFJeBo41WzeanSHII=
X-Google-Smtp-Source: AJdET5dsZZctpnYrlfXINBsLUr3ouJ/Mvi4po3bfdnRlIBrCGvZvb/VN8/5tMiV5SyXPWnsduq6UHQ==
X-Received: by 2002:a62:5615:: with SMTP id k21-v6mr19013773pfb.190.1541514999723;
        Tue, 06 Nov 2018 06:36:39 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b75-v6sm55255142pfe.148.2018.11.06.06.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 06:36:39 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] MIPS: r2-on-r6-emu: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue,  6 Nov 2018 09:36:36 -0500
Message-Id: <20181106143636.8450-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Return-Path: <tiny.windzz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiny.windzz@gmail.com
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

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 32 +++++----------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index eb18b186e858..28cb88daa3ef 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -2242,7 +2242,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 
 #ifdef CONFIG_DEBUG_FS
 
-static int mipsr2_stats_show(struct seq_file *s, void *unused)
+static int mipsr2_emul_show(struct seq_file *s, void *unused)
 {
 
 	seq_printf(s, "Instruction\tTotal\tBDslot\n------------------------------\n");
@@ -2308,9 +2308,9 @@ static int mipsr2_stats_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int mipsr2_stats_clear_show(struct seq_file *s, void *unused)
+static int mipsr2_clear_show(struct seq_file *s, void *unused)
 {
-	mipsr2_stats_show(s, unused);
+	mipsr2_emul_show(s, unused);
 
 	__this_cpu_write((mipsr2emustats).movs, 0);
 	__this_cpu_write((mipsr2bdemustats).movs, 0);
@@ -2353,30 +2353,8 @@ static int mipsr2_stats_clear_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int mipsr2_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mipsr2_stats_show, inode->i_private);
-}
-
-static int mipsr2_stats_clear_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mipsr2_stats_clear_show, inode->i_private);
-}
-
-static const struct file_operations mipsr2_emul_fops = {
-	.open                   = mipsr2_stats_open,
-	.read			= seq_read,
-	.llseek			= seq_lseek,
-	.release		= single_release,
-};
-
-static const struct file_operations mipsr2_clear_fops = {
-	.open                   = mipsr2_stats_clear_open,
-	.read			= seq_read,
-	.llseek			= seq_lseek,
-	.release		= single_release,
-};
-
+DEFINE_SHOW_ATTRIBUTE(mipsr2_emul);
+DEFINE_SHOW_ATTRIBUTE(mipsr2_clear);
 
 static int __init mipsr2_init_debugfs(void)
 {
-- 
2.17.0
