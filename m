Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2010 15:47:33 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:53752 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492291Ab0KPOra (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Nov 2010 15:47:30 +0100
Received: by gxk25 with SMTP id 25so377643gxk.36
        for <multiple recipients>; Tue, 16 Nov 2010 06:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Ofym5sFyqJ15LcOM4nxGy6FV2IdG5Jt8fB5IXdYp6G4=;
        b=E+vWAlHGHN7ncCb8HXy3/F3cuF7sRuM64WuetHRD9BdjhWAO2ToGhTk10Lp9LhOcm7
         ro5h/EBuk1Rcb4ChDHX6hYK4SdonctmH6tj4jUkjXIda8HzUkn2nBHY4x9DFeceIYeAz
         EcWzTCHzwyuQDLGvYef8Wm+Ph72qVUShiJkAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=baUIfW7nTFCCkgj2rh15Tjy3nuxeSFeBqs6WNBTsbbJMOjI5p1EHQLffX14u31Vdy6
         z1w7JduzU7QNlfilofXAuCwLZQcmPKxJRcFmhNuQFpXOZpTqZEioOGgqYafc+9aQqbKh
         z8Sb39P41D2Fb9BtCQUgbYdnRV+Z/4NyDggog=
Received: by 10.150.225.18 with SMTP id x18mr1705294ybg.43.1289918842535;
        Tue, 16 Nov 2010 06:47:22 -0800 (PST)
Received: from localhost.localdomain ([211.201.183.198])
        by mx.google.com with ESMTPS id q41sm3919709ybk.1.2010.11.16.06.47.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 06:47:21 -0800 (PST)
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] MIPS: Define dummy MAX_DMA_CHANNELS to fix build failure
Date:   Tue, 16 Nov 2010 23:47:20 +0900
Message-Id: <1289918840-13434-1-git-send-email-namhyung@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28403
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
index 2d47da6..c601cff 100644
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
