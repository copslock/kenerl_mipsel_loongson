Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 07:34:02 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:39371
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990418AbdLZGdi1EAlI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 07:33:38 +0100
Received: by mail-pg0-x242.google.com with SMTP id w7so17503129pgv.6;
        Mon, 25 Dec 2017 22:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0FC/O+30bdVosxwX3UHzHdlju0WFI9xm8R5FAJ/ynjU=;
        b=ZMm5mqhk/UGQ6cs/zkO3aODEOmFYu9QoC4lysIJ3R6/Uy6iMHhRcGcMbcXPcccQ5So
         Wrb1BkwL3kn4a0tnJQOfsdOn78WKehZNjgDe8QQPbUlMciHYzgTqAx9xP0/rU7aWWv02
         tUWqr1csmZbKgoKHHV/VeoclcflZ4Cd1WkZ91IDGC00wytiUZQ088RB3wx/bFz6v73rX
         LLPvSu6YKtMJ5JWK3DZeNBRqLMyt12YeV1Pm5AaTqxiQxty3WgcpTWSoDz0m332uI4sl
         peP0u2WRgzsKfNs+A5MXbU90oqcSeM5gXFk/CpgP0sDr7tlsYL+MlrnHTlWUsQQbKfQ8
         BfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0FC/O+30bdVosxwX3UHzHdlju0WFI9xm8R5FAJ/ynjU=;
        b=fUTQoJxT0tALk0Aq9DXRSRWkKxrE+lU6llPQdUhqXD5Cj/c7tlQLQa20FTQuMg75wl
         s/prOClVcm5rh+zbNVhQgdfh21Jxef4DxTnj77i7FqYn8pXJBZkStGJDzf9B5KuUXRyR
         0PaxQNKJJ2aa1Bftz9+aYxNLciFI3HhI/mcQYMbc7bdacFsa/UaWC6UMZZZ9ztfDTN80
         Ffx21b3KLTQ4ZDxCZy/SL422orQqcZp61+ldMJaxksLv3aKquVAUxMENrAFFVL1cfYek
         i6Urg2JbclqOv81RANXnMMjRFX0eK2iit8Np5lgaxDHNLTHglTpsdpyqK7gdq70E6RMQ
         oMmA==
X-Gm-Message-State: AKGB3mKixmXpB5jglTUZZ2TbbJ5w02cGskeZPJ0IpIRTVHDHx76sLwCT
        yPXfcXKiUqc9fzo+q6Tcelc=
X-Google-Smtp-Source: ACJfBouY/0DXSxF5xja7eue2T2I3a26P5WqeWOJ8oB2TrSB451eJVCpOC1r+IjgJ6Q6yAhaXGEg4oQ==
X-Received: by 10.101.101.23 with SMTP id x23mr11877695pgv.399.1514270012257;
        Mon, 25 Dec 2017 22:33:32 -0800 (PST)
Received: from localhost.localdomain ([103.16.68.147])
        by smtp.gmail.com with ESMTPSA id h69sm59911895pfk.166.2017.12.25.22.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Dec 2017 22:33:31 -0800 (PST)
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
Subject: [PATCH 02/11 v2] MIPS: AR7: constify gpio_led
Date:   Tue, 26 Dec 2017 12:03:09 +0530
Message-Id: <99868e4babfb2d550f94c8e8d604f41b577c864d.1514267721.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
References: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
References: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
Return-Path: <arvind.yadav.cs@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61589
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

 arch/mips/ar7/platform.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 4674f1e..4694273 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -346,7 +346,7 @@ static struct platform_device ar7_udc = {
 /*****************************************************************************
  * LEDs
  ****************************************************************************/
-static struct gpio_led default_leds[] = {
+static const struct gpio_led default_leds[] = {
 	{
 		.name			= "status",
 		.gpio			= 8,
@@ -354,12 +354,12 @@ static struct gpio_led default_leds[] = {
 	},
 };
 
-static struct gpio_led titan_leds[] = {
+static const struct gpio_led titan_leds[] = {
 	{ .name = "status", .gpio = 8, .active_low = 1, },
 	{ .name = "wifi", .gpio = 13, .active_low = 1, },
 };
 
-static struct gpio_led dsl502t_leds[] = {
+static const struct gpio_led dsl502t_leds[] = {
 	{
 		.name			= "status",
 		.gpio			= 9,
@@ -377,7 +377,7 @@ static struct gpio_led dsl502t_leds[] = {
 	},
 };
 
-static struct gpio_led dg834g_leds[] = {
+static const struct gpio_led dg834g_leds[] = {
 	{
 		.name			= "ppp",
 		.gpio			= 6,
@@ -406,7 +406,7 @@ static struct gpio_led dg834g_leds[] = {
 	},
 };
 
-static struct gpio_led fb_sl_leds[] = {
+static const struct gpio_led fb_sl_leds[] = {
 	{
 		.name			= "1",
 		.gpio			= 7,
@@ -433,7 +433,7 @@ static struct gpio_led fb_sl_leds[] = {
 	},
 };
 
-static struct gpio_led fb_fon_leds[] = {
+static const struct gpio_led fb_fon_leds[] = {
 	{
 		.name			= "1",
 		.gpio			= 8,
@@ -459,7 +459,7 @@ static struct gpio_led fb_fon_leds[] = {
 	},
 };
 
-static struct gpio_led gt701_leds[] = {
+static const struct gpio_led gt701_leds[] = {
 	{
 		.name			= "inet:green",
 		.gpio			= 13,
-- 
2.7.4
