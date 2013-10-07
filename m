Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 18:30:55 +0200 (CEST)
Received: from mail-ye0-f176.google.com ([209.85.213.176]:56752 "EHLO
        mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868740Ab3JGQaucbj-1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Oct 2013 18:30:50 +0200
Received: by mail-ye0-f176.google.com with SMTP id m4so1624291yen.21
        for <multiple recipients>; Mon, 07 Oct 2013 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gyIgkJwwxWVfFYN/gKw6ghVFVCpOWGOzK+wiT/hb/J8=;
        b=hFhNtJuiMGbjFaOFUE/i4YMOpaMsnNZ6e2ZUANeqMxPg/7+oV1bNrGSwSJvUSZvFUK
         Vet2BuYeavJWgidSwErztjZ1XABNI95RcR6N7tsSmayU8A10LOugnMfB/b8L/6vDCnid
         q7kbE/oIHGoMAkXOVWu4dJkt4U9acYjowmTU9KpTQUIBGsZ+y73NJNSL22nZVqBs6YTr
         vu+SlBxZLqADVJRVdyl5uUx4Og6n8FyZjnHw+pjeOP7EFvm5Ef2Fs6L0jqdAVInCMAQz
         bhE6ri8zSadFvyav82FdEZpAjhNeYfcg3BuX8td4z1OvHyryUCyvCYPV3FUP7U6irz6c
         AjeQ==
X-Received: by 10.236.143.10 with SMTP id k10mr1015843yhj.116.1381163444521;
        Mon, 07 Oct 2013 09:30:44 -0700 (PDT)
Received: from rob-laptop.calxeda.com ([173.226.190.126])
        by mx.google.com with ESMTPSA id d40sm44620829yhi.10.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 09:30:43 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 29/29] mips: use common of_flat_dt_get_machine_name
Date:   Mon,  7 Oct 2013 11:29:37 -0500
Message-Id: <1381163377-21044-30-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1381163377-21044-1-git-send-email-robherring2@gmail.com>
References: <1381163377-21044-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38231
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
Acked-by: John Crispin <blogic@openwrt.org>
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
