Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 12:17:58 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:34042
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994847AbdGRKRv38Zld (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 12:17:51 +0200
Received: by mail-wr0-x244.google.com with SMTP id w4so3631470wrb.1;
        Tue, 18 Jul 2017 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=53C57+nq/4b+0h92EdDMa+xLCRMVcwzdCJc+XTejfPo=;
        b=CQma+77Z1LtKLOVJbI3LLru6R9tnEcUmlEAPoFV6Yo5fHFwl+CNsEB5i22Wmg7yU7W
         d1YU68v6pcBEW1YjxiwS987N/5EEOAQ0lal8RHNjB9KGDlY7oRCDbi1FVFCdf+4MRCtY
         bS0rJoPiQfONHv3FdTtYTVlrmYvkUWG1A2wzCK+AvsGVzyDY42IsM2PUJCrFUr/INpvs
         roGHeXx505s2vlzvfPIMmcbp5GskraDc6lAC0t8RQUwKWqZQ4woiENGW+qxSknVCrGem
         5FNZOvxH4ZpfbvWpDCDpeaWp+S70tIDbsnmbacbkCpQTTDiut6Irbtly5f4LLpoAW2Zf
         nKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=53C57+nq/4b+0h92EdDMa+xLCRMVcwzdCJc+XTejfPo=;
        b=ludMIwVN6jyN6T/JdmyBB81t8BrUB+iec81e/EKHgoVgXBmtSm8nKxVVaLwA986tr3
         zmsJjs3ah7gqqGa8cYsRxu5liMYMBSSXKO9fNaT/rdyIm6y4KltzLK3ssRJbvqY/LAVA
         FxBRVpPU9I7BqthxzHbhWC4hPgA9btgpBK2YK2vD0ihhnGZWMkIdgpzdZAix5kI78aMq
         al/pCBHIy7uZgoBuxINjPxqr0V9JfjCkc1XDI7UcS2b3RdcGswFI7XeiI/+gU2l+d+Hu
         T92I5M38G48BbJUQCVcZdS4WYa0ER9l7zuN78PjBW7bplLCNhGCwElcCqCHXMvCOIBRT
         jWTQ==
X-Gm-Message-State: AIVw113rR7VJvOqL9VXno3fL8ybUOJCyyUnzvPNpOFzLz6p5VpvF5oik
        skYqzxyWexnlMK5P
X-Received: by 10.28.181.6 with SMTP id e6mr1197277wmf.25.1500373066012;
        Tue, 18 Jul 2017 03:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 9sm3253728wml.25.2017.07.18.03.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 03:17:45 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] MIPS: AR7: allow NULL clock for clk_get_rate
Date:   Tue, 18 Jul 2017 12:17:26 +0200
Message-Id: <20170718101730.2541-6-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170718101730.2541-1-jonas.gorski@gmail.com>
References: <20170718101730.2541-1-jonas.gorski@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59127
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

Fixes: 780019ddf02f ("MIPS: AR7: Implement clock API")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/ar7/clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
index dda422a0f36c..0137656107a9 100644
--- a/arch/mips/ar7/clock.c
+++ b/arch/mips/ar7/clock.c
@@ -430,6 +430,9 @@ EXPORT_SYMBOL(clk_disable);
 
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (!clk)
+		return 0;
+
 	return clk->rate;
 }
 EXPORT_SYMBOL(clk_get_rate);
-- 
2.11.0
