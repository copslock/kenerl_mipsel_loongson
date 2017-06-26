Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 10:01:54 +0200 (CEST)
Received: from mail-pf0-x22b.google.com ([IPv6:2607:f8b0:400e:c00::22b]:33275
        "EHLO mail-pf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993420AbdFZIBp6ze2Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2017 10:01:45 +0200
Received: by mail-pf0-x22b.google.com with SMTP id e7so51445601pfk.0
        for <linux-mips@linux-mips.org>; Mon, 26 Jun 2017 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ncm/bd4hE5HMt4rr46HJNlF/RefUPQ/Rf7IHTB1BPls=;
        b=GyNaXOdVRQR1a/yWN+Mjx8VC02KdOoK7c5quH/0Co56iBdS3WK8A2UqLL15t4JuyIJ
         cWLRdIXBacBReLDYbs0khP6wsTGc2Fy+2bbUoweycAM5/eR+WhTWndpSkrzKwaFU3kVi
         u1OX+GvXsEX5iDn2pfB2Hf4kD/4ZQ2l6SCSiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ncm/bd4hE5HMt4rr46HJNlF/RefUPQ/Rf7IHTB1BPls=;
        b=SoUcgTsgmecNS6FtoV2CoGeiOht9E2EMRK4rKsOFK9LiFZKFXQ3J46iOTZaWeguQNM
         RkttHGlnU7WcDSmpE92yc8UHmJZs7r2N+dEVjU8cmTVLjcaBn5iWMNjrvvy1C0Ya6GbF
         gpzQ5W85IhgZYW7z3b3iZIUszd83VR6t/bwaJSZAp0d6tI39EHVwNYI1WnuKhRhwgp4H
         3giwRMCT5HgJXzhyNPh91mk8atOuuaRscqbp1gCelWBh7mwLDP0XUoT0FmvY/jhSMM0U
         vU8TB5ivL7svzkDYj6C6lGm4KOfHNosOSf7eCxbXi7i5sqNtLhEiM6gwW6wYlLMCmyi2
         fIbQ==
X-Gm-Message-State: AKS2vOxp0WH+B7OheRfeRDMMINx9Qq6f0MWJ0wtbE9bV9hqm45AghWBU
        5popOKt4da8xmSXw
X-Received: by 10.98.28.71 with SMTP id c68mr20271040pfc.116.1498464099665;
        Mon, 26 Jun 2017 01:01:39 -0700 (PDT)
Received: from localhost.localdomain ([106.51.139.251])
        by smtp.gmail.com with ESMTPSA id 67sm23673640pfa.83.2017.06.26.01.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 01:01:38 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>, Tobias Wolf <dev-NTEO@vplace.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.9 1/7] of: Add check to of_scan_flat_dt() before accessing initial_boot_params
Date:   Mon, 26 Jun 2017 13:31:25 +0530
Message-Id: <1498464091-26753-2-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498464091-26753-1-git-send-email-amit.pundir@linaro.org>
References: <1498464091-26753-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58796
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

commit 3ec754410cb3e931a6c4920b1a150f21a94a2bf4 upstream.

An empty __dtb_start to __dtb_end section might result in
initial_boot_params being null for arch/mips/ralink. This showed that the
boot process hangs indefinitely in of_scan_flat_dt().

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14605/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/of/fdt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6a43fd3d0576..502f5547a1f2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -741,9 +741,12 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
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
