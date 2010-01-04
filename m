Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:19:21 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:36824 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493171Ab0ADJRs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:17:48 +0100
Received: by mail-yx0-f204.google.com with SMTP id 42so15199460yxe.22
        for <multiple recipients>; Mon, 04 Jan 2010 01:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=GS0exdFuxNKa8hWu/444H55EVRz3Q5FgpimvJihM/AY=;
        b=eKAVIpfxLV0xS6QX8e8m7q7U/xcOYPa746J152Soi5zpYhIWHfEfJXmaJ0oTr3paP5
         v27VyrUY9xTHBLg1aPHl5UvmNlrCvPYvdQiPMSxwhADQii8ktvstMa1yerjP+ZRHPiVy
         E1UBjBLn9zadS5rp9Ak7d2EtvsNs/cVIPgQ1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Mlidzwc8IZWbIr3kbb0QH1tnwxZGMLcy8gjCSuFxQ2aPEc2LghhCxL+pdmSVHR3Ia4
         T9OQ3DpQnB6Rav8BdFaQzQ+Kgi8Im1fZ3/y5kGUTs5C4ttQXLRXPrakQeRnNtScM58wy
         J93J8uJX/p6ESTD/XqBZfGswxGsigQtOAfTFE=
Received: by 10.101.165.30 with SMTP id s30mr36116288ano.77.1262596667556;
        Mon, 04 Jan 2010 01:17:47 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.17.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:17:46 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 05/10] Loongson: Move prom_argc and prom_argv into prom_init_cmdline()
Date:   Mon,  4 Jan 2010 17:16:47 +0800
Message-Id: <a5bac10a774e405cffcf79edc430b31d6becb0d0.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <dc64ae336edaf61405e56534e33fe40c49694378.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
 <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
 <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
 <9bcc0f00c46fdf5c832ce3bdd0df8d7f08b7a1be.1262596493.git.wuzhangjin@gmail.com>
 <dc64ae336edaf61405e56534e33fe40c49694378.1262596493.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2264

From: Wu Zhangjin <wuzhangjin@gmail.com>

prom_argc and prom_argv are only used by prom_init_cmdline(), move them
into the function.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/cmdline.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
index 7ad47f2..9e32837 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -21,12 +21,11 @@
 
 #include <loongson.h>
 
-int prom_argc;
-/* pmon passes arguments in 32bit pointers */
-int *_prom_argv;
-
 void __init prom_init_cmdline(void)
 {
+	int prom_argc;
+	/* pmon passes arguments in 32bit pointers */
+	int *_prom_argv;
 	int i;
 	long l;
 
-- 
1.6.5.6
