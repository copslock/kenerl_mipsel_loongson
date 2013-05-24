Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 23:54:44 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:51572 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834988Ab3EXVyWxmRHn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 23:54:22 +0200
Received: by mail-pd0-f179.google.com with SMTP id q11so4574926pdj.24
        for <multiple recipients>; Fri, 24 May 2013 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nDdruCJkJKKw/gp4jPUhd71U5s+2QA4NkqK1qdvC/2Q=;
        b=edHct9tQuVtNfVzH8+opt3oNxGsWS5b9/dGJ02V7wHIwMFTs9bf6F7DROeRT1bCpF1
         Xth1t+AFecKX/Uy2FUAtqsHJGpDJHDW9mC8sl2Kjb9TEziRCOBXJ9SCX05lCFSGCRdqU
         QqD6mUc2y5HIasw3otXxpO0pENB0O5UwrFaTDibKUPZEFIagaG9o+hJR0KSUvgHe4vOY
         Zu9d1xwLNZ2nB4Q2ccalxbLAjsP6Y/NvURXqyS4VGWfcNhf2UsRmUSqDV5+RopCbKl4y
         rSY/Slt0AitouTAi9l6xUz/s3d71V7UCpSsvjhiZzE61XJ8VLHvjCiMkO7nTrlFHbWki
         SmDg==
X-Received: by 10.68.131.195 with SMTP id oo3mr19483658pbb.143.1369432456167;
        Fri, 24 May 2013 14:54:16 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id lq4sm18993302pab.19.2013.05.24.14.54.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 14:54:15 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4OLsDZZ013624;
        Fri, 24 May 2013 14:54:13 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4OLsD7S013623;
        Fri, 24 May 2013 14:54:13 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 1/3] MIPS: Declare emulate_load_store_microMIPS as a static function.
Date:   Fri, 24 May 2013 14:54:08 -0700
Message-Id: <1369432450-13583-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36592
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

It is only used from within a single file, it should not be globally
visible.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/unaligned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 203d885..5563e9b 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -684,7 +684,8 @@ const int reg16to32[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
 /* Recode table from 16-bit STORE register notation to 32-bit GPR. */
 const int reg16to32st[] = { 0, 17, 2, 3, 4, 5, 6, 7 };
 
-void emulate_load_store_microMIPS(struct pt_regs *regs, void __user * addr)
+static void emulate_load_store_microMIPS(struct pt_regs *regs,
+					 void __user *addr)
 {
 	unsigned long value;
 	unsigned int res;
-- 
1.7.11.7
