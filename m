Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2017 08:11:58 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:36599
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdEKGL2NeYKK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2017 08:11:28 +0200
Received: by mail-wm0-x244.google.com with SMTP id u65so4392788wmu.3
        for <linux-mips@linux-mips.org>; Wed, 10 May 2017 23:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vwg1QBruwVaCb4gEwyv8aC9Ap6899cYz0jsfS5dzE24=;
        b=mA6YpCX7yn8i2vusm7qkZqs8wIswAtO89XvczQqrWILebXAv7AcHfiRiT5SfiXuFW0
         /wM54qjaiNZxrja7cBeHHEkUV/1tMdSoOzqeJkmjlmW1hn9HqCtBjkb+ov+0PAl7P++E
         QVqMRubMj3fG+xKtb972BB/SzBf5yW7hRwVh2rnnsvpyyrBeLAEaZQhN5uJy5s3cfSbx
         PjP6T0nCwrlfsz/c3UONhjnBwdy/DTglfy/kQdcC/D+WTkW8W7GUZHvY2SZf0mM4EO6J
         ef3qwRM6iPWQDbRFwHcN0a2knAY0AGuJ7H7kCX6TIymuQzdNcVL/hf71jRZxCgm2H3d0
         T/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vwg1QBruwVaCb4gEwyv8aC9Ap6899cYz0jsfS5dzE24=;
        b=EMU25kNGJbltPhlihYw/8adxfOQgV6drbmEViaGmx3S5BzdybuXl9wxZKhOKgasyV1
         jwT7wR2sim8PxI7PrGCzoGXLSR3lVSt/VUa2zJxXdwVrgfNPKgdgVjEoXZKzZS+n9YRO
         8nOFYhD64YPMy7dgIjBNF+b23b1vFnJrF6/2MJokRjKxcgaPLOtCxth2I4ReytJmXCJd
         +psliVK9VSM2ARflWSPFVJngbMCaDBLvJXtsBDJXZ+Ty6FeulDCAhYo6NePN19cWhXNd
         FrjiY/0oOiAxfJhvTYpIWNtFCnnXkVXggi+kvk3jqc1YlfdMcnnhPjoWKVIusLXV/rH+
         o1hA==
X-Gm-Message-State: AODbwcB49yc/MHFOG+PHge7Qwv9VyfLCyIlZsgItwVaIZYhx9ExkrHiw
        euGwai+KOxtzI5rU
X-Received: by 10.28.141.140 with SMTP id p134mr3033086wmd.54.1494483082937;
        Wed, 10 May 2017 23:11:22 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p2003008C2F2A1200A8F56D34CBAF763D.dip0.t-ipconnect.de. [2003:8c:2f2a:1200:a8f5:6d34:cbaf:763d])
        by smtp.gmail.com with ESMTPSA id e125sm952871wmd.33.2017.05.10.23.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 23:11:22 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     ralf@linux-mips.org
Cc:     john@phrozen.org, linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: ralink: fix typo in mt7628 pinmux function
Date:   Thu, 11 May 2017 08:11:15 +0200
Message-Id: <1494483075-17816-2-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1494483075-17816-1-git-send-email-dev@kresin.me>
References: <1494483075-17816-1-git-send-email-dev@kresin.me>
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57865
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

There is a typo inside the pinmux setup code. The function is called
refclk and not reclk.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/ralink/mt7620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 528a6ac..86fac75 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -144,7 +144,7 @@ static struct rt2880_pmx_func i2c_grp_mt7628[] = {
 	FUNC("i2c", 0, 4, 2),
 };
 
-static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("reclk", 0, 37, 1) };
+static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("refclk", 0, 37, 1) };
 static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 36, 1) };
 static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 38, 1) };
 static struct rt2880_pmx_func spi_grp_mt7628[] = { FUNC("spi", 0, 7, 4) };
-- 
2.7.4
