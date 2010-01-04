Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:18:58 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:36824 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493168Ab0ADJRn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:17:43 +0100
Received: by mail-yx0-f204.google.com with SMTP id 42so15199460yxe.22
        for <multiple recipients>; Mon, 04 Jan 2010 01:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=JU8BzTDgfWyAi5eo+baBKeYKxY81e7TLIGMcpWfMcUM=;
        b=BiCC0nvrCSCJ5uq7ruVYBDago1VyPtbdjgXyFNcfRK94seHua9DbtxtEd64u2jmyiY
         HyIwW4K3NAkEoZDzoeF/67ALAvLjFInJvxPrrr11NItt2m5hAjNL0BZGreI26ZgQi3Fa
         u6FuYCRW+4WRv8LFmNqqwJTlOpZkttMnB16a4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iUO2us4jlGmm2n4FVrUasthlYxAesnkkm6oSqdBrD3YhQT3kRwEAMj895jinTXAGrI
         irNMSEGpw3Wksk2LjnT+3zUiSuiG6Td4lD2KleB54P8OjbLxh6H7FD9hgAaTiUHE8dRQ
         6Nyad3P5AK5DBDJ6cMV+baYLjbsQzxm7C+Eus=
Received: by 10.101.182.20 with SMTP id j20mr36168429anp.65.1262596662485;
        Mon, 04 Jan 2010 01:17:42 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.17.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:17:41 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 04/10] Loongson: Remove the serial port output of compressed kernel support
Date:   Mon,  4 Jan 2010 17:16:46 +0800
Message-Id: <dc64ae336edaf61405e56534e33fe40c49694378.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <9bcc0f00c46fdf5c832ce3bdd0df8d7f08b7a1be.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
 <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
 <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
 <9bcc0f00c46fdf5c832ce3bdd0df8d7f08b7a1be.1262596493.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2263

From: Wu Zhangjin <wuzhangjin@gmail.com>

The compressed kernel support on loongson family machines is stable now,
so, remove the debug information via using SYS_SUPPORTS_ZBOOT instead of
SYS_SUPPORTS_ZBOOT_UART16550. This may reduce the image size and speedup
the booting.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9541171..e09ff2e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -180,7 +180,7 @@ config LASAT
 
 config MACH_LOONGSON
 	bool "Loongson family of machines"
-	select SYS_SUPPORTS_ZBOOT_UART16550
+	select SYS_SUPPORTS_ZBOOT
 	help
 	  This enables the support of Loongson family of machines.
 
-- 
1.6.5.6
