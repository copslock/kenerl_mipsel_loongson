Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 21:57:33 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35326 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012423AbcBIU4NklVvb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 21:56:13 +0100
Received: by mail-pa0-f52.google.com with SMTP id ho8so96921721pac.2;
        Tue, 09 Feb 2016 12:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3NdSPh/YCEpCPhUOPTY24DYI/UhkvEpDa5pK/j4F7I=;
        b=uRKRRyh3rE9CdH/6N8oXzEFFbUoGPWf9hJp3HqJINa+hSjxkeIoPpjcO9pUrgauQv9
         wHySMussRPYA3IE94dhjRSOJu/PItnbh/iEyptRE+lWYP4j72FrHeMFwecqlkTEW0eSe
         CO17XiC8U0in6VsWNUTBn43ibyld8FfJudmMPmtjot50TfkM4QYeYoTQpnM649nK1zvf
         fwfGbxmG9+UquV9ANFgcpsTnx+UX1glV9NZscfr1blxLm3CP2P2ODZM4z53h7rn7ClKk
         +ucuV4fidp3eYJmXvgOme4YouHpoVFR2jf6ehcB4xxDhg5yH9TUwIB+vMlKRFwvGNnmo
         pD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3NdSPh/YCEpCPhUOPTY24DYI/UhkvEpDa5pK/j4F7I=;
        b=iQlXNukoZKVeOD8o72WXHcv4/7n8R4IVjXrcepqF2U7x1fDvoYcZEgVK//ynHocchj
         TK/9U1TaklnKlWvjNcon7dJjR5GNWKdu6ir0BL+l50w5Ss0G8OmS5GQ1PZjAYLbJXEH5
         yd2mZRdig5w2vtC7QaMZJkxelQ8KR+gujMGDH0XxLntM98c30BtRnqaQMno/BQFENU5A
         h6VQ6iq1TqcHHG43JBqPb26DDniNXSXH0WvnCjQave6+cWhG6cGQXZgKxg72KsOU1y6T
         3MWTJoL2P1FK4583e/+SQPUv484Ch7HqbGfWNcmaUui5wjIeLhtRABBvZAbzZM3H6c8z
         0EVQ==
X-Gm-Message-State: AG10YOSPm7XMoOYhRo2TD9FxHjbBumRXHDQ7XAQt3HR+IyMEFo1xStQgRh9b/k3zQJ/dzA==
X-Received: by 10.66.159.161 with SMTP id xd1mr42162781pab.104.1455051367576;
        Tue, 09 Feb 2016 12:56:07 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id n4sm52684059pfi.3.2016.02.09.12.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 12:56:07 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 5/6] MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI
Date:   Tue,  9 Feb 2016 12:55:53 -0800
Message-Id: <1455051354-6225-6-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51922
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

Make BMIPS4380 and BMIPS5000 advertise support for RIXI through
cpu_probe_broadcom(). bmips_cpu_setup() needs to be called shortly after that,
during prom_init() in order to enable the proper Broadcom-specific register to
turn on RIXI and the "rotr" instruction.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kconfig            | 2 ++
 arch/mips/kernel/cpu-probe.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 29f5b3138d6b..b03a68879b6a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1799,6 +1799,7 @@ config CPU_BMIPS4380
 	select MIPS_L1_CACHE_SHIFT_6
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
+	select CPU_HAS_RIXI
 
 config CPU_BMIPS5000
 	bool
@@ -1806,6 +1807,7 @@ config CPU_BMIPS5000
 	select MIPS_L1_CACHE_SHIFT_7
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
+	select CPU_HAS_RIXI
 
 config SYS_HAS_CPU_LOONGSON3
 	bool
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a2df0357b453..cf9869d15c9f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1426,6 +1426,7 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 			c->cputype = CPU_BMIPS4380;
 			__cpu_name[cpu] = "Broadcom BMIPS4380";
 			set_elf_platform(cpu, "bmips4380");
+			c->options |= MIPS_CPU_RIXI;
 		} else {
 			c->cputype = CPU_BMIPS4350;
 			__cpu_name[cpu] = "Broadcom BMIPS4350";
@@ -1438,7 +1439,7 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_BMIPS5000;
 		__cpu_name[cpu] = "Broadcom BMIPS5000";
 		set_elf_platform(cpu, "bmips5000");
-		c->options |= MIPS_CPU_ULRI;
+		c->options |= MIPS_CPU_ULRI | MIPS_CPU_RIXI;
 		break;
 	}
 }
-- 
2.1.0
