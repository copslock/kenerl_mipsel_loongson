Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2017 16:28:43 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:49493
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992128AbdJ2P1sFnf17 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2017 16:27:48 +0100
Received: by mail-wm0-x243.google.com with SMTP id b189so11148526wmd.4;
        Sun, 29 Oct 2017 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=itb/NrkIHkmkXEzlCAALFd/ElexFYS9abSQjfSU6u88=;
        b=L/tpAJ2vHn3osySgFKp91DacxTutL9dVohj+8lZCbN5OCSOAhWhtMZAydvTcMYKgyU
         o/zYPBohftWtir0GsF+4AxDIGRry9yN81ZHavF0qK1l1IpxVjMmHnyZf+xthrtsWTEoP
         QAKPeOY403yPI6E/oM/RigRKqrHnCnaAm0jkikN81cEJ/WyjcsuVyy0pqsanMASr9xUn
         rjLdvLYlhQ/2r3KJ30Gm1cMViF27l54L8tZwT976BeLrTiV7d3RKPgl8Kr5xDprOmDoU
         KAl2FIqQNRyyHcOLpJSSOFg7bfd45g1g4VMBXt/R6eD8XelkeaqeRwJARtjKQ1QwGB3q
         VRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=itb/NrkIHkmkXEzlCAALFd/ElexFYS9abSQjfSU6u88=;
        b=n9vYVH3DmHLrD3prU9MtL3076VKIxBzY0xgEX8njjr1gmRfQkUVl3qgoJEDIySbUt0
         1DSnK4ukE2Zwc/ls7UEPBZdih0gdJv5WQZjZWUJ5CeOGDNucx6xwvhdMvRIh/CHpIqya
         n6lUW4Jmku0tzrjPyizgc5U8+MwYxjnkqsAtVXxi/PAZjt2aNFAn8nbhVMHunSdnFeyv
         +HgV0s9oQ3d4o/RnJiTU2o4MRqdYip0U46BB9MFm21Ygwmyg+bZA/9IFGAIpogTdnoIj
         dNcgs6QGX9oaX/KNgzH+QjtlMoKGw5TPTChkbMTC7Ra2C9i34iocQZUFCKi+BcfqonOf
         wbYA==
X-Gm-Message-State: AMCzsaXM1R40gtnvRWj50BhdHBdlFEXxgBuakzKDo1IB9+IIwmZ3pfxC
        dKmrpc7RXXp0+4eS2FHk/IbCQg==
X-Google-Smtp-Source: ABhQp+T/nSOid0Hg/B8XuF5e0V6lNtVbIkZg2mtxrymd0XboQn3sm6lsfGymjZz70A/bIsgISPdx3A==
X-Received: by 10.28.109.23 with SMTP id i23mr1599019wmc.32.1509290862704;
        Sun, 29 Oct 2017 08:27:42 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id m26sm12498532wrb.81.2017.10.29.08.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Oct 2017 08:27:42 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH 2/3] MIPS: AR7: ensure that serial ports are properly set up
Date:   Sun, 29 Oct 2017 16:27:20 +0100
Message-Id: <20171029152721.6770-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171029152721.6770-1-jonas.gorski@gmail.com>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60578
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

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

without UPF_FIXED_TYPE, the data from the PORT_AR7 uart_config entry is
never copied, resulting in a dead port.

Fixes: 154615d55459 ("MIPS: AR7: Use correct UART port type")
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
[jonas.gorski: add Fixes tag]
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/ar7/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index f2c9f90c5f13..4674f1efbe7a 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -575,6 +575,7 @@ static int __init ar7_register_uarts(void)
 	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
+	uart_port.flags		= UPF_FIXED_TYPE;
 	uart_port.regshift	= 2;
 
 	uart_port.line		= 0;
-- 
2.13.2
