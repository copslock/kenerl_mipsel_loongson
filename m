Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 13:18:40 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:34313
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993958AbdITLQXC-4RX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 13:16:23 +0200
Received: by mail-wm0-x242.google.com with SMTP id i131so2126936wma.1;
        Wed, 20 Sep 2017 04:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ig83YI1v0h3OI/kJu0Klv85ij2jxa/tBRknMIUtkjw=;
        b=gb6cQLKpBQ9sNzI06NCAMOc716TGGNysDWar58WARdiyT+2f2+1Xnuen9tq1Gd0EzY
         q/A9m0Gnp458EHSJrG/65yL9NyZOabcSucN+jIhqQb12yWXNf++gL+p6ms2u7l7UHS9o
         MAQ+xGxEXqipP978Z1AcU3MhBEXp0bjplY2U3Hxv4WRN2WNaLb9ogWDkFFuz15IGa3jM
         e+2/ZswkKdVC9EI8Bv/DHIage46rS2kmHVVYeV+ZKNtLrkV67lbM5T27GVPjTwb3tpOd
         Jgqg5tpH5WJHwd7zJqhCgZeFHf9Q99RAY/Sl32pQGXA8bR1q1+uw0P4hBcCpVq+cnLmU
         mbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ig83YI1v0h3OI/kJu0Klv85ij2jxa/tBRknMIUtkjw=;
        b=Kjl/syDUHH/0WeBuQfA2uw3DlrLEG61/igYjVtGSRaFUc7Gq+PcOU6NgMFBSgIdH/l
         8+0Qn8ktI7jN8or8qs8cu4OutEltktGlZH7h2eSmdAGmKT+AIdjvgo43lTCZQze77iFM
         qyxvAc3uAESy/XTfwwKD4fs3bloN6h93Te02ukgYD/d/udUwIRMlbHqV8xVskWdB1bBb
         fMRmZjDkPX0/PBuDqaKANfRlLDOORrbVD2rHH5l3jls28e3VcxN3OYqD5TAHDOM6ZZ5e
         2ABFeB6rOR39z8zuFOhICVGjjO+pWYl8PgKipBLLs111hrM3c2jdlLJGpd+MPaDoIiwK
         DoMQ==
X-Gm-Message-State: AHPjjUic4H/x57whIVpQtBQgauzFHWc+s29vrn0hnJp3tj71rLbu5SXO
        fMCUPlwI9d+OMv9SYbnpv/MsnA==
X-Google-Smtp-Source: AOwi7QCDFgXHK9k0UHWX1m0SpghaXOPpg+cfdgatt2ojio/59NsrLoAtQGGP8oLYIz6xg9L8tgTinw==
X-Received: by 10.80.183.148 with SMTP id h20mr4317690ede.178.1505906177549;
        Wed, 20 Sep 2017 04:16:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id s12sm884513edd.25.2017.09.20.04.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 04:16:17 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH V2 7/8] MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
Date:   Wed, 20 Sep 2017 13:14:07 +0200
Message-Id: <20170920111408.29711-8-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170920111408.29711-1-jonas.gorski@gmail.com>
References: <20170920111408.29711-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60091
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

Add lookups to provide the appropriate enetX clocks as just "enet" to
the ethernet devices.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index ba5758551c94..2018425fe97e 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -377,6 +377,8 @@ static struct clk_lookup bcm3368_clks[] = {
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
 	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet0),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet1),
 };
 
 static struct clk_lookup bcm6328_clks[] = {
@@ -404,6 +406,7 @@ static struct clk_lookup bcm6338_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6345_clks[] = {
@@ -417,6 +420,7 @@ static struct clk_lookup bcm6345_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6348_clks[] = {
@@ -430,6 +434,8 @@ static struct clk_lookup bcm6348_clks[] = {
 	CLKDEV_INIT(NULL, "usbh", &clk_usbh),
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet_misc),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet_misc),
 };
 
 static struct clk_lookup bcm6358_clks[] = {
@@ -445,6 +451,8 @@ static struct clk_lookup bcm6358_clks[] = {
 	CLKDEV_INIT(NULL, "usbd", &clk_usbd),
 	CLKDEV_INIT(NULL, "spi", &clk_spi),
 	CLKDEV_INIT(NULL, "pcm", &clk_pcm),
+	CLKDEV_INIT("bcm63xx_enet.0", "enet", &clk_enet0),
+	CLKDEV_INIT("bcm63xx_enet.1", "enet", &clk_enet1),
 };
 
 static struct clk_lookup bcm6362_clks[] = {
-- 
2.13.2
