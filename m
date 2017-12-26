Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 07:34:26 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:39373
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990431AbdLZGdossfxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 07:33:44 +0100
Received: by mail-pg0-x244.google.com with SMTP id w7so17503198pgv.6;
        Mon, 25 Dec 2017 22:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IbqCrLJE5wUvRmPWbtM3FZaY8dwh3wJl/7lWwBkHX60=;
        b=PS5GhsN11CqB8b8cgxeNI+qURMgAwOmKv3PyJP+gpv+v40SZYYuQtYkVXVfFJWjKW5
         2ZTG5xKHCQxXHvAvBR9DwVDn3IClBzDrAX3EOQjzTzRQ43N8vbcYeAuOX264hSvlzLeM
         Guc6XqbErYaYiSxiKIaxLs48Kuzgk5gtU7XMvPW3Bx3dee5nJw26vuwCz872pdfG8EzY
         MaipHTwDk6j2hIeWPK9q+Qep2ri6hYJQ2QaKig8tp4ias69idyP59seuGnCawMhNuZZZ
         c3vnC6xrnLGRh4gwVsZmKqTFz6zbLm7avX2UVsL/5xUBSur3628stlMzlFXXB0RK0yj8
         QHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IbqCrLJE5wUvRmPWbtM3FZaY8dwh3wJl/7lWwBkHX60=;
        b=unMGLayfhocBae+XLVcLBRi5FwxRcS+aAutoIV07Vam8fbHLcB161eaIHympaMlEuS
         mHuGpZTJRikBj9bK9iqx4a1Tu3+Gydcr/axestnFn+cSCVGK1HYyqOE1syG4HuyNsiAA
         D3wQmOA+RNb++Tr8bkh9ZQs+u/t33Ub96BFOYRJo4ncafRzcHMHOoOm8Y4ofg/l8XNPU
         DgHqBZJ97NFh/l2ggdYTlVrZuN21N2NYL+c8BrnLqR0j1fHs5Pfdc0p/Zr0f/Bh07sZm
         hwyz078feBbPvogJdNhF6a7XzWUTSiTm745wxfnhPt18pZOnlXI3+70mJm9cf7U1Licx
         be9w==
X-Gm-Message-State: AKGB3mKWUit+TadYZDKmCJYIhOT36wALls05rUxMpdkj4gst4LMqtTu3
        xuq9CVzAINHG9Gpy7eMz7FM=
X-Google-Smtp-Source: ACJfBovYiMy94T6gAUkpBns8hTGFcUqviqem+SCQhirdUaAiexQJV7+lav8fttEx64KIY4x89LYQfg==
X-Received: by 10.101.82.202 with SMTP id z10mr17027977pgp.220.1514270018754;
        Mon, 25 Dec 2017 22:33:38 -0800 (PST)
Received: from localhost.localdomain ([103.16.68.147])
        by smtp.gmail.com with ESMTPSA id h69sm59911895pfk.166.2017.12.25.22.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Dec 2017 22:33:38 -0800 (PST)
From:   Arvind Yadav <arvind.yadav.cs@gmail.com>
To:     nsekhar@ti.com, khilman@kernel.org, linux@armlinux.org.uk,
        kaloz@openwrt.org, khalasa@piap.pl, aaro.koskinen@iki.fi,
        tony@atomide.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com,
        gregory.clement@free-electrons.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, marek.vasut@gmail.com,
        slapin@ossfans.org, jic23@cam.ac.uk, kgene@kernel.org,
        krzk@kernel.org, ralf@linux-mips.org, ysato@users.sourceforge.jp,
        dalias@libc.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/11 v2] MIPS: TXX9: constify gpio_led
Date:   Tue, 26 Dec 2017 12:03:10 +0530
Message-Id: <15230823b5416a3e5814176df3ad3ff73ff3d037.1514267721.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
References: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
References: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
Return-Path: <arvind.yadav.cs@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arvind.yadav.cs@gmail.com
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

gpio_led are not supposed to change at runtime.
struct gpio_led_platform_data working with const gpio_led
provided by <linux/leds.h>. So mark the non-const structs
as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
              The GPIO LED driver can be built as a module, it can
              be loaded after the init sections have gone away.
              So removed '__initconst'.

 arch/mips/txx9/rbtx4927/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index f5b367e..31955c1 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -319,7 +319,7 @@ static void __init rbtx4927_mtd_init(void)
 
 static void __init rbtx4927_gpioled_init(void)
 {
-	static struct gpio_led leds[] = {
+	static const struct gpio_led leds[] = {
 		{ .name = "gpioled:green:0", .gpio = 0, .active_low = 1, },
 		{ .name = "gpioled:green:1", .gpio = 1, .active_low = 1, },
 	};
-- 
2.7.4
