Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 12:18:22 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:35771
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994848AbdGRKRwjLn2d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 12:17:52 +0200
Received: by mail-wr0-x241.google.com with SMTP id a10so3657573wrd.2;
        Tue, 18 Jul 2017 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2RSgjSqarDMFUeMPztYDlApKsH0hLQ45MGM+wH8LbAs=;
        b=W8t4xvg+eDZea25g1Q4bpuajRU5yPVB9Vx3PF8KkKSREsGE55QKpnHfpSYfxZf4kUz
         4YxgiN88QbJlSi1CvqMr24wEuxqZE1/WMe7XeV+w6N6h3BTUXbDPIDLut8xiyYLHFZjj
         xfp3HD+keBgV8EdO+V/KEfxoEC+oNFOqQPN/gPF71bI/ong+wrZOVgdlfNMc6BFZuCOd
         gvKiQER9DNDPnIdaVvowvbvP+4mJz4oK/RVwRkVcKLRZqXDPLqmhr6GM9XODfL6/zHA3
         DymTbWdp1++PDnaCkziDdPvwz+wQ24H+QoZ0ZRmeGhacbfzgWuv41+Vjsr8xufcJxxQY
         pLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2RSgjSqarDMFUeMPztYDlApKsH0hLQ45MGM+wH8LbAs=;
        b=ulyvK32I0GBYDA2lFg522O/NlMr6UiaICizvo9YYKz9FjOc6vjNCxe/dbXiRpqK7Yv
         bFwlJnEOR1nHfnBl6GH6wMeCEqPBRo+kb59CfQ9UtVXSH30C5jUhU+s5kefsYN88Q2cv
         ZCXDFCuj2ONXQ8GfSP92uVR7a7sQL8B+IRDgtgjS0sshK1c/ulBe23Dkh9Zi5BECE1nW
         +LO8jTqAxCtsUgZ+TZNkwDDjLrRwVdoj8hb20oEk80nGlM4cbRaIqinIa0cyMIUnwETu
         FADJNK0sN3Yg7N7J5QC6Tl1jw9aUPG467WaBGVm3iVpJW6JKK9oNPGwUBElRl18NP/YF
         ENzw==
X-Gm-Message-State: AIVw110EnsGjLzaEtfGW2lC7Kd9aOZh5tWOENrNowVl57+yYHu7IysTq
        BJ++9K4wWWDIwRhD
X-Received: by 10.28.232.29 with SMTP id f29mr1185057wmh.55.1500373067171;
        Tue, 18 Jul 2017 03:17:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 9sm3253728wml.25.2017.07.18.03.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 03:17:46 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] MIPS: BCM63XX: allow NULL clock for clk_get_rate
Date:   Tue, 18 Jul 2017 12:17:27 +0200
Message-Id: <20170718101730.2541-7-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170718101730.2541-1-jonas.gorski@gmail.com>
References: <20170718101730.2541-1-jonas.gorski@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Make the behaviour of clk_get_rate consistent with common clk's
clk_get_rate by accepting NULL clocks as parameter. Some device
drivers rely on this, and will cause an OOPS otherwise.

Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 73626040e4d6..19577f771c1f 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -339,6 +339,9 @@ EXPORT_SYMBOL(clk_disable);
 
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (!clk)
+		return 0;
+
 	return clk->rate;
 }
 
-- 
2.11.0
