Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 00:01:34 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:42389 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903735Ab2DSWAR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2012 00:00:17 +0200
Received: by ghbf11 with SMTP id f11so5439673ghb.36
        for <multiple recipients>; Thu, 19 Apr 2012 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4d/EUWa9owFv1GX4QJ+lSYKa3id+F6leUdonoJj0UTU=;
        b=Id7W0zQ0G7aT2YYYCd8+ENsLdGgnv4GbEHstUsEU4C/T8kgcuiRYnBS9O6dwZN+7NG
         U0rroTQTsTPR7Dki/icZYEhZJMZIxCpTdwkj+gHU8mFh1tTz+fGDK5zx1fBEamsaTOWt
         WNbGEfcEv16LtOboqfnmHhV7cn2TrtHLMetMj240fJoGanmuw3DIvtr5NCicQE1D6TCp
         9LOsZBfB4iWvbEzoec2SxT5+Goaqd8bpEClgk1zihUJ8whbhl5Ch6uF1OqH0fvObvlb+
         ptKPBIimdZGiCvZyQs3xxnaLehajw+jI58JCp1puhommq45EsqylbjTUH3S3oogO+ElF
         CEnQ==
Received: by 10.60.0.135 with SMTP id 7mr5402806oee.25.1334872811611;
        Thu, 19 Apr 2012 15:00:11 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id bd10sm1750231obb.15.2012.04.19.15.00.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 15:00:09 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3JM07NE014644;
        Thu, 19 Apr 2012 15:00:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3JM07Jr014643;
        Thu, 19 Apr 2012 15:00:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/5] MIPS: Select BUILDTIME_EXTABLE_SORT
Date:   Thu, 19 Apr 2012 14:59:58 -0700
Message-Id: <1334872799-14589-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

We can sort the exeception table at build time for MIPS, so let's do
it.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3134457..0db1cde 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -29,6 +29,7 @@ config MIPS
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select ARCH_DISCARD_MEMBLOCK
+	select BUILDTIME_EXTABLE_SORT
 
 menu "Machine selection"
 
-- 
1.7.2.3
