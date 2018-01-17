Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 19:58:52 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:35871
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994685AbeAQS6qQlXJu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 19:58:46 +0100
Received: by mail-wm0-x244.google.com with SMTP id f3so17932932wmc.1;
        Wed, 17 Jan 2018 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xsosCAjSkK54Qmf+zrTWComgbQmEpaazDnZmdspYUf0=;
        b=AtdgD4GNd+JbGZawHdWtMEdD7hCZRM6mASF/aoz5AEw6YsN2rFPDAuEszGeNEOm9q3
         PEOk83fIJ5ov7f5QAeEy03XMJHJf8u98GQAa3h2ENs/lPmiF3bsAj33ja3ACPhr9erl+
         YPM0u+hH+Kic9940euQfS/ZIjpySXy6gkrdL/XV+mYuclshfQ60t7/eYcwSEiGWMUfyp
         FC/tcC1+UNFTIIzS4trLe7en6rgKw9VtQ+d7M2n5pCzd7FEJxFXSebwUpd/CSeqU6gP7
         cVPm0Npfg5frvSVVisvU2JVBbQO1Tme+zcCl8qIIXjOBacfq/LYZXZQ6r4XHrWcko/yB
         Y4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xsosCAjSkK54Qmf+zrTWComgbQmEpaazDnZmdspYUf0=;
        b=PUPZfAkJ1pboI19unPWsGGd6+Rn/Qef1SsiWfU0EtCmJXgtdIR18qJJfkON/UZ5aJj
         309v5g4JrCq3SO4t+9CAFQgtKitxuDyeCalFKjaf1QiF03w/Dn3/w7taKYZRpR1Kre/O
         t31xrNqCLw9g25Sp8d9mV0L7zlaTAegDAIoTYtrqCCO7rZjz1XY87pUDuDbtjSdrq9/n
         FAHNjlidWT3zSgkKd1CZJ2O42zUXdnECA9blQzUU3YenTF7hoxvR4q6TQgMJJuN/1QuV
         TjHS4u+dNqeBSSR9G4Pbj1xN+5LiDT7lGAhkhvQnSz63QSRNS5QGXGlnc4WZ1s2NXiyo
         ggKg==
X-Gm-Message-State: AKwxytfpP3/hqS7t8foNFhFDgG9tPMcePmDx5bcSu7QlViW2pw3SV9uJ
        USSxsjP7eLxb4u6ejcTe9d14bjU3
X-Google-Smtp-Source: ACJfBosRMSJhLxjhhLazkTIyaixkrIn8vcS/p16Lt4ZaNhLWwkwF+hZMHlKMEm92K+DQR1mwbmmGZA==
X-Received: by 10.28.32.15 with SMTP id g15mr2745000wmg.22.1516215520722;
        Wed, 17 Jan 2018 10:58:40 -0800 (PST)
Received: from Red.local (LFbn-MAR-1-494-174.w2-15.abo.wanadoo.fr. [2.15.82.174])
        by smtp.googlemail.com with ESMTPSA id p10sm9643330wrh.61.2018.01.17.10.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2018 10:58:40 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] MIPS: fix typo BIG_ENDIAN to CPU_BIG_ENDIAN
Date:   Wed, 17 Jan 2018 19:56:38 +0100
Message-Id: <20180117185638.22426-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.13.6
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clabbe.montjoie@gmail.com
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

MIPS_GENERIC select some options with condition on BIG_ENDIAN which do
not exists.
Replace BIG_ENDIAN by CPU_BIG_ENDIAN which is the correct kconfig name.
Note that BMIP_GENERIC do the same which confirm that this patch is
needed.

Fixes: eed0eabd12ef0 ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/mips/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 13c6e5cb6055..504e78ff0b00 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -119,12 +119,12 @@ config MIPS_GENERIC
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_SUPPORTS_SMARTMIPS
-	select USB_EHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_EHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
-	select USB_UHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_UHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
 	help
 	  Select this to build a kernel which aims to support multiple boards,
-- 
2.13.6
