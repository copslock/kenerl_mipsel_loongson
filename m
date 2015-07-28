Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 11:44:48 +0200 (CEST)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36819 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009557AbbG1JopNbM0L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Jul 2015 11:44:45 +0200
Received: by wicgb10 with SMTP id gb10so148210211wic.1;
        Tue, 28 Jul 2015 02:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=P8n2RbbqYDKPoHkin1HOmkfCZmHvH8hs0880n6lmRnw=;
        b=d7Yo/QUwowercH/yaTjSxEbx6VSfhFCw35l9nYsJL/8+areyqVz4go6/cTSmi3tgUo
         S+dnx8gKUuzbroRts2FGWrF2vzevVzzwHBs9v1uiQzfB06FjH5ABtpcMvKnjwhD4bwbW
         WSDEKmCZGAtIMf/MfrYLQLInRmgbjeU+D8SMlTLB0PpVl7JaSPY+GklEFcfEY4u+/GyB
         nEAFMrKe6fAt+Y0kX3FVdI4xh0TE3InbubhD27WKwhPeVk7UpjxKzKMl2WcE/kaChdhD
         rNIqt8Mgf36PGKE3y5v5zgyxdi6qFOoPXnXt7UQuxssKzpa9z6wOXhl/0/iHRGkzy503
         hT7g==
X-Received: by 10.194.187.51 with SMTP id fp19mr60942618wjc.67.1438076679964;
        Tue, 28 Jul 2015 02:44:39 -0700 (PDT)
Received: from anemoi.home (ip4-83-240-67-251.cust.nbox.cz. [83.240.67.251])
        by smtp.gmail.com with ESMTPSA id uc16sm18120323wib.8.2015.07.28.02.44.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 02:44:39 -0700 (PDT)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Adam Jiang <jiang.adam@gmail.com>, linux-mips@linux-mips.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 016/124] MIPS: Fix enabling of DEBUG_STACKOVERFLOW
Date:   Tue, 28 Jul 2015 11:42:30 +0200
Message-Id: <bc3544e1618915ac5be171804267b0b52461295f.1438076484.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <90d8a5681e4a9e320611b422f0ed012e148c2bca.1438076484.git.jslaby@suse.cz>
References: <90d8a5681e4a9e320611b422f0ed012e148c2bca.1438076484.git.jslaby@suse.cz>
In-Reply-To: <cover.1438076484.git.jslaby@suse.cz>
References: <cover.1438076484.git.jslaby@suse.cz>
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: James Hogan <james.hogan@imgtec.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 5f35b9cd553fd64415b563497d05a563c988dbd6 upstream.

Commit 334c86c494b9 ("MIPS: IRQ: Add stackoverflow detection") added
kernel stack overflow detection, however it only enabled it conditional
upon the preprocessor definition DEBUG_STACKOVERFLOW, which is never
actually defined. The Kconfig option is called DEBUG_STACKOVERFLOW,
which manifests to the preprocessor as CONFIG_DEBUG_STACKOVERFLOW, so
switch it to using that definition instead.

Fixes: 334c86c494b9 ("MIPS: IRQ: Add stackoverflow detection")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Adam Jiang <jiang.adam@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/10531/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index d1fea7a054be..7479d8d847a6 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -110,7 +110,7 @@ void __init init_IRQ(void)
 #endif
 }
 
-#ifdef DEBUG_STACKOVERFLOW
+#ifdef CONFIG_DEBUG_STACKOVERFLOW
 static inline void check_stack_overflow(void)
 {
 	unsigned long sp;
-- 
2.4.6
