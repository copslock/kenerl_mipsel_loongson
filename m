Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:25:04 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:58459 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491961Ab0ELNYQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:24:16 +0200
Received: by mail-pv0-f177.google.com with SMTP id 30so40862pvc.36
        for <multiple recipients>; Wed, 12 May 2010 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=WEj3lOc32U7T+DIUTdePusY6pim8mMz/xVyGgNafz2U=;
        b=bXBVU3ejARXc4otwNxQf86NrFxQIm38iC/Y9NxoSnhfcBRT/TKvsfj49pT/ajPX6tQ
         0t7fswAJHuzSo8Pxx9D8BFTYU+yZmatmfOKHY68RYyis07vgsvlFDPr3OsQBJFzVFF9p
         3O4z4TNaMxCSvsvx7vuZQfp8/ENVlnHIxRISw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pLxUS1Jh3G7TewWFD6x9GD40Iws/eFjbz08LJ3lyHwip1rrlAXJ3bCeRGQ0xAYiRJn
         phcBU/Yw/GiNssxJ/i7n2w9z/L0Ybji3Ye26CY0OJSWS8OP7oCSmMzqHHIUk5vZ7tccZ
         +aHZ7IWd5zyKegt8JLBM6ArOamdfJI9hW0G8I=
Received: by 10.115.38.22 with SMTP id q22mr5856182waj.41.1273670655409;
        Wed, 12 May 2010 06:24:15 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.24.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:24:14 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 4/9] tracing: MIPS: mcount.S: cleanup of the comments
Date:   Wed, 12 May 2010 21:23:12 +0800
Message-Id: <bb0a1aa413ad839989900d0ee8ae9159ce18760f.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch cleans the comments up.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 991cbdf..84303bf 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -6,6 +6,7 @@
  * more details.
  *
  * Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University, China
+ * Copyright (C) 2010 DSLab, Lanzhou University, China
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
@@ -69,14 +70,14 @@ _mcount:
 
 	MCOUNT_SAVE_REGS
 #ifdef KBUILD_MCOUNT_RA_ADDRESS
-	PTR_S	$12, PT_R12(sp)	/* $12 saved the location of the return address(at) by -mmcount-ra-address */
+	PTR_S	$12, PT_R12(sp)	/* save location of parent's return address */
 #endif
 
-	move	a0, ra		/* arg1: next ip, selfaddr */
+	move	a0, ra		/* arg1: self return address */
 	.globl ftrace_call
 ftrace_call:
 	nop	/* a placeholder for the call to a real tracing function */
-	 move	a1, AT		/* arg2: the caller's next ip, parent */
+	 move	a1, AT		/* arg2: parent's return address */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.globl ftrace_graph_call
@@ -117,9 +118,9 @@ NESTED(_mcount, PT_SIZE, ra)
 static_trace:
 	MCOUNT_SAVE_REGS
 
-	move	a0, ra		/* arg1: next ip, selfaddr */
+	move	a0, ra		/* arg1: self return address */
 	jalr	t2		/* (1) call *ftrace_trace_function */
-	 move	a1, AT		/* arg2: the caller's next ip, parent */
+	 move	a1, AT		/* arg2: parent's return address */
 
 	MCOUNT_RESTORE_REGS
 	.globl ftrace_stub
-- 
1.7.0.4
