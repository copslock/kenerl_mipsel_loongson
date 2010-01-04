Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:20:37 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:36824 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493167Ab0ADJSK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:18:10 +0100
Received: by mail-yx0-f204.google.com with SMTP id 42so15199460yxe.22
        for <multiple recipients>; Mon, 04 Jan 2010 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Zvmb3HA93LjVboy1ExyQeXKQ1eRn83lEdypH7uc7HBM=;
        b=PQH83q7ZxTj67X5iNTy7zQE81lMWiP8MbKEzAdQG4fKJWSJ5VTlPwX9s/J/TimLZgf
         U2LC45e73Ku0aX34cFLMs1OowPyHywgsSgIU2BCaWyo8ROopRnl6jvHuzpLiRrUsE/tn
         KX8s0BUsDjOjtsH2Ghqsw5JLymUBTM9EHM/Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jitj2nphlmct631+78ndpNx43l1ab0F90TN/wbut+wm8hTO3sXsUnyVrlG573O5WGe
         QyuK9wZ7T+V85ty83gBxHXl8x9nSB0gtjmatLkynJjUDEr9TTrcGrpq0/JIeerhC36s9
         0SpCVIY0+tceIr6BXp+uTqcn+jMycTTza6CQk=
Received: by 10.91.50.3 with SMTP id c3mr10970427agk.71.1262596689877;
        Mon, 04 Jan 2010 01:18:09 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.18.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:18:05 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 08/10] Loongson: mem.c: Fixup of the indentation
Date:   Mon,  4 Jan 2010 17:16:50 +0800
Message-Id: <d67be5cfd6f258043964e9c19c0467611e6d4ce3.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <0340ef8c9de1f84261bac07c74f435f719eaa65d.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
 <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
 <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
 <9bcc0f00c46fdf5c832ce3bdd0df8d7f08b7a1be.1262596493.git.wuzhangjin@gmail.com>
 <dc64ae336edaf61405e56534e33fe40c49694378.1262596493.git.wuzhangjin@gmail.com>
 <a5bac10a774e405cffcf79edc430b31d6becb0d0.1262596493.git.wuzhangjin@gmail.com>
 <b36e03d26901b981248854fcaa645d8c8a0f23a8.1262596493.git.wuzhangjin@gmail.com>
 <0340ef8c9de1f84261bac07c74f435f719eaa65d.1262596493.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2268

From: Wu Zhangjin <wuzhangjin@gmail.com>

Replace the whitespaces by TABs.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/mem.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
index ceacd09..ec2f796 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -16,10 +16,11 @@
 
 void __init prom_init_memory(void)
 {
-    add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+
+	add_memory_region(memsize << 20, LOONGSON_PCI_MEM_START - (memsize <<
+				20), BOOT_MEM_RESERVED);
 
-    add_memory_region(memsize << 20, LOONGSON_PCI_MEM_START - (memsize <<
-			    20), BOOT_MEM_RESERVED);
 #ifdef CONFIG_CPU_SUPPORTS_ADDRWINCFG
 	{
 		int bit;
-- 
1.6.5.6
