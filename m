Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:53:27 +0100 (CET)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:54608 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009219AbaLTBwvjcPPh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:52:51 +0100
Received: by mail-ig0-f176.google.com with SMTP id l13so1707196iga.3;
        Fri, 19 Dec 2014 17:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ShC3tih2RpPwD5pYfqF2bfA5m5m2NXZHbvtzct7Fp88=;
        b=CygXQEpr24ksH2KhQtjNpQi/f4mrav/lUWnNsX+LATyZha+68zjKXX5DZ2jAP4xHuQ
         mcj0xVrEcI+uf30BPDRDt909hrEE5tspMvwcsYbLgk70TB8RncxKN+T+FLgtDRybRlJ+
         8n0pPBuQ+aewwEZTPLPdZN5swtCZzVy/2Sz9WxoMYcNcQIfutB09h2qXRzx0f3kiAD3T
         02H21gyfRza2AiSXRln9+84qzHhOgtH9a2khoiaj+2bR/kcrmqjgDFg3Uy6iqpwG7OrB
         2oO9MqwlwMQ9oKpK42QTNSfETMB6JdoKG29gA6I6QCB77PWrC39xqeQIBuGFXLl5Gk69
         1y9A==
X-Received: by 10.43.66.9 with SMTP id xo9mr9318738icb.67.1419040365999;
        Fri, 19 Dec 2014 17:52:45 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id q196sm5346845ioe.5.2014.12.19.17.52.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 17:52:45 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id sBK1qiaU008550;
        Fri, 19 Dec 2014 17:52:44 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id sBK1qiRl008549;
        Fri, 19 Dec 2014 17:52:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [RFC PATCH v2 2/5] MIPS: Add FPU emulator counter for non-FPU instructions emulated.
Date:   Fri, 19 Dec 2014 17:52:37 -0800
Message-Id: <1419040360-8502-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
References: <1419040360-8502-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Used in follow-on patch, the counter is called "insn_emul".

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/fpu_emulator.h | 1 +
 arch/mips/math-emu/me-debugfs.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 6370c82..bd5b63f 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -45,6 +45,7 @@ struct mips_fpu_emulator_stats {
 	unsigned long ieee754_zerodiv;
 	unsigned long ieee754_invalidop;
 	unsigned long ds_emul;
+	unsigned long insn_emul;
 };
 
 DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index f308e0f..93fc155 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -62,6 +62,7 @@ do {									\
 	FPU_STAT_CREATE(ieee754_zerodiv);
 	FPU_STAT_CREATE(ieee754_invalidop);
 	FPU_STAT_CREATE(ds_emul);
+	FPU_STAT_CREATE(insn_emul);
 
 	return 0;
 }
-- 
1.7.11.7
