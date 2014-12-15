Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:09:59 +0100 (CET)
Received: from mail-la0-f48.google.com ([209.85.215.48]:53962 "EHLO
        mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008844AbaLOSHGCh3S0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:07:06 +0100
Received: by mail-la0-f48.google.com with SMTP id gf13so9700908lab.21
        for <multiple recipients>; Mon, 15 Dec 2014 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hKo13j7PlKsMN49mA+elvbLsaT22alRvyvdKsLkqwCo=;
        b=D64WFlT7WiViSSHqeoxtmg0jikjgWNKCFZPrzOyGrJDRQMYBcMk/yEWYBCo2GDUr1c
         UyBIsf0bq1V0UIgRba+cv/fr6ZhJiXg401AoEEbQYW3lSNI3GBSithDyOxXFvEOVXVly
         +R7ErIA9aILz4bNfZ1VmsnJFIV/xNr2lud8fL9UCSBFkfKMkc1WHvDfsj7S8ZnDDtCra
         PhcfYztwTvIUXl0YAWWYy2kFvybaG0fKwK7mb8/19JoSY9yryVmOiYCVtVJcIXxeRjaC
         CiFxYMgaPvOWZomkNYGLxvrZIuAd7lgbMkdyOxEZgLtJjwI3xn0uxEbJTqjyMEh9J4Qa
         YQhg==
X-Received: by 10.112.170.7 with SMTP id ai7mr32152132lbc.67.1418666820834;
        Mon, 15 Dec 2014 10:07:00 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:07:00 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 14/14] MIPS: OCTEON: Handle OCTEON III in csrc-octeon.
Date:   Mon, 15 Dec 2014 21:03:20 +0300
Message-Id: <1418666603-15159-15-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
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

From: David Daney <david.daney@cavium.com>

The clock divisors are kept in different registers on OCTEON III.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index b752c4e..d270082 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -18,6 +18,7 @@
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
+#include <asm/octeon/cvmx-rst-defs.h>
 
 
 static u64 f;
@@ -39,11 +40,20 @@ void __init octeon_setup_delays(void)
 
 	if (current_cpu_type() == CPU_CAVIUM_OCTEON2) {
 		union cvmx_mio_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
 		rdiv = rst_boot.s.c_mul;	/* CPU clock */
 		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
 		f = (0x8000000000000000ull / sdiv) * 2;
+	} else if (current_cpu_type() == CPU_CAVIUM_OCTEON3) {
+		union cvmx_rst_boot rst_boot;
+
+		rst_boot.u64 = cvmx_read_csr(CVMX_RST_BOOT);
+		rdiv = rst_boot.s.c_mul;	/* CPU clock */
+		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
+		f = (0x8000000000000000ull / sdiv) * 2;
 	}
+
 }
 
 /*
-- 
2.1.3
