Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:07:44 +0100 (CET)
Received: from mail-la0-f44.google.com ([209.85.215.44]:35461 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008834AbaLOSGiiBY6W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:06:38 +0100
Received: by mail-la0-f44.google.com with SMTP id gd6so9918449lab.31
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RZt1Wsp2GG4lX/ww40QIzz/iSEDl1u5RX9Q+Yc/sgH0=;
        b=t6WDUddiG6rG4YoGp4xDp4KG3H1k+sIcdjVuSETyDGllb1VVb5qkzwqAIqOt7gKG1t
         bprT+J/GDtinmymJbBZ4TuGryq9HN0Gfxb1P0w2dvJC7ok0Tcj3hw13bjqX8Me70be0v
         3HxKcd2OL+YD6EtOLyPR96PgMSoXoltJgQ5FXI4z+AlppzIL+reqmViEbU6rwTTLRJfx
         8W6jHVycjkZkeppY2qTgTiBfaH13e0le/zi/nfMfP6LYxsW8/7RPdIpGw0pZN+4X4MWK
         M+CtVl3aBrdUq6WQGE3wtFKLihios36pCh6MNhGOR5gZUp4FeiT+a4QzOMgNtAQWbBZA
         k6Tw==
X-Received: by 10.112.156.42 with SMTP id wb10mr31922126lbb.17.1418666793424;
        Mon, 15 Dec 2014 10:06:33 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:32 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 06/14] MIPS: Remove unneeded #ifdef __KERNEL__ from asm/processor.h
Date:   Mon, 15 Dec 2014 21:03:12 +0300
Message-Id: <1418666603-15159-7-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
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

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/include/asm/processor.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index a5b8a7f..728b05a 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -54,9 +54,7 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_SIZE	0x7fff8000UL
 #endif
 
-#ifdef __KERNEL__
 #define STACK_TOP_MAX	TASK_SIZE
-#endif
 
 #define TASK_IS_32BIT_ADDR 1
 
@@ -73,11 +71,7 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_SIZE32	0x7fff8000UL
 #define TASK_SIZE64	0x10000000000UL
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-
-#ifdef __KERNEL__
 #define STACK_TOP_MAX	TASK_SIZE64
-#endif
-
 
 #define TASK_SIZE_OF(tsk)						\
 	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-- 
2.1.3
