Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 07:47:52 +0200 (CEST)
Received: from mail-pg0-x235.google.com ([IPv6:2607:f8b0:400e:c05::235]:34167
        "EHLO mail-pg0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992022AbdF3FrKX0XRm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 07:47:10 +0200
Received: by mail-pg0-x235.google.com with SMTP id t186so58772447pgb.1
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 22:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qsQw8YfTN4V/2RxuF5rUjMkS3vhgniLUlofFz0Ul2P4=;
        b=POl0Ew+LBNego56svIblaXg+OIKC2zQafP+IvAPJE+1bidbGDgLxXsgBD2ra1zaa3I
         TOEqpacTX5HRqVee2fV4uz/BQYQXa2+pWPiVOVPiOzmJudL2S1zW7HwvXV9FfbEAgJyT
         KqvYQ0ir8PH580YUul8MSv0py78f9WrSzqoH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qsQw8YfTN4V/2RxuF5rUjMkS3vhgniLUlofFz0Ul2P4=;
        b=F9O8SnAiVHTOnId2TXmGWI4+iFbfCGKcdfU9u07sWLwtpUrfa/YUimf2yk6HCxCiQb
         NjsXAopPedR64mkpPeNrUESgLvBmkjdpYZBiLdoX+NqWGZB/9pFhIFbsHtZGJ7SWoTzF
         mAHF6hxmxq7R6GH44anjHqJTH49Am5mqCl/if3UoMK1G+ISj24QMr4qYAo8LPsGK0gE0
         lXaJb2IZldtC5o+nLKmVM8Dw2b2SIT6PkgQ0qHEISyVzD1KqYKLhVNi6LF928m5443dj
         3vetjyRoyQDQ1HNSaBQNN5/H8bcm4IkBx706dVknA+eaScUC9ppr4oY4PJG8ilu+jLZN
         M6mQ==
X-Gm-Message-State: AKS2vOxNqjP7AALOCh6eYn/3bnNJ3xHvqKPlgMeKubwVK9TBnCxkIDGv
        8QDX9qbyfEG+sM/r
X-Received: by 10.99.4.6 with SMTP id 6mr19792491pge.126.1498801624614;
        Thu, 29 Jun 2017 22:47:04 -0700 (PDT)
Received: from localhost.localdomain ([106.51.129.233])
        by smtp.gmail.com with ESMTPSA id a187sm11405550pgc.37.2017.06.29.22.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 22:47:03 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>, John Crispin <blogic@openwrt.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 06/16] MIPS: ralink: fix USB frequency scaling
Date:   Fri, 30 Jun 2017 11:16:30 +0530
Message-Id: <1498801600-20896-7-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
References: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: John Crispin <blogic@openwrt.org>

commit fad2522272ed5ed451d2d7b1dc547ddf3781cc7e upstream.

Commit 418d29c87061 ("MIPS: ralink: Unify SoC id handling") was not fully
correct. The logic for the SoC check got inverted. We need to check if it
is not a MT76x8.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11992/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/ralink/mt7620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 733768e9877c..4c17dc6e8ae9 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -459,7 +459,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000c00.uartlite", periph_rate);
 	ralink_clk_add("10180000.wmac", xtal_rate);
 
-	if (IS_ENABLED(CONFIG_USB) && is_mt76x8()) {
+	if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
 		/*
 		 * When the CPU goes into sleep mode, the BUS clock will be
 		 * too low for USB to function properly. Adjust the busses
-- 
2.7.4
