Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 19:59:11 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34933 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025987AbcDDR5xaSU-W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 19:57:53 +0200
Received: by mail-pa0-f43.google.com with SMTP id td3so148221145pab.2;
        Mon, 04 Apr 2016 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GJWsJSeGYRSN32eHhnNsyjz/ZI0eRf1schmJXAqG+50=;
        b=zuq9T6sPGygZDmDrFEw05Bi18/P3205WPRe6mTsmqA1LZHsse3to9sZctIJVs2tHZH
         Cz6UcVMSsV99OjHca1SNDp/U5NFYmwBVFxvuCoh7mdQtngs/2eyVI2Q9F9IREfsVxLsb
         C8xTOCIlWT+AZqENe5zXcDqlgwhqRLmGFTPpCAExD+buy6FJJs/LtWouyRLgSqOIJc2O
         wWTQFqb6pM8n7q5tw0EQDTTDqxTwOlqs/SmHZU5+g86oWdoAuY7qZO2E8RZGVtDm94eN
         0TrVFz7ZIl/XrI3av7TmbNyiSQsnUhj1aKDOmQy60Wz7ggQs00LY5HmrbMBKejE6W+fP
         2Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GJWsJSeGYRSN32eHhnNsyjz/ZI0eRf1schmJXAqG+50=;
        b=cIFIUaHIcx3oIiL4wYXxCE37WKpNxtYTQzTC0Olu3yRS2aS32l//1NeG6t9kkOTd2L
         x+VtWacid8UJRIrxSki0O6Bw4YJyv//dAipl1OyQVxeTYyLbfjbaa9aJW76kLvNSXo96
         MQdmeiF0D2/AObCW3hca6MDkbNuFJsTXksgB3kcerOMQ2p44owq1cjeD79n3vheFygC0
         Tu8epmS0houLtY5oGOikfiLgOzH/zXQRQqjXbUREscQon1Jv1w4WBvQCPKUjYgZ0RGav
         2sPQb/ztgwzXiQspIyEw8P+ttmC8fLaOg1n2YbXpsdCnl4TbEZ5l7GJRk15qh+up6NWY
         3mIw==
X-Gm-Message-State: AD7BkJJrDI8KEXFUsKVTaakdRl8rTa5j+JNskbIoUEGBsMwEaDQ/fAPbZD2lZvt7nljfwg==
X-Received: by 10.66.136.78 with SMTP id py14mr48663450pab.113.1459792666961;
        Mon, 04 Apr 2016 10:57:46 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 20sm40948752pfj.80.2016.04.04.10.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 10:57:46 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 5/5] MIPS: BMIPS: Pretty print BMIPS5200 processor name
Date:   Mon,  4 Apr 2016 10:55:38 -0700
Message-Id: <1459792538-19854-6-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
References: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52882
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

Just to ease debugging of multiplatform kernel, make sure we print
"Broadcom BMIPS5200" for the BMIPS5200 implementation instead of
Broadcom BMIPS5000.

Fixes: 68e6a78373a6d ("MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/cpu-probe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e291928403b9..25e6e66342f9 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1451,7 +1451,10 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_BMIPS5000:
 	case PRID_IMP_BMIPS5200:
 		c->cputype = CPU_BMIPS5000;
-		__cpu_name[cpu] = "Broadcom BMIPS5000";
+		if ((c->processor_id & PRID_IMP_MASK) == PRID_IMP_BMIPS5200)
+			__cpu_name[cpu] = "Broadcom BMIPS5200";
+		else
+			__cpu_name[cpu] = "Broadcom BMIPS5000";
 		set_elf_platform(cpu, "bmips5000");
 		c->options |= MIPS_CPU_ULRI | MIPS_CPU_RIXI;
 		break;
-- 
2.1.0
