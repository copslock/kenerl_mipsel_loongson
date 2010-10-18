Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 05:55:41 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:62914 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490995Ab0JRDzg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 05:55:36 +0200
Received: by gyf1 with SMTP id 1so189726gyf.36
        for <multiple recipients>; Sun, 17 Oct 2010 20:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=JNcw9o1Dqj91UQgPSU3f91WfPNfMfuIcvufBp0ppBjk=;
        b=JcSGQAl7yF39ifkcrzaKZ8I9jMvnpznUqhDTUVYBSMmerVPwczOUolXNwo3s7GIXqO
         oK1v9K0Fz008ZhBLjwka1xsbyQxqbdtFvGGz8DtEZELTJaxLJPu9jMyCjqqgp9LqV2CA
         VTaic9H0MEFUDMlpP4iXxxk9yLUE51CoonpD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WYkVasn9n0Xw3Syjl1Rckz090JryM7emjRY9MTXpsS1wpfwxQvFDiyRUV3n6bwOhE3
         9aq0G+J6ZIHe/R/Q5jXWuak3Ti4AimUmo7cTty01MTRX+MAMoxJC5l0wt/ZhePYNMDAe
         fnU4VQQn8hdfXmpeekjHOb8qRjpfc52VH6OGU=
Received: by 10.150.91.17 with SMTP id o17mr6139079ybb.21.1287374127943;
        Sun, 17 Oct 2010 20:55:27 -0700 (PDT)
Received: from localhost.localdomain ([211.201.183.198])
        by mx.google.com with ESMTPS id v12sm6993277ybk.11.2010.10.17.20.55.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 20:55:27 -0700 (PDT)
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Add ISA_DMA_API config item
Date:   Mon, 18 Oct 2010 12:55:21 +0900
Message-Id: <1287374121-7289-1-git-send-email-namhyung@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

Add ISA_DMA_API config item and select it when GENERIC_ISA_DMA enabled.
This fixes build failure on allmodconfig like following:

  CC      sound/isa/es18xx.o
sound/isa/es18xx.c: In function 'snd_es18xx_playback1_prepare':
sound/isa/es18xx.c:501:9: error: implicit declaration of function 'snd_dma_program'
sound/isa/es18xx.c: In function 'snd_es18xx_playback_pointer':
sound/isa/es18xx.c:818:3: error: implicit declaration of function 'snd_dma_pointer'
make[3]: *** [sound/isa/es18xx.o] Error 1
make[2]: *** [sound/isa/es18xx.o] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 arch/mips/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5526faa..4c9f402 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -881,11 +881,15 @@ config NO_IOPORT
 config GENERIC_ISA_DMA
 	bool
 	select ZONE_DMA if GENERIC_ISA_DMA_SUPPORT_BROKEN=n
+	select ISA_DMA_API
 
 config GENERIC_ISA_DMA_SUPPORT_BROKEN
 	bool
 	select GENERIC_ISA_DMA
 
+config ISA_DMA_API
+	bool
+
 config GENERIC_GPIO
 	bool
 
-- 
1.7.0.4
