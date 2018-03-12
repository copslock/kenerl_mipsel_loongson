Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:00:48 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:41891
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990404AbeCLV72Upu1f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:28 +0100
Received: by mail-qk0-x241.google.com with SMTP id s78so3695280qkl.8
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOJQHsZ2b5xYYZC1NATiF6gocznbM4tPnkFtO0NeYBQ=;
        b=QfbBHOuCJmnL5C6W7uI8h9ISGlJyaSHsZ54f10eeDJdxi3DVISL+zEnyP6/Zse/5qq
         L8leaJ4j/K8hDWymcu4LxJTjzwoupKC/dV59pbaHiPe6qGoakV0/d8i2s94q7A2Z2mTw
         NBRRg2syha/qoF3mpWYdywsDhaLGHgUo9Cq+E/jrClYH5iIOxkepE2MHxRGKm4JAQrbu
         HVMXPsgkCapwt4+w/ojelYiLc0RrDuPk2sTl72UVtwrSiolUot0DC/yO0vi4IFebn2bW
         Dzmd3x516SWAjTjAuBaZQ81dwNo0INx2o+5YkyTzvQCMzztHmB3prqg3gsjSd7KUyJBz
         WQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOJQHsZ2b5xYYZC1NATiF6gocznbM4tPnkFtO0NeYBQ=;
        b=jq1gHJGX2QmkYRVAp9g+5ZlSrlWmM2IyoESEtXttX56DYAp1VpomaQg8OG+SY7yMyx
         DVKr01XVrV4jUR652SrF53hKfonuq7oJ5xr6/hMPkxPsZuFhuHyUcrXf6HStJBF+nEq3
         q0NwbBNLSXFlEQf/3EBha8nFC4qWnRxqBV7puJORd9QjxoSjmzopgbneB964rsCxpncQ
         z/jaj0K248tYKaCS1R+tPReXFHTTjeNvvgJpO6TwkQksCVN1+Ljn4vCMTi3knvAPPVCc
         JJ4Iq3j20KJ49MTJYBgN7x2xXxnPrcgoIFPsMCPav1bR9uQ9Kx6r5PQhrputjNrScmLL
         rsjQ==
X-Gm-Message-State: AElRT7FUtYqRDlDhsQ9lCAswLrKvuGzRlenSAlrZCp6Z5v1H2/D34DIN
        j4uw00hB99b4FNlvpK4kdtSsD/FK
X-Google-Smtp-Source: AG47ELtK2W63RdlrGmbdd4pAmi6rYEkl/1Yctw98fiS87jnz3UBwMSc6SwRDl6fJZBu9w5cSUTyjkQ==
X-Received: by 10.55.96.193 with SMTP id u184mr12700494qkb.78.1520891962545;
        Mon, 12 Mar 2018 14:59:22 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:21 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 05/14] mmc: jz4740: Reset the device requesting the interrupt
Date:   Mon, 12 Mar 2018 18:55:45 -0300
Message-Id: <20180312215554.20770-6-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62936
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

From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

In case a bootloader leaves the device in a bad state,
requesting the interrupt before resetting results in a bad
interrupt loop.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
[Ezequiel: cleanup commit description]
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index b11f65077ce7..9f316d953b30 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1027,6 +1027,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	spin_lock_init(&host->lock);
 	host->irq_mask = 0xffff;
 
+	jz4740_mmc_reset(host);
+
 	ret = request_threaded_irq(host->irq, jz_mmc_irq, jz_mmc_irq_worker, 0,
 			dev_name(&pdev->dev), host);
 	if (ret) {
@@ -1034,7 +1036,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_gpios;
 	}
 
-	jz4740_mmc_reset(host);
 	jz4740_mmc_clock_disable(host);
 	timer_setup(&host->timeout_timer, jz4740_mmc_timeout, 0);
 
-- 
2.16.2
