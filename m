Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jul 2013 00:10:00 +0200 (CEST)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:40339 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831322Ab3G2WHS2mp7m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jul 2013 00:07:18 +0200
Received: by mail-pb0-f51.google.com with SMTP id um15so5207269pbc.10
        for <multiple recipients>; Mon, 29 Jul 2013 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pjzVLFYX7K47jJCsXEggP+q91bDDmhUrqyA3S8fWSak=;
        b=ElYjz0zd0fI0vwPWVw0dmDUeseffF40+ViCrGUlQVqNTKU8ssmKTLrJEEJFHRNg8Zg
         FKCVfjd/lgiQz2mKKWsIoWD2VMHZkIdACwwysa5nCyjun7Ln1k3Nn0m9dQ19vmlx3taF
         eiRrgl9ohsIRWXPR18rEdDIXTehpgAdQDzfKan1hnAHBIrw7MwASnL9ijJZQCzp58oXo
         uHM6p94puRPSX7DkIxiCauOosQZbVTJ6+QYwoiESWqYXE/rAH1vuPIfT+8DZeIjq3Gbo
         FTUIEXkcCKEJibYRqu+NKcY81MwNDcjvoSCMpTdat3+E48IKL6SybhFF3mDiZKNb3h0E
         wtDQ==
X-Received: by 10.68.103.131 with SMTP id fw3mr70110932pbb.65.1375135632032;
        Mon, 29 Jul 2013 15:07:12 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id dg3sm78994033pbc.24.2013.07.29.15.07.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 15:07:11 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TM79rG031009;
        Mon, 29 Jul 2013 15:07:09 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TM79iU031008;
        Mon, 29 Jul 2013 15:07:09 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 5/5] MIPS: OCTEON: Set L1 cache parameters for OCTEON3 CPUs.
Date:   Mon, 29 Jul 2013 15:07:04 -0700
Message-Id: <1375135624-30950-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37399
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/c-octeon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index a0bcdbb..729e770 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -224,6 +224,20 @@ static void probe_octeon(void)
 		c->options |= MIPS_CPU_PREFETCH;
 		break;
 
+	case CPU_CAVIUM_OCTEON3:
+		c->icache.linesz = 128;
+		c->icache.sets = 16;
+		c->icache.ways = 39;
+		c->icache.flags |= MIPS_CACHE_VTAG;
+		icache_size = c->icache.sets * c->icache.ways * c->icache.linesz;
+
+		c->dcache.linesz = 128;
+		c->dcache.ways = 32;
+		c->dcache.sets = 8;
+		dcache_size = c->dcache.sets * c->dcache.ways * c->dcache.linesz;
+		c->options |= MIPS_CPU_PREFETCH;
+		break;
+
 	default:
 		panic("Unsupported Cavium Networks CPU type");
 		break;
-- 
1.7.11.7
