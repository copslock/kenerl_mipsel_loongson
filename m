Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 00:10:21 +0200 (CEST)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:43699 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6900482AbaHMWJRVv8ul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2014 00:09:17 +0200
Received: by mail-lb0-f181.google.com with SMTP id 10so300654lbg.40
        for <multiple recipients>; Wed, 13 Aug 2014 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KonUUIUk2Pu8fMZ4bOyRslfAVKgfZ4u9+il9a2vo05Y=;
        b=04KhJYU7sk0bJy8pJRV2PsKj/6jsOp6V52E0+3T5GmLP1npUCvjLgdXstq25UNbMWL
         6sRyNHKPe9+z2GfZ9Glasq0LMIx+rWd4Tg8J3mUyNoPfkQjlEGP8cNpM+V6Qub3pmY+U
         YJhUe3z35uPDtr04dr/5V25xR7ftiosXMa/4LN+sRBTs7W99py5zrS0YPjz4dYHA71ce
         hFa0oRw4gssOt4R1uye/ziG9mweLkoCM1YwW1vD3JvQYVHWuByHs5wac8IZ6wq+L9D0y
         OAfoMSNyU/7RmWpiqEtSJbX5nkM1G9moIeMRt5IWoDOwnM/EEhrXjtLM3H2k+LS83QqQ
         HBxg==
X-Received: by 10.152.245.171 with SMTP id xp11mr737448lac.61.1407967750238;
        Wed, 13 Aug 2014 15:09:10 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id x10sm1927137lal.13.2014.08.13.15.09.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 15:09:09 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: add common plat_irq_dispatch declaration
Date:   Thu, 14 Aug 2014 02:09:36 +0400
Message-Id: <1407967776-7320-3-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1407967776-7320-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1407967776-7320-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Add common declaration to get rid of following sparse warning: "symbol
'plat_irq_dispatch' was not declared. Should it be static?"

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 arch/mips/cavium-octeon/setup.c | 1 -
 arch/mips/include/asm/irq.h     | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 008e9c8..dba7cf7 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -263,7 +263,6 @@ static uint64_t crashk_size, crashk_base;
 static int octeon_uart;
 
 extern asmlinkage void handle_int(void);
-extern asmlinkage void plat_irq_dispatch(void);
 
 /**
  * Return non zero if we are currently running in the Octeon simulator
diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index ae1f7b2..39f07ae 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -26,6 +26,8 @@ static inline int irq_canonicalize(int irq)
 #define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
+asmlinkage void plat_irq_dispatch(void);
+
 extern void do_IRQ(unsigned int irq);
 
 extern void arch_init_irq(void);
-- 
1.8.1.5
