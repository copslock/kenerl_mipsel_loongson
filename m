Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 15:20:46 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:59958 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492121Ab0DGNUD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 15:20:03 +0200
Received: by pwj3 with SMTP id 3so917462pwj.36
        for <multiple recipients>; Wed, 07 Apr 2010 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=uZWwT2a0zCcz5+9PmRR/o5+evszG5Dxs04VVpLfjHKc=;
        b=M3LZdhPN0Iaxi8iYfFFCSXys2tTXOJcD/sZgR41VAndpvHypgegKUt0+SILaCWcDn+
         PqMnD5RxKomXJF2Pt3kM1T3UdGYaiGRZNBByAswkIf0s4U6AYl/6FQ8r9Boy5oeEg29X
         Ew+NqRhNnqlCuxhnJMAtj3/x/0v5lmwUTPOs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K4rBBPuI01Zs9KjhpmvN/6olaph+7XUctZd4e5TjUkCVthDdzr2igLlsqUSLa8EByr
         axJoEa+CfJpDUbFhHIvDMaH9qu00sVIWoUewF8nkuvdksgRQ4cgxmoaw5Fi8UHG6tEJD
         VCLzVr2Wubr9MCoFfRRPkqtwqsRZlgHNn9vr4=
Received: by 10.142.209.6 with SMTP id h6mr3286591wfg.11.1270646394142;
        Wed, 07 Apr 2010 06:19:54 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm3753168pzk.15.2010.04.07.06.19.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 06:19:53 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v4 3/4] Loongson-2F: Flush the branch target history in BTB and RAS (cont.)
Date:   Wed,  7 Apr 2010 21:11:53 +0800
Message-Id: <2ec826149b079c1e088c7de5aee41b67d8fab026.1270645413.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270645413.git.wuzhangjin@gmail.com>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270645413.git.wuzhangjin@gmail.com>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch uses the new option CONFIG_CPU_JUMP_WORKAROUNDS introduced
from "Loongson: Add CPU_LOONGSON2F_WORKAROUNDS" to enable the
workarounds for the necessary loongson series(2F01/02).

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/stackframe.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index c841912..58730c5 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -121,7 +121,7 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
-#ifdef CONFIG_CPU_LOONGSON2F
+#ifdef CONFIG_CPU_JUMP_WORKAROUNDS
 		/*
 		 * Clear BTB (branch target buffer), forbid RAS (return address
 		 * stack) to workaround the Out-of-order Issue in Loongson2F
-- 
1.7.0.1
