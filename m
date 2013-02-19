Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2013 09:13:00 +0100 (CET)
Received: from cn.fujitsu.com ([222.73.24.84]:13878 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823059Ab3BSIM6c6wi9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Feb 2013 09:12:58 +0100
X-IronPort-AV: E=Sophos;i="4.84,693,1355068800"; 
   d="scan'208";a="6729000"
Received: from unknown (HELO tang.cn.fujitsu.com) ([10.167.250.3])
  by song.cn.fujitsu.com with ESMTP; 19 Feb 2013 16:10:29 +0800
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
        by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r1J8Cllm009740;
        Tue, 19 Feb 2013 16:12:47 +0800
Received: from liguang.fnst.cn.fujitsu.com ([10.167.225.128])
          by fnstmail02.fnst.cn.fujitsu.com (Lotus Domino Release 8.5.3)
          with ESMTP id 2013021916120874-239743 ;
          Tue, 19 Feb 2013 16:12:08 +0800 
From:   liguang <lig.fnst@cn.fujitsu.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH] mips: remove unecessary __linux__ check
Date:   Tue, 19 Feb 2013 16:12:51 +0800
Message-Id: <1361261571-1556-1-git-send-email-lig.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 1.7.2.5
X-MIMETrack: Itemize by SMTP Server on mailserver/fnst(Release 8.5.3|September 15, 2011) at
 2013/02/19 16:12:08,
        Serialize by Router on mailserver/fnst(Release 8.5.3|September 15, 2011) at
 2013/02/19 16:12:09,
        Serialize complete at 2013/02/19 16:12:09
X-archive-position: 35787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lig.fnst@cn.fujitsu.com
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

sgidefs.h has strict check for __linux__,
it seems too harsh, as far as I test, 2 cross
compiler for mips will not define it automatically,
and exit build process with error
"#error Use a Linux compiler or give up".
remove it will not hurt, I think.

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 arch/mips/include/uapi/asm/sgidefs.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include/uapi/asm/sgidefs.h
index 876442f..5be81f8 100644
--- a/arch/mips/include/uapi/asm/sgidefs.h
+++ b/arch/mips/include/uapi/asm/sgidefs.h
@@ -11,14 +11,6 @@
 #define __ASM_SGIDEFS_H
 
 /*
- * Using a Linux compiler for building Linux seems logic but not to
- * everybody.
- */
-#ifndef __linux__
-#error Use a Linux compiler or give up.
-#endif
-
-/*
  * Definitions for the ISA levels
  *
  * With the introduction of MIPS32 / MIPS64 instruction sets definitions
-- 
1.7.2.5
