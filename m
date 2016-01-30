Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 06:19:08 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35898 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009274AbcA3FRnhOJEt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 06:17:43 +0100
Received: by mail-pa0-f65.google.com with SMTP id y7so580928paa.3;
        Fri, 29 Jan 2016 21:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcWh70oo2GwzQUf+TohKHlGK0d1vVU5mzcjA4XUp9wU=;
        b=Ka5HQfADS3/E92sCODBBKxulkhj1Sx5LsNV7PD8xhb9KwvBLwxs4QOgnJBxpz2lypo
         V3oDTMcAyzyEGtXQOjqTXEcnIl9B1u7OdJ04ZZp1n6iLR8BTLEXnRjA0QMBpA/9oY8as
         +QgOnRFt2tCFqwFYAbQ2Z3+oVuQvXR3G9k2ZXZCPXxyTtoAbFB1ce/kvJgeIjiqGQed+
         KV5t8g2qS1k+Y57ooNTis2Cfp7174yw1P1IXmznQOKfWIQtGkk6tDAnP7QbyLia0z47q
         Y6fKfaCMU5sCAXxrWuxXcqT2y28JiX2naKFHQF9CmhmImrC1qxaf8ZLTpMZVedCxyxOx
         dJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xcWh70oo2GwzQUf+TohKHlGK0d1vVU5mzcjA4XUp9wU=;
        b=Gu7E8jrxtN6vNDEhDmoTWHYsGExehtOjdJS8+UJBXh2Xjz1/MGLFbLyxIA6cYQdP0O
         3ZzEK7Fw3G2GWlbtlKJd+ixOhkkXW2RmxHxHFAbvx1QS2cq94rjpVWxjqNYWaqiCDYVA
         nMfjKAF9WfkaO9y7zjMh/ZWT5zHHhdFe6GnwKcKssHyVmI6Sujit23SsuohEDHU3p9qk
         VWiZmXPP2rH6KTHWgDAPBqGtH9xlKIESlZMdRSyEmny2ecBLqXp8U39yeW7RPIbfBf9x
         DYiQZF7wjCqfgo4DfpQP6WxxPPcoCw+RBPoVKO4G1TGZtxirfzGA4IEgTcC1DeyA9qJa
         OqAg==
X-Gm-Message-State: AG10YOT0XuwdAfU8naqKoGXCMLiRjFTA+g7jLSFRE86LLpDJq7jYUWtq+fYyLR4mQ4Me1Q==
X-Received: by 10.66.141.165 with SMTP id rp5mr19660325pab.56.1454131057919;
        Fri, 29 Jan 2016 21:17:37 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id a21sm7498645pfj.40.2016.01.29.21.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 21:17:37 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 5/6] MIPS: BMIPS: Pretty print BMIPS5200 processor name
Date:   Fri, 29 Jan 2016 21:17:25 -0800
Message-Id: <1454131046-11124-6-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
References: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51542
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
 arch/mips/kernel/cpu-probe.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b71..f8cc8ec 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1445,7 +1445,10 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_BMIPS5000:
 	case PRID_IMP_BMIPS5200:
 		c->cputype = CPU_BMIPS5000;
-		__cpu_name[cpu] = "Broadcom BMIPS5000";
+		if ((c->processor_id & PRID_IMP_MASK) == PRID_IMP_BMIPS5200)
+			__cpu_name[cpu] = "Broadcom BMIPS5200";
+		else
+			__cpu_name[cpu] = "Broadcom BMIPS5000";
 		set_elf_platform(cpu, "bmips5000");
 		c->options |= MIPS_CPU_ULRI;
 		break;
-- 
1.7.1
