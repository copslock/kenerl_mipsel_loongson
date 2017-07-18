Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 12:19:12 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:35777
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994850AbdGRKRykqzGd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 12:17:54 +0200
Received: by mail-wr0-x244.google.com with SMTP id a10so3657775wrd.2;
        Tue, 18 Jul 2017 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3P9Xht38iIfkyMom35IZVoGV+p+fw2DjuuEs4EalF3M=;
        b=muw5Fzo1uhCLLsgbX2yw9h+bsz6T35LRTmM1YyHM/DO+cpF4LROAwFjPO1kkutCnkC
         1kaiEjo2u9N1VKWvNLEh1foud9HoQx/CbxkhrWm9KgHGh4QVzpzFGtlLmMvozsp0wxXB
         5/hXEYSOj+foQNJu33Z42szIIMsS5glaKBpliKxHeBoebmFRXl90ixPD3/aaIRqtrg8Y
         DD1sP8n1FYkqV9IconeUV7tLcaMTiLos8nM8hFxEgXjXXa70EcmPreJLNsxz/z7GuVBO
         PDBMPzw7xbEmlowbT3xMNIuaeXyw+LO+icPn+99H4pDiR6SV+kx9tI8KRZG3Ykxc4cZS
         2IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3P9Xht38iIfkyMom35IZVoGV+p+fw2DjuuEs4EalF3M=;
        b=mcyR6hORLiKAEDXR+NkdfG1EGZv7ChPI8Nd+nYn72/qvCjLX8l7OKg+nyAwsLfpfez
         eyhi8cgs+CBaBis6CFZK/GkUzSsIAJjMNG+/DIGlL0TRrH6ASxPJ15g0OBFYSyD2qqfZ
         m0fF6ahi/M1W2R+789vQfkukMZYBwBurNRSNJslu3KUG1iHaG0yPnZ/DuiW05o4Q9tWN
         Ivk3Iumb3QU4w7B+H0ykQ+of2rW6MnCKGAgj70nDDchI/VuuzKxKBhDuQOnpVH313B3u
         Aj8RuUmA7zwe4ioQ1s4gRhfOZ1K7j81sVmopr21KX75opTzUkIswIVBumjAmSGBHg9Aj
         9SOg==
X-Gm-Message-State: AIVw111Ps2BOda3RGXwN8LVbM6V6I2yw78va6jz3tFfg+72KIByyp5XS
        RZoDE/kMRvUbew==
X-Received: by 10.28.14.207 with SMTP id 198mr1218941wmo.102.1500373069411;
        Tue, 18 Jul 2017 03:17:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 9sm3253728wml.25.2017.07.18.03.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 03:17:48 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
Cc:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] MIPS: ralink: allow NULL clock for clk_get_rate
Date:   Tue, 18 Jul 2017 12:17:29 +0200
Message-Id: <20170718101730.2541-9-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170718101730.2541-1-jonas.gorski@gmail.com>
References: <20170718101730.2541-1-jonas.gorski@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59130
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

Fixes: 3f0a06b0368d ("MIPS: ralink: adds clkdev code")
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/ralink/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index eb1c61917eb7..1b7df115eb60 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -53,6 +53,9 @@ EXPORT_SYMBOL_GPL(clk_disable);
 
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (!clk)
+		return 0;
+
 	return clk->rate;
 }
 EXPORT_SYMBOL_GPL(clk_get_rate);
-- 
2.11.0
