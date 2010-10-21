Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 16:58:20 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:44291 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491138Ab0JUO6R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Oct 2010 16:58:17 +0200
Received: by yxl31 with SMTP id 31so2040264yxl.36
        for <multiple recipients>; Thu, 21 Oct 2010 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ssajqTeYKKvtmFXcJTRdq6rzrXIvnFu/lnbWiTehq2o=;
        b=vKtCRGjSctlq1myg/qgKDNu3OqvuU2GqHoveqIsyANpIKxSDPYBeD9WQnCzGIr4Yik
         b6hZ1kHKkwnnzY9FXk8nt1woIB/ayMQQ45/MTrcGlM63IHSmFJooxuTDa7TuK1ExDyMY
         lM2/54VxVWz4o96Zcu5h7BGrXvqQ0QX3StjvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LMMcBW31ccYlgPxQKXQkCS44Dt4uR9DYNrW/nKHP5UyUe36yNiQHNsicQufbQXjw7A
         FuHRozE5W1X+YdHWoPN5jHDjd/riGLgG7HRM4ulI3BqV6Oech3uT+u7gFu2k2e4VXogT
         V6ZDBLNDbLWJQyQMe0r/VRGXm6YNPv2vLoaro=
Received: by 10.100.255.7 with SMTP id c7mr913542ani.227.1287673090369;
        Thu, 21 Oct 2010 07:58:10 -0700 (PDT)
Received: from localhost.localdomain ([211.201.183.198])
        by mx.google.com with ESMTPS id w15sm1987179anw.33.2010.10.21.07.58.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 07:58:08 -0700 (PDT)
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Define dummy MAX_DMA_CHANNELS to fix build failure
Date:   Thu, 21 Oct 2010 23:57:59 +0900
Message-Id: <1287673079-15065-1-git-send-email-namhyung@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

allmodconfig build failes like following:

  CC [M]  sound/oss/soundcard.o
sound/oss/soundcard.c:68: error: 'MAX_DMA_CHANNELS' undeclared here (not in a function)
make[3]: *** [sound/oss/soundcard.o] Error 1
make[2]: *** [sound/oss] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 arch/mips/include/asm/dma.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/dma.h b/arch/mips/include/asm/dma.h
index 1353c81..e0d498c 100644
--- a/arch/mips/include/asm/dma.h
+++ b/arch/mips/include/asm/dma.h
@@ -74,7 +74,9 @@
  *
  */
 
-#ifndef CONFIG_GENERIC_ISA_DMA_SUPPORT_BROKEN
+#ifdef CONFIG_GENERIC_ISA_DMA_SUPPORT_BROKEN
+#define MAX_DMA_CHANNELS	0
+#else
 #define MAX_DMA_CHANNELS	8
 #endif
 
-- 
1.7.0.4
