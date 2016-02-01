Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 23:44:05 +0100 (CET)
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36729 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012015AbcBAWoDja4fJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 23:44:03 +0100
Received: by mail-pf0-f176.google.com with SMTP id n128so90473506pfn.3;
        Mon, 01 Feb 2016 14:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7Hx8PS1TCZh2syFYMYImYcPZUt7NJnh70EZGn8IC6E4=;
        b=e9Jwsaqd3VXh8ReYxMPFIWyl9zxZNhEVJy2kIxgwWgCuCaRiPyhenK+exw3p5gsGgL
         2w3niy7Luqd3jinsjcINI1ehKV8KMXQGZtDkFq2eQkgpxwj875pzT0e8wkLEvD2CUNE+
         CMTjbRrz4plRSTMx/iElux/iy4+m/GEk47JZ9H96h4+PVW1mK3/2ARVDBq9VEJvy0Y1F
         XD+ehbuKCopSEkrDU8rj5DbcvxQ0GSUmRRXCRdrgP5Dlx8S87xWT4JEloqVtQx0XqFW8
         coy1HLMsQwqoD8geoMAG/Tumca1A0nM/VAKRjI/tYpD/X9fkD3u76QwjNub9M4XGtTJx
         P4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Hx8PS1TCZh2syFYMYImYcPZUt7NJnh70EZGn8IC6E4=;
        b=HTkhjVwcv4vvBNmMhj3p/HDjIYgUkeOnnXQvMRgJpfUNDLHnIFFD1PNbKPNXtWkLme
         kXMKEbnitQivIq1ZuV9QyDmHa5TaeQlOYGqcb2aiRl4aYJ3FfidNTQQLGWdO8X65AsKQ
         8gXupX8RqJD7MnzGMkUlMXj6f3J3hPrdWMC6kS5LQyrGWak+tDESM+Kio5cla4HTcmWc
         LH02ChMmHG7TFjyHpFCo1MZIet3TculBihoXXA4VE438mXmfPigSm/xhAKLbJ7HrtpNO
         +08HhQY3YF2XshnbKjbWql+gsCGsASIaLj4DyFFgNciAPgnYp2hFzkell7HYlG+nHkE+
         +SZw==
X-Gm-Message-State: AG10YORnaPw+CtTH1uYNP5/2v8MJjDqwMUpgQmL0VnNoLgKjSP4ZuTsd+ifAtxF1Tpgzag==
X-Received: by 10.98.16.86 with SMTP id y83mr14420162pfi.45.1454366637599;
        Mon, 01 Feb 2016 14:43:57 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id fc8sm45698525pab.21.2016.02.01.14.43.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Feb 2016 14:43:56 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u11MhsAb010093;
        Mon, 1 Feb 2016 14:43:54 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u11Mhg3l010090;
        Mon, 1 Feb 2016 14:43:42 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Add CPU identifiers and probing for Cavium CN73xx and CNF75xx processors.
Date:   Mon,  1 Feb 2016 14:43:41 -0800
Message-Id: <1454366621-10057-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

Add new processor identifiers for Cavium CN73xx and CNF75xx
processors, and probe for them in cpu-probe.c

Signed-off-by: David Daney <david.daney@cavium.com>
---

The kernel needs some follow-on changes to support these processors,
but this is an essential starting point.

 arch/mips/include/asm/cpu.h  | 2 ++
 arch/mips/kernel/cpu-probe.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index a97ca97..7bea0f3 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -169,6 +169,8 @@
 #define PRID_IMP_CAVIUM_CNF71XX 0x9400
 #define PRID_IMP_CAVIUM_CN78XX 0x9500
 #define PRID_IMP_CAVIUM_CN70XX 0x9600
+#define PRID_IMP_CAVIUM_CN73XX 0x9700
+#define PRID_IMP_CAVIUM_CNF75XX 0x9800
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_INGENIC_*
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b71..9ad6157 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1481,6 +1481,8 @@ platform:
 		set_elf_platform(cpu, "octeon2");
 		break;
 	case PRID_IMP_CAVIUM_CN70XX:
+	case PRID_IMP_CAVIUM_CN73XX:
+	case PRID_IMP_CAVIUM_CNF75XX:
 	case PRID_IMP_CAVIUM_CN78XX:
 		c->cputype = CPU_CAVIUM_OCTEON3;
 		__cpu_name[cpu] = "Cavium Octeon III";
-- 
1.7.11.7
