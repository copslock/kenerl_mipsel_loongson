Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jul 2013 00:08:35 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:56044 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831319Ab3G2WHRfV7rW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jul 2013 00:07:17 +0200
Received: by mail-pb0-f50.google.com with SMTP id uo5so1876019pbc.9
        for <multiple recipients>; Mon, 29 Jul 2013 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C7htIkuj13wZlJUlzSzc50Zk58Q1i2wCO7mHSMGC958=;
        b=K5tdAZXpu1E+HGD6Ng85jTjW/5evr/ggZP3tx69r3+xKCsTnqD2OCNQp93Cuietbz9
         rZKFybqBMfQScZr7KMjfJb0bCIhuB+jFG7yNejI8kzxpvCvO66kJmyaSFvgqgJQpQdD4
         LrPkoVncGiEC1hQIMlc+nsOCU0iqAPLNGtLWoxJNufPvDqE0WqMFXW17SxpbsHhVAcsG
         FGup91HGXUF7GlUObE3O15kTQuuIZW08rmwTi6a0eGeq5bekhPUcl4Q/V9cuffhAa1Tw
         RHbGuI4MdvYPuuu4Fop+6yvVem+JlfLitVu4TwoBolkAqpMC1dyQ3+RCF+HWiOWqKUu4
         1NiQ==
X-Received: by 10.68.252.137 with SMTP id zs9mr70094293pbc.60.1375135630981;
        Mon, 29 Jul 2013 15:07:10 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id lk9sm22944149pab.2.2013.07.29.15.07.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 15:07:10 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TM78fp030997;
        Mon, 29 Jul 2013 15:07:08 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TM785A030996;
        Mon, 29 Jul 2013 15:07:08 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/5] MIPS: Probe for new OCTEON CPU/SoC types.
Date:   Mon, 29 Jul 2013 15:07:01 -0700
Message-Id: <1375135624-30950-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37396
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

Add probing for CNF71XX, CN78XX and CN70XX.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/cpu-probe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 4c6167a..8e8feb8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -852,10 +852,17 @@ platform:
 	case PRID_IMP_CAVIUM_CN63XX:
 	case PRID_IMP_CAVIUM_CN66XX:
 	case PRID_IMP_CAVIUM_CN68XX:
+	case PRID_IMP_CAVIUM_CNF71XX:
 		c->cputype = CPU_CAVIUM_OCTEON2;
 		__cpu_name[cpu] = "Cavium Octeon II";
 		set_elf_platform(cpu, "octeon2");
 		break;
+	case PRID_IMP_CAVIUM_CN70XX:
+	case PRID_IMP_CAVIUM_CN78XX:
+		c->cputype = CPU_CAVIUM_OCTEON3;
+		__cpu_name[cpu] = "Cavium Octeon III";
+		set_elf_platform(cpu, "octeon3");
+		break;
 	default:
 		printk(KERN_INFO "Unknown Octeon chip!\n");
 		c->cputype = CPU_UNKNOWN;
-- 
1.7.11.7
