Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 13:43:56 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:36756
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990394AbdIVLnscSa4A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Sep 2017 13:43:48 +0200
Received: by mail-pf0-x243.google.com with SMTP id f84so360117pfj.3;
        Fri, 22 Sep 2017 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k4VZ9ON+kJZef+l99Tz+k8XS24rFiMy9QCpPS0sJGyc=;
        b=VNNFoep4mYz5E1du5csmU3N5+bEPv9OR4bzzdKGS4a4+voXqi4nIsE7tjDrFX6DK+c
         aPsQw+hJ9CUPbF/rv3EF/pA+fNFmxo2FVBruC7fVXdKpi1gP6JKYShC3IMxuqGP2uLI+
         Q60Bc/8WXEh+J9Mn4Hb1EMPFw1fYYiBJe0fZzxVDTGBgR/+clFRqzWEIoyZN98TaU5lA
         0kQafEzldImdbPYJwvIZ5YplrxeSstRrcP9zLEHZIHMVoj0xayb9RJxOTnTXy/+Px2B5
         lfPyf2ihN0BVcGCk/1VgQzuwLsjGDSOBoowEagMUP+DPdVZF+HSR51v34Md4lss5kNFX
         nPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k4VZ9ON+kJZef+l99Tz+k8XS24rFiMy9QCpPS0sJGyc=;
        b=eR5ex3W+K1ihhkjjlPjzWg7X8AQxmlQJjJ7ZlKXTMEfGYyQ5e7bdZuFkXG95jNum4d
         /sf1dpiCMua/ddQUprGS3m7IN1gm7XcTxHzzUcQ2EsKo/YkOX3xfAhM0G5JifNbs9ilK
         1QgN5BG34PXc7l0LuprCHyZh1TqWPMIegmPwVDcdsWnsQIGN45/2b5l2yD0WFx2hYBbK
         c13OKxq7HrRKTZQNzLdTn5pckppzJF3Kpfc4HvdlpLQFX+Nnjxxf5Faw1AUzDcUA82GG
         Th18mfxpbNnh6SuLkxRUqvfCWtPJ63MLnKbVx/E+btoDLJFGeYTuCqn+lEhoXKcKaZXP
         Aqhg==
X-Gm-Message-State: AHPjjUj8qDgubdbigLgUjY5tGzmZFBTehCBdNRpB0BaRR0PajeuRtxnv
        53jCTI8jYr4b8S5EZDSxuzjfCbjj
X-Google-Smtp-Source: AOwi7QAuQ4cIoTD8MPiossCVYpYHmNTiPLOjC2wQuM0XioT6j/oFx1zez+lJ5lw4t+Ye4BgX2pbv5Q==
X-Received: by 10.84.233.204 with SMTP id m12mr8696446pln.305.1506080621458;
        Fri, 22 Sep 2017 04:43:41 -0700 (PDT)
Received: from localhost.localdomain ([103.42.74.194])
        by smtp.gmail.com with ESMTPSA id j14sm6783838pff.59.2017.09.22.04.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 04:43:40 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH] mips: use setup_timer() helper.
Date:   Fri, 22 Sep 2017 17:13:35 +0530
Message-Id: <1506080615-6137-1-git-send-email-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <allen.lkml@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: allen.lkml@gmail.com
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

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/mips/lasat/picvue_proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/lasat/picvue_proc.c b/arch/mips/lasat/picvue_proc.c
index dd292dc..a8103f6 100644
--- a/arch/mips/lasat/picvue_proc.c
+++ b/arch/mips/lasat/picvue_proc.c
@@ -197,8 +197,7 @@ static int __init pvc_proc_init(void)
 	if (proc_entry == NULL)
 		goto error;
 
-	init_timer(&timer);
-	timer.function = pvc_proc_timerfunc;
+	setup_timer(&timer, pvc_proc_timerfunc, 0UL);
 
 	return 0;
 error:
-- 
2.7.4
