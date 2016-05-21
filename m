Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:06:50 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34376 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031005AbcEUMCVpeJhI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:02:21 +0200
Received: by mail-lf0-f65.google.com with SMTP id 65so26039lfq.1;
        Sat, 21 May 2016 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=XBjG9ZOWP9kAD/ya0HuQYW3fVZjxgdI5DAdZZdp6mJM=;
        b=kpX/0Gcxeer4025t6UzWDC/nljrrHR4GKQpsbehi5+mK8qS7KfM38D5hcuZXP/gUsC
         6U9rPX+yJp8Fr7WmlnjOKQGfcL5c1bEinZRBippOmfUJD7s1oq/hUnqFwNsKY5P0YLkF
         0RP90GVHaMwoT2T067Jh/5cOs7cxX96EpajlzoY03gf+o6oiBVWznqA2i2yOCvbxeq4O
         sMBtmh28pvmETvyRcDEcffZKz5mGr3VSK3BzmsrLDQAWBW6XCNG3smDxFJyvMY6g5p+r
         m9bFbH7Tcx8cE2GgU/vWacTPal3hZyt/3mTIxsiMAWfO0xCpK2EHxlmG8oUTJBU4/sFv
         n3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=XBjG9ZOWP9kAD/ya0HuQYW3fVZjxgdI5DAdZZdp6mJM=;
        b=b5/d7bABxcSXLe/d7d/mDZ5h4qmc78ISoqXhG+nryPyAz73AwD9oEF94zH5E+15qcy
         AX/6UmumYBLPAermHYCc7NvQaj27w8yY1Q3aGZiAQul77A8y7GqeB/A1glNhFlYMezha
         +zZsAZTayu/Wbi3jS1edQGf8LJCAZsJeLkJOT5T4LH4vx5pzbm9koLYmkzJkf+QWWNj9
         Mi5a3iL4nMZbe4RCtF86moIBuwLsoTDf8VyyDlgLmXpoWOzHNvNIHktBHyADQWpwCTIE
         2Z9aJnmUMp407EuhOa6oppQFK6ij12q6geXZg5ljjPIMsj5P0iRG2iUv+H05O+gjJMXM
         2R0Q==
X-Gm-Message-State: AOPr4FWXsQrUsUZoQb+la5kLSygFCH2001FF0NRGPhN2mVu79ipNTpDlMmNhQ30opxXh6A==
X-Received: by 10.25.216.74 with SMTP id p71mr2532542lfg.52.1463832136420;
        Sat, 21 May 2016 05:02:16 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id 63sm1388340lfx.39.2016.05.21.05.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:02:15 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0200/1529] Fix typo
Date:   Sat, 21 May 2016 14:02:12 +0200
Message-Id: <20160521120212.10350-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/sgi-ip27/ip27-hubio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip27/ip27-hubio.c b/arch/mips/sgi-ip27/ip27-hubio.c
index 328ceb3..2abe016 100644
--- a/arch/mips/sgi-ip27/ip27-hubio.c
+++ b/arch/mips/sgi-ip27/ip27-hubio.c
@@ -105,7 +105,7 @@ static void hub_setup_prb(nasid_t nasid, int prbnum, int credits)
 	prb.iprb_ff = force_fire_and_forget ? 1 : 0;
 
 	/*
-	 * Set the appropriate number of PIO cresits for the widget.
+	 * Set the appropriate number of PIO credits for the widget.
 	 */
 	prb.iprb_xtalkctr = credits;
 
-- 
2.8.2.534.g1f66975
