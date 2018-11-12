Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 18:02:15 +0100 (CET)
Received: from mail-wr1-x441.google.com ([IPv6:2a00:1450:4864:20::441]:42169
        "EHLO mail-wr1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992773AbeKLRBIg9pgA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2018 18:01:08 +0100
Received: by mail-wr1-x441.google.com with SMTP id u5-v6so4904634wrn.9
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2018 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gwiH4XNPeedEWQwSD3oXt7LL0JMYqmj9B9mAwTpqeMc=;
        b=Q3IQm3rPlBp8TVUba6mYr/QIDE+TfijiIEfa4+ZBane96TTiFIrUKDhxHMWPCDuVLv
         l2MywuL29YxDP8oV3ts1/MzfiZBL1kf6zUAmya5ecaZtDDoLJDG+rT0QSDF5uxjhYKzj
         nz2IBE6afxv+GpH5GZj4pOMtuAj+NYm+H4GrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gwiH4XNPeedEWQwSD3oXt7LL0JMYqmj9B9mAwTpqeMc=;
        b=BWmHXHbTelCPZ5pCCsOaGnxFrgOQSx6cvY4zx3ZIlrpVNliZIef+5MiTPwYL8jVMz0
         X2HnU3Ig/pC+M8fhTWHtHOA31e3UBLUpXHf5RCQQnXDThR3vDmE3G2dUXjr+LaFo+Ug5
         iYJEnoiS3OAHG+ObXVCmMzROzbj2WRTXHp3lytxneNTwKSgKiLsydSD7ucpGjLmj9StZ
         TujUdKO3ZN7g7naEnPjPN3GWUTg2VJYsHKEe+qjf/NewnZxTlkpJF6B6GF/s0+LAIxkV
         jCKcndqDdi8aNKM0Y3s/t2xrXd5tWCySH91QAWHqSK2FusMl4qLjbGzUOiaMDuQC5JW7
         kYxw==
X-Gm-Message-State: AGRZ1gKm92WYYJdnfOjbfbKb+JUNc8zIvHqv5s4bFXP7Rd/sHiuYpUos
        jgfYQ+Z6hVX/iYQDGHc6oICHCQ==
X-Google-Smtp-Source: AJdET5cB5OobM5l1tNop9qMQ0LpNiVUMrU5rxuz9gu1Sc6EPSxFaMv1OOhmFAIZ+eyAs0KpH0ZpLsw==
X-Received: by 2002:adf:b6a8:: with SMTP id j40-v6mr1614696wre.55.1542042067032;
        Mon, 12 Nov 2018 09:01:07 -0800 (PST)
Received: from max-pc.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id u13-v6sm11835344wrn.11.2018.11.12.09.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:01:06 -0800 (PST)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Maksym Kokhan <maksym.kokhan@globallogic.com>
Subject: [PATCH v2 1/2] mips: delete duplicated BUILTIN_DTB and LIBFDT configs
Date:   Mon, 12 Nov 2018 19:00:58 +0200
Message-Id: <20181112170059.7199-1-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <maksym.kokhan@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksym.kokhan@globallogic.com
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

CONFIG_BUILTIN_DTB and CONFIG_LIBFDT selection is duplicated
in menu "Machine selection" under MIPS_MALTA.

Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
---
 arch/mips/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..fe4c28275271 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -539,8 +539,6 @@ config MIPS_MALTA
 	select USE_OF
 	select LIBFDT
 	select ZONE_DMA32 if 64BIT
-	select BUILTIN_DTB
-	select LIBFDT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
-- 
2.19.1
