Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 06:17:57 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35888 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006540AbcA3FRjA6-1t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 06:17:39 +0100
Received: by mail-pa0-f68.google.com with SMTP id y7so580873paa.3;
        Fri, 29 Jan 2016 21:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dv5DkBO0kQm3QPXv+5Lbbx7L8HH5q8kNwyRk/a0kquI=;
        b=QS28yNpEVY107ZsbfX7FGNftc59XGtll1R0mSI/oOVlNPGF6cAAX8vvDWnFAk9cjo3
         37L/xS0nlhk3ILzvKnhWlYI7VLPJjTmeTeWBEF+J4kS8PLmvgV02KKDXId94olr9JbxD
         x6IKFccYSKGBvXn2JIneCz1Dv4Y6VwzU9eUo8MNO2HIavPQKUbBzN/9UKFFVrEiLAH1T
         6djajBLRM+d0Gi+48BvGcW4k0CR8N7xoVtjUjGWZiIv8V2TRYxourprrwHoFS4HR/Vfp
         ZIxo3hYQPAWm2u99njBoYcgK6BZ88jKTZkHq5hMzY+9N6siiltrssRcTO+IyeM7S2LWa
         37Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dv5DkBO0kQm3QPXv+5Lbbx7L8HH5q8kNwyRk/a0kquI=;
        b=N/IE6ktDT5owZbexjLwLlAJSXisJ/r9vc7HrJ9e7i1sb4dRmqjBLeC5fWh7xygnvmn
         l0C0Qpc/Ov07zCdPQi0JJyh/MsftstMiF7w+jhTdV4PXMw5r6JOuLqY/D/Di1L0gdoXH
         u5Lm+tNojeEKCba0ZilnbwHGCTWaP1F3g8FQmWRHiQ/LhyNK9F8ackP8Ij0HAURRpANN
         DMUm3Rh+8GKdIcRdFlUe4XLKyHVEVlLZQxdPetrv2b2IAIimBpNffxsNrPPQXC5+2nel
         jUnHqHCdGryg0u3Z7PqA0rFyVfLt7NnqCiy99Fr01Zwk5W8olwpne0b35W+PWqPc+GoF
         Ys3w==
X-Gm-Message-State: AG10YOSFqVZOdk3Xxkt9zfVgwTBvHrABi5SygGRNSR4dD8eJ35UXe9oO/QT/K+JQVTL8zQ==
X-Received: by 10.66.163.196 with SMTP id yk4mr19726393pab.115.1454131053332;
        Fri, 29 Jan 2016 21:17:33 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id a21sm7498645pfj.40.2016.01.29.21.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 21:17:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/6] MIPS: BMIPS: BMIPS5000 has I cache filing from D cache
Date:   Fri, 29 Jan 2016 21:17:21 -0800
Message-Id: <1454131046-11124-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
References: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51538
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

BMIPS5000 and BMIPS52000 processors have their I-cache filling from the
D-cache. Since BMIPS_GENERIC does not provide (yet) a
cpu-feature-overrides.h file, this was not set anywhere, so make sure
the R4K cache detection takes care of that.

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/mm/c-r4k.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index caac3d7..30459aa 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1307,6 +1307,10 @@ static void probe_pcache(void)
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 
+	case CPU_BMIPS5000:
+		c->icache.flags |= MIPS_CACHE_IC_F_DC;
+		break;
+
 	case CPU_LOONGSON2:
 		/*
 		 * LOONGSON2 has 4 way icache, but when using indexed cache op,
-- 
1.7.1
