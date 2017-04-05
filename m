Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2017 12:33:34 +0200 (CEST)
Received: from mail-pf0-x22a.google.com ([IPv6:2607:f8b0:400e:c00::22a]:33888
        "EHLO mail-pf0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993457AbdDEKdSx4tJL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Apr 2017 12:33:18 +0200
Received: by mail-pf0-x22a.google.com with SMTP id 197so5599078pfv.1
        for <linux-mips@linux-mips.org>; Wed, 05 Apr 2017 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wPWiBRR2YfGVDa/mBMprL/d2J77eMvXTr5UMN/e2Iro=;
        b=TmmbxGzcrsJoYWmRPvJk6BSAqRlNMPllF3K3mwxtDK2HtRqw/VOmHqRHj7sIhu/QDU
         XqlDTYIbSj0D8AUtjX5GTLQak5aqcRndPGY7802KqSeRrMHdbGl/v0p4meR8MO489Pr6
         a7aqx8O5CpTapoc+NPrFA67XgOUu9JHRLuiVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wPWiBRR2YfGVDa/mBMprL/d2J77eMvXTr5UMN/e2Iro=;
        b=Uj7xk/lEJO5exBmk/dFBFKxc3eW+kdno+QkWvJ17ZJ1wVGC6CRh8mP1M1aFGdaD270
         PmPl+o+9uQDMyrGA8L3GLS6Hkiv+3F1Tj3rF6TlozRZOGf67O5ja7rDxkum4ifzOZUEa
         TKosVN/4zpDbzz7yo3ijCY/oCX85WzBqJlWPh60khtqa2PkfLAKtWJBGzNWQ5esPpZMF
         poSoFqju1G6XCx29ERU/wpPo1Hy5t02u4ca6RcXe58Pzi61byEtB8hSvs+E46CcFNRrr
         F1fyxrDbInVLqNiuApOdWQintvbdNHXVSbpAwWVqDXvsVIbXXmWxFN2pCxqF/MDyL6U9
         4IEQ==
X-Gm-Message-State: AFeK/H18bWQZY5V5RFBuNiLxD9Br/ogYAyC+8i3YvRmH+/vL3iQnBbCAmdwMqJ7Acclilqe7
X-Received: by 10.84.224.198 with SMTP id k6mr34713026pln.15.1491388393080;
        Wed, 05 Apr 2017 03:33:13 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id a62sm36732075pgc.60.2017.04.05.03.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 03:33:12 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tobias Wolf <dev-NTEO@vplace.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 for-4.9 21/32] of: Add check to of_scan_flat_dt() before accessing initial_boot_params
Date:   Wed,  5 Apr 2017 16:02:13 +0530
Message-Id: <1491388344-13521-22-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491388344-13521-1-git-send-email-amit.pundir@linaro.org>
References: <1491388344-13521-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57566
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
