Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 01:10:19 +0200 (CEST)
Received: from mail-oa0-f41.google.com ([209.85.219.41]:55091 "EHLO
        mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822995Ab3IPXKDsCIjk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Sep 2013 01:10:03 +0200
Received: by mail-oa0-f41.google.com with SMTP id i4so616361oah.14
        for <multiple recipients>; Mon, 16 Sep 2013 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6FdvWQHxDaFHqBFGBAmSJiF1t9+VyRuzJo0cSgAKs2s=;
        b=g1D7OfYBVKtosOGj4VN0F2Oezv7KzDGR0wj0yajfL5GKINBei9752R/k/MLTt5oXDA
         51SX806V4u1FJ1MMBgvIKBrwugRLule7MCFtaDVMY8UGFvpP1QjgPKb9qZ9JwJBdzDcg
         w56ckyMS0gKn0z7Z1+PDsCf7b6CBEMuR/rMwV/hiURclH3slb8SrzEo6rDXIWfXD6cvQ
         D8IKe7z0vEtB1T9MpObRwCh4eO05VSJ8bJ2WzYFuJwBhqVs5N0NTrlObx9myg+5n2tdV
         V9bLPSNL6674Sih3mLCGFN+BPhhpLiW0PPiDqGInnaen6AFrMRbAsbMeH+BaBgGkWbm1
         U2kg==
X-Received: by 10.182.84.132 with SMTP id z4mr1994148oby.49.1379372997640;
        Mon, 16 Sep 2013 16:09:57 -0700 (PDT)
Received: from rob-laptop.calxeda.com ([173.226.190.126])
        by mx.google.com with ESMTPSA id s14sm34574615oeo.1.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Sep 2013 16:09:57 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 28/28] mips: use common of_flat_dt_get_machine_name
Date:   Mon, 16 Sep 2013 18:09:24 -0500
Message-Id: <1379372965-22359-29-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
References: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

From: Rob Herring <rob.herring@calxeda.com>

Convert mips to use the common of_flat_dt_get_machine_name function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/prom.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 0b2485f..3c3b0df 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -47,24 +47,11 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 	return __alloc_bootmem(size, align, __pa(MAX_DMA_ADDRESS));
 }
 
-int __init early_init_dt_scan_model(unsigned long node,	const char *uname,
-				    int depth, void *data)
-{
-	if (!depth) {
-		char *model = of_get_flat_dt_prop(node, "model", NULL);
-
-		if (model)
-			mips_set_machine_name(model);
-	}
-	return 0;
-}
-
 void __init __dt_setup_arch(struct boot_param_header *bph)
 {
 	if (!early_init_dt_scan(bph))
 		return;
 
-	/* try to load the mips machine name */
-	of_scan_flat_dt(early_init_dt_scan_model, NULL);
+	mips_set_machine_name(of_flat_dt_get_machine_name());
 }
 #endif
-- 
1.8.1.2
