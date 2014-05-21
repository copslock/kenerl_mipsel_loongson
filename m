Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 04:50:22 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33286 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822271AbaEUCtxg9UFe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 04:49:53 +0200
Received: by mail-pd0-f179.google.com with SMTP id x10so905013pdj.24
        for <multiple recipients>; Tue, 20 May 2014 19:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=+6QmGx/RNtAp8Dk16nMW/iz6M9EvJABRD25OGLKDn54=;
        b=D/5wpNsw6+gWFpgfYyVhGWdFG5ModyuCaRK1LiJNkD4iaayKPK7x86lNB2kkAQGHed
         rRf+ZPZeiBzzZNa8EpNL+UHy6ujwdg2Q/FajgIsUZtIdX++CM9xGbU7oy4hNM+NQGIjo
         r3rmVSnrn8+ieThycupb3kMWwq3WT5ZQH8G/D4rE9+o17byuxOrs66wJECQWrNSi7tMI
         lLMcC8gPk5+vXeHwRCwTCZgM6qBgTmONTlEQKM6cNqEo9tkZFL2K6rQtxdZXDOsg6gFJ
         xWgXpbcFAcZDVne1uOk2DkHjktu31nGbaGuI7qsVOo6DBKckgEYpGxQ6klM911XUPsnG
         UoJw==
X-Received: by 10.66.150.228 with SMTP id ul4mr55818944pab.16.1400640587184;
        Tue, 20 May 2014 19:49:47 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id iz2sm5402445pbb.95.2014.05.20.19.49.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 19:49:46 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Fix a typo error in AUDIT_ARCH definition
Date:   Wed, 21 May 2014 10:49:19 +0800
Message-Id: <1400640559-29867-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Missing a "|" in AUDIT_ARCH_MIPSEL64N32 macro definition.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 include/uapi/linux/audit.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 1b1efdd..4c31a36 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -357,7 +357,7 @@ enum {
 #define AUDIT_ARCH_MIPS64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|\
 				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
 #define AUDIT_ARCH_MIPSEL64	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
-#define AUDIT_ARCH_MIPSEL64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE\
+#define AUDIT_ARCH_MIPSEL64N32	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE|\
 				 __AUDIT_ARCH_CONVENTION_MIPS64_N32)
 #define AUDIT_ARCH_OPENRISC	(EM_OPENRISC)
 #define AUDIT_ARCH_PARISC	(EM_PARISC)
-- 
1.7.7.3
