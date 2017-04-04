Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 08:18:29 +0200 (CEST)
Received: from mail-pg0-x236.google.com ([IPv6:2607:f8b0:400e:c05::236]:33501
        "EHLO mail-pg0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbdDDGSXIOuPU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 08:18:23 +0200
Received: by mail-pg0-x236.google.com with SMTP id x125so142560297pgb.0
        for <linux-mips@linux-mips.org>; Mon, 03 Apr 2017 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wPWiBRR2YfGVDa/mBMprL/d2J77eMvXTr5UMN/e2Iro=;
        b=iFMDZRA+Z6za6S0L0YkQ1vndkiKjdvR5/6N7L0QJQpnWQ2M8wAnfUzMgOhiK3ai2Ap
         Gvyncxbyfgjnp7c3GQnB/v6pwl8iPLVyi7gE2xCeNVCnqeUuD8hx9TRJKXLBcpUmul+q
         7bKF8HLNdWOHwMOOQ9fZcYWGLaxLMzgU1fCLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wPWiBRR2YfGVDa/mBMprL/d2J77eMvXTr5UMN/e2Iro=;
        b=qm1j8hYza9ajPYY9tYycxFpdoRfuBH89AaCIl9B43fbwsrB/eoEgA0rIrJEKLe/ITh
         EC4jmoX0ibb3gwtDbrGqvXWt8uM/D2EoXjJoD41rVRzuWkgFwhBgzGkX0VJRaA6ItMmW
         KZXo+4bZ5B0J/QKEoE2vuJ/AsgUInsXXl/5pq3pwiT7o84gTvPSo1LtgkE3Nc0zefL1M
         ft7Hfwki2S5ygBCvCPPWz1NQT6Pk049kUEtbZ+nSO3Kz22BN7yJLW4nI0/dpZDryDjEf
         UJMQFhX2DZ9abXRBUJfr4qoYI2o5cx8oZerAqHesfL25F1wQUxnuetWeWUnUFyvaa8jH
         kkjg==
X-Gm-Message-State: AFeK/H3qIeY/4zKLecQmso8eXoBmS1g3PshrCd33Ob1lMNZaOf82Yrh4UzgOkHS1XZZUrtnC
X-Received: by 10.84.238.132 with SMTP id v4mr26818028plk.101.1491286697316;
        Mon, 03 Apr 2017 23:18:17 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id m20sm29331500pgd.32.2017.04.03.23.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Apr 2017 23:18:16 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, Tobias Wolf <dev-NTEO@vplace.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 22/33] of: Add check to of_scan_flat_dt() before accessing initial_boot_params
Date:   Tue,  4 Apr 2017 11:48:01 +0530
Message-Id: <1491286688-31314-3-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491286688-31314-1-git-send-email-amit.pundir@linaro.org>
References: <1491286688-31314-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Tobias Wolf <dev-NTEO@vplace.de>

An empty __dtb_start to __dtb_end section might result in
initial_boot_params being null for arch/mips/ralink. This showed that the
boot process hangs indefinitely in of_scan_flat_dt().

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14605/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
(cherry picked from commit 3ec754410cb3e931a6c4920b1a150f21a94a2bf4)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/of/fdt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index c89d5d2..6c07f2c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -738,9 +738,12 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 	const char *pathp;
 	int offset, rc = 0, depth = -1;
 
-        for (offset = fdt_next_node(blob, -1, &depth);
-             offset >= 0 && depth >= 0 && !rc;
-             offset = fdt_next_node(blob, offset, &depth)) {
+	if (!blob)
+		return 0;
+
+	for (offset = fdt_next_node(blob, -1, &depth);
+	     offset >= 0 && depth >= 0 && !rc;
+	     offset = fdt_next_node(blob, offset, &depth)) {
 
 		pathp = fdt_get_name(blob, offset, NULL);
 		if (*pathp == '/')
-- 
2.7.4
