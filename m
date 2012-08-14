Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 20:09:07 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:35445 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903853Ab2HNSIO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 20:08:14 +0200
Received: by yhjj52 with SMTP id j52so803195yhj.36
        for <multiple recipients>; Tue, 14 Aug 2012 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Nj0HtLeW+vkX+aIh8kadTFoHa7TDWH9ODKkpyVKPE1M=;
        b=ZAmy0DePiIsGumAr0XOUO145aRx6phc+FH3F2muH3PrcLs1Pp4ZQtMDdEGE4U140IM
         y1LnJpbV/eK2bR1TdD/Ikw6SmmYwTksxCnA6Bihm3bpXf9QBuASW4uEX0+geWsvcqHYq
         r6c+f3wlFTs01M27ZHOIRGpKVnN5YtpEk7ff0JH/w2BW5m8NFjFEavTBBpYetctOxqhq
         SH+H8p7pFwOXROQTc/eIK0THSoBgcRI0ASs3H9tMjY56f8rlAj9e6HxF5M/DB+xnB4Ap
         ABJpfFActc+1IclGRrMO+6bGndCg5cPoTKetea1n9iyYzO94Zx75ezHUxcKym2ROoAXR
         otqA==
Received: by 10.50.47.201 with SMTP id f9mr13028026ign.49.1344967688056;
        Tue, 14 Aug 2012 11:08:08 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id dw5sm12260923igc.6.2012.08.14.11.08.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 11:08:07 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q7EI85dC013217;
        Tue, 14 Aug 2012 11:08:05 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q7EI85lW013216;
        Tue, 14 Aug 2012 11:08:05 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] vmlinux.lds.h: Allow architectures to add sections to the front of .bss
Date:   Tue, 14 Aug 2012 11:08:00 -0700
Message-Id: <1344967681-13179-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
References: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34167
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Follow-on MIPS patch will put an object here that needs 64K alignment
to minimize padding.

For those architectures that don't define BSS_FIRST_SECTIONS, there is
no change.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 include/asm-generic/vmlinux.lds.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 4e2e1cc..d1ea7ce 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -530,9 +530,18 @@
 		*(.scommon)						\
 	}
 
+/*
+ * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
+ * sections to the front of bss.
+ */
+#ifndef BSS_FIRST_SECTIONS
+#define BSS_FIRST_SECTIONS
+#endif
+
 #define BSS(bss_align)							\
 	. = ALIGN(bss_align);						\
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
+		BSS_FIRST_SECTIONS					\
 		*(.bss..page_aligned)					\
 		*(.dynbss)						\
 		*(.bss)							\
-- 
1.7.2.3
