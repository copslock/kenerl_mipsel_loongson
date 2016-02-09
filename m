Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 21:57:14 +0100 (CET)
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36074 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012419AbcBIU4MFAJpb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 21:56:12 +0100
Received: by mail-pf0-f173.google.com with SMTP id e127so37793789pfe.3;
        Tue, 09 Feb 2016 12:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4AY0aTwuux2T/Vh5/KSQUnypyFYhkqUh+9NKWGheTWA=;
        b=Cz+gLXKLzg45NyCMak+JR7Nq14bEYIBgxX6nOJ5z/yg9mm6/Ym1VNcL2l7eoySMFbJ
         WqeQJLQkdk4DL11e2cxYGHMHKZrCxwnmbomJ0sctSuQ/rXjpwBanft/h5iI9GBmfnK/v
         hcx7RzwilibaXjA7ocQkTUdcMnPBhpHZM35O0X/Gf01kQEq7SiikFXfV194aKGswx5k2
         fP5FbcAncyP/fkcNAnEr4bj2/GTW8I8ILN7pYlEVDax9jNkG3s+KSz8UxGZ8Cr6uGZCj
         VjpZLOOl66CsUmqSgSeMAYnnWsUeUQ9mWAK89RiwqjkRKAUnsOdFPzcP/atD/riWe4Ul
         UYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4AY0aTwuux2T/Vh5/KSQUnypyFYhkqUh+9NKWGheTWA=;
        b=VkoHgdpVORMDCz/Bua2pgILk4Z4m7P5QkgQjoKsXpXbq8fdesvYf7cRBHrGmfi1eCw
         sK+yfSHaNAWG+6ZjmKqLKOrx4YK9Z/mur0pk330KSG4AgM0DdM1DZMd4VEyr4vLkBu50
         5ORvBZJMzydlcRb5SfP9JXsJKdtgE6OWXGpU7CvQgI9ZFgkof0Ny+ZCjuTXwU7vW3Qrk
         CaQ+N5IqP6SVAsQ8jCZ92OvX4+q8M7Wvu9foEJ9Y0thgGqUhJQ0Dxgz1Y+NtPjyf8Lru
         xc3kqLF+Ct9CrZCQBowIZwSH5ntFhXTQp2uGNmQPzQXoQ8a3hfzZ/R+df1x+9vTpl5M0
         x59Q==
X-Gm-Message-State: AG10YORDAXoR8O5K1oYaDjlO/YGm1GhY4dCJai7cwqhIEOmb9vFPCARkGyb4cWxF5pNVsw==
X-Received: by 10.98.33.77 with SMTP id h74mr52987249pfh.157.1455051366420;
        Tue, 09 Feb 2016 12:56:06 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id n4sm52684059pfi.3.2016.02.09.12.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 12:56:05 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4/6] MIPS: Move RIXI exception enabling after vendor-specific cpu_probe
Date:   Tue,  9 Feb 2016 12:55:52 -0800
Message-Id: <1455051354-6225-5-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Some processors may not have the RIXI bit advertised in the Config3 register,
not being a MIPS32R2 or R6 core, yet, they might be supporting it through a
different way, which is overriden during vendor-specific cpu_probe().

Move the RIXI exceptions enabling after the vendor-specific cpu_probe()
function has had a change to run and override the current CPU's options with
MIPS_CPU_RIXI.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/cpu-probe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b713b9f8..a2df0357b453 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -828,15 +828,6 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 	mips_probe_watch_registers(c);
 
-	if (cpu_has_rixi) {
-		/* Enable the RIXI exceptions */
-		set_c0_pagegrain(PG_IEC);
-		back_to_back_c0_hazard();
-		/* Verify the IEC bit is set */
-		if (read_c0_pagegrain() & PG_IEC)
-			c->options |= MIPS_CPU_RIXIEX;
-	}
-
 #ifndef CONFIG_MIPS_CPS
 	if (cpu_has_mips_r2_r6) {
 		c->core = get_ebase_cpunum();
@@ -1660,6 +1651,15 @@ void cpu_probe(void)
 	 */
 	BUG_ON(current_cpu_type() != c->cputype);
 
+	if (cpu_has_rixi) {
+		/* Enable the RIXI exceptions */
+		set_c0_pagegrain(PG_IEC);
+		back_to_back_c0_hazard();
+		/* Verify the IEC bit is set */
+		if (read_c0_pagegrain() & PG_IEC)
+			c->options |= MIPS_CPU_RIXIEX;
+	}
+
 	if (mips_fpu_disabled)
 		c->options &= ~MIPS_CPU_FPU;
 
-- 
2.1.0
