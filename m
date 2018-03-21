Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:34:50 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:45488
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994765AbeCUT3FU61WZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:29:05 +0100
Received: by mail-qt0-x243.google.com with SMTP id f8so6487332qtg.12
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LpeJNDIrxTNXum12i6k3vaUqafcdTuwV4bnLteYB6Iw=;
        b=gW2jsRQnitzfq1qRDFFEcg4GMNJi811qb4lR12F9LJU24MBEqtKEpedkS4YCYEuLsm
         T7Dm+o41zulPhLwLuY3+NEqsXXLpCA82ijZEpppDJsnjKc1eClujjewWshmRnO37/uAL
         Smse/FlC6hpqrVMUACK+s/kQ48/+YC2XVTC46Zkc9QWktZH9vbFXQxrzv1JdICZUaQ2H
         dfin5rTtgpQswKfKwGQ+043zOwsS0dVDT9AvZSaPmYGli7/IpChhG6ttrMSWUE47Ha6r
         ceBREhMh5FbtNET3SMhaT0JEe60drBXTXWVqlbOBUUGNpjFJRzv+YQbLrVqJfmoY4oyJ
         i6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LpeJNDIrxTNXum12i6k3vaUqafcdTuwV4bnLteYB6Iw=;
        b=ntQzBVZ0V5edH49pq2x3KibBq9dHAeztYPaqTkiGmZWLdZgjQWMcCCEbsLtYUh0fU3
         GmkrMFF+JX9Y9TVpeP88/aOexbZvKwl7tWUHPB/WzawzV+37tk3eLCLreuJ7tAqnpL/u
         KXdzqk3lcMSTdxLk+1P5cJJSdrkajaLHUJWRRVB1gH39v4PzC93xGjqYFt68CggBcV3x
         86XvLq9p4gI7qAfCKawty/lp6bvKax3uc2YWOwUtYCcs6JnBfF79v2GNfOcoUUrBjTQT
         6fH59XmQDKQMRbEchv88WJxZwR/mNtAcqEU7GUfP3PJCFlHgOss4vx961DM8IL/4caxj
         iCzQ==
X-Gm-Message-State: AElRT7HjN3pG/bntgnRrPl559L5jRG+RM+XQyONHvR8xy2ih69IKQjzd
        eXTEH+OQpsKS585tEfLEL2rNGQ==
X-Google-Smtp-Source: AG47ELuKIjfdQolcvIVDwN++wRrDxFmGEWbbW16eXrI5EyNtMjAJySE33IK1hTlDLdanIqMDE10R7Q==
X-Received: by 10.237.50.37 with SMTP id y34mr32042738qtd.82.1521660539247;
        Wed, 21 Mar 2018 12:28:59 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:28:58 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 08/14] mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
Date:   Wed, 21 Mar 2018 16:27:35 -0300
Message-Id: <20180321192741.25872-9-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

From: Alex Smith <alex.smith@imgtec.com>

The maximum clock rate can be overridden by DT. The clock rate should
be set to the DT-specified value rather than the constant JZ_MMC_CLK_RATE
when this is done. If the maximum clock rate is not set by DT then
mmc->f_max will be set to JZ_MMC_CLK_RATE.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 03757cc55f52..aa635b458d2c 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -825,7 +825,7 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
 	int real_rate;
 
 	jz4740_mmc_clock_disable(host);
-	clk_set_rate(host->clk, JZ_MMC_CLK_RATE);
+	clk_set_rate(host->clk, host->mmc->f_max);
 
 	real_rate = clk_get_rate(host->clk);
 
-- 
2.16.2
