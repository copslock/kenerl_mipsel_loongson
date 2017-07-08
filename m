Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2017 08:30:58 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:34395
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990552AbdGHGaveXkc- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jul 2017 08:30:51 +0200
Received: by mail-wr0-x244.google.com with SMTP id k67so11986374wrc.1
        for <linux-mips@linux-mips.org>; Fri, 07 Jul 2017 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UOWeDZ5oJQajR58mf02V8k0cCPFg6uOO7jhOFvWeoK4=;
        b=j1hq5pFfCW+5ntKa+tTymeSGTf7yDcnRX0qyOQNRYTO2BVFBJBddd+d1RjKS5iBPV/
         KpFvbbzHf3e73yBZLyWz5h3SkCWW7wlk+Hf+Q8QOAtrpziQHj2A0NyXCh/G4VFK61nGR
         ohYlIn8nUW7rEY/jqi2718OpFmWrdlsnSApxKqOe9i6abCiIArVNCpUacM+m5ufRbYgo
         yTxKIktIunTeTCB3S8jxy9fN7ZLh1pHJb4iEzdPBxUKe90zEJDyOkNbD/YpFWa1KtBvi
         CN77AsadCsXOJyjoYYfAzQr1H+c9k3c8+LjKev9ZjJ0rwk0OLm/F+vvWYiyQ3TighZYR
         r3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UOWeDZ5oJQajR58mf02V8k0cCPFg6uOO7jhOFvWeoK4=;
        b=ejqIyEq75vzLQ7W2IPo4vtJwLLyJ1NxcPI4NuAQS5WVlQtiydRYvc/+4tbO+Kixlrk
         msTUWd7PMDI4sDYDkyu9SnwiZyY8TB+WYh5mMyD70ApUWdYktjRKafXjQcH8ow0L+9lz
         x1oATfsf5H8Z6LQhfNgqaOSHpdk4pnKKdwkQYRHNPI8i+AmR3gH0Pnl0OgBfG3P7yOSi
         OjbCnemJAr4fFo5hqmmFuJWJFPAvxYjMjMlWoWpQaiRuKcaBwI32/Qqxpsavlaon2xg7
         4zQnc6uLzhvHYIeoLGf6GOo/LFKNysqqiVSsxF/mOqnxbv3GwyaTq5EYCbe0HA1TCaEp
         OmtQ==
X-Gm-Message-State: AIVw110484HVgo0HXyj1qjRa8yX5jmwxY72KddGloIDtnMd6KDudHyS9
        g7H59uQZtiNNAL0J
X-Received: by 10.28.105.28 with SMTP id e28mr1389990wmc.42.1499495446202;
        Fri, 07 Jul 2017 23:30:46 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p2003008C2F4D320011E39C9060AC7945.dip0.t-ipconnect.de. [2003:8c:2f4d:3200:11e3:9c90:60ac:7945])
        by smtp.gmail.com with ESMTPSA id y9sm5782821wry.32.2017.07.07.23.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 23:30:45 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     sgruszka@redhat.com, helmut.schaa@googlemail.com,
        kvalo@codeaurora.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] rt2x00: call clk_get_rate only if we have a clock
Date:   Sat,  8 Jul 2017 08:30:41 +0200
Message-Id: <1499495441-4098-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

If clk_get returns an error, rt2x00dev->clk is set to NULL. In
contrast to the common clock framework provided clk_get_rate(), at
least the ramips and bcm63xx legacy implementation of the clk API
access the rate member of the clk struct without a NULL check. This
results into a kernel panic if we do not have a (SoC) clock.

Call clk_get_rate only if we have a clock to fix the issues. This
approach is similar to what is done in the kernel at various places.
Usually clk_get_rate() is only called if clk_get_rate() doesn't return
an error.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index d11c7b2..2a525b9 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -2059,6 +2059,9 @@ static void rt2800_config_lna_gain(struct rt2x00_dev *rt2x00dev,
 
 static inline bool rt2800_clk_is_20mhz(struct rt2x00_dev *rt2x00dev)
 {
+	if (!rt2x00dev->clk)
+		return 0;
+
 	return clk_get_rate(rt2x00dev->clk) == 20000000;
 }
 
-- 
2.7.4
