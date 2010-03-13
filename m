Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 05:45:58 +0100 (CET)
Received: from mail-px0-f189.google.com ([209.85.216.189]:58659 "EHLO
        mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491001Ab0CMEpz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Mar 2010 05:45:55 +0100
Received: by pxi27 with SMTP id 27so2110016pxi.0
        for <multiple recipients>; Fri, 12 Mar 2010 20:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7ZXouYudrJmeK/+cVsboMRJmXpFppTKTJ7E8DejkODo=;
        b=bTJcgnAlEa2xWoKMd4NJpINHLIgzeFbEo1jWOZOnmgkLklRwM3+rsfLutVWRs28mDu
         JsBR3ULHfjhw22WNrAD3MOcnG+RaEU7TD5ay00uE4TQF5aiASAmtzdCFlY9n9KDg8B7H
         WDiutx3HGZFDf/hdP3wto71bInHEgaVr+lwA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=G4sPRG+5/5EkJm/8GTFY4iOJOJb9gKdCaZKmphQNXz248P6FG6OW6goGLD13lQJgcV
         8VZFBDWljwfXBSzMJ4mD4S0qKtFRKjJeMSBukETCGew9hoFBqR1eyHXpKl60lBlW2/ZV
         ZvvqoV9We6sjWDsDP783Aocs6kGVwEJZyb9z0=
Received: by 10.115.64.27 with SMTP id r27mr3381177wak.6.1268455545410;
        Fri, 12 Mar 2010 20:45:45 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 21sm2172318pzk.0.2010.03.12.20.45.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:45:44 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v3 1/3] Loongson-2F: Flush the branch target history such as BTB and RAS
Date:   Sat, 13 Mar 2010 12:34:15 +0800
Message-Id: <05e2ba2596f23fa4dda64d63ce2480504b1be4ac.1268453720.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1268453720.git.wuzhangjin@gmail.com>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1268453720.git.wuzhangjin@gmail.com>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As the Chapter 15: "Errata: Issue of Out-of-order in loongson"[1] shows, to
workaround the Issue of Loongson-2F，We need to do:

"When switching from user mode to kernel mode, you should flush the
branch target history such as BTB and RAS."

This patch did clear BTB(branch target buffer), forbid RAS(return
address stack) via Loongson-2F's 64bit diagnostic register.

[1] Chinese Version: http://www.loongson.cn/uploadfile/file/200808211
[2] English Version of Chapter 15:
http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/stackframe.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 3b6da33..c841912 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -121,6 +121,25 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
+#ifdef CONFIG_CPU_LOONGSON2F
+		/*
+		 * Clear BTB (branch target buffer), forbid RAS (return address
+		 * stack) to workaround the Out-of-order Issue in Loongson2F
+		 * via its diagnostic register.
+		 */
+		move	k0, ra
+		jal	1f
+		 nop
+1:		jal	1f
+		 nop
+1:		jal	1f
+		 nop
+1:		jal	1f
+		 nop
+1:		move	ra, k0
+		li	k0, 3
+		mtc0	k0, $22
+#endif /* CONFIG_CPU_LOONGSON2F */
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
-- 
1.7.0.1
