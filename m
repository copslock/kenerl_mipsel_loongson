Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 14:14:08 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:44749 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491997Ab0DJMOE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 14:14:04 +0200
Received: by pvc30 with SMTP id 30so2248782pvc.36
        for <multiple recipients>; Sat, 10 Apr 2010 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=uZWwT2a0zCcz5+9PmRR/o5+evszG5Dxs04VVpLfjHKc=;
        b=b1tgRysBjl4VX8756cZfyA8y3g+CovFXMHcdWAqJo6mKNTNoOSUxuft46w92bkEvxe
         VjJpKBZ8aX6l0k/IgQfGgZzbIwgjisJR3boycOhsMCOKrp+guJ55mN7LgR2gvnD0ijqX
         ML714sibTsZbNad1IORe/ONcbQdtsiJFKJ2gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=EDrpJLr1Bnq4/0uDo/0vTuxXp9ucwfL5mEkB4MLxnoemMdmXmcs7mD7P8yk1CBg2tL
         r1MPvwLXiUpj5uAaCbVc0hi0TiXfoRE3iMpx9QuPojeAq/NcrhFiMUWwcUvSPwk1pDou
         /tWpr7nUFvJ08aqEfy+VWZfaOKajp5R9QKLBA=
Received: by 10.115.116.5 with SMTP id t5mr1607018wam.77.1270901637537;
        Sat, 10 Apr 2010 05:13:57 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm1922863pzk.9.2010.04.10.05.13.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 05:13:56 -0700 (PDT)
Subject: [PATCH v5 3/4] Loongson-2F: Flush the branch target history in BTB
 and RAS (cont.)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <cover.1270882402.git.wuzhangjin@gmail.com>
References: <cover.1270882402.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270882402.git.wuzhangjin@gmail.com>
References: <cover.1270882402.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 10 Apr 2010 20:07:01 +0800
Message-ID: <1270901221.14758.8.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26386
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
