Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 11:20:21 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35468 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27038335AbcE2JUUCUFcX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 May 2016 11:20:20 +0200
Received: by mail-wm0-f66.google.com with SMTP id e3so13156421wme.2;
        Sun, 29 May 2016 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEc0mfB3ZM4HYpJo5hxdD7zFkGMFJF1Yp7XKdezlPaA=;
        b=zp0rxIhwbDB7RnSPu5mtbtSR0jDIcA/2XdUFfbIFa9a+/VbkPXadzH4pY//kivH6xK
         XIPBVeQVm7kpC/ceH3ydHFLwhCn2jc5nPqS/DrV2I001CZ33iRKpfHbJo0kaqK9sC4MG
         /DAlk36DFs3za33MZ1qSdUJOfLQ6Ldi5E5tNniPK524+0V7E/h6h4W41oMP9UGUijF5s
         CjTEOa5Ne2bdGsakJGOOl433LDfcqet7IMEeC8hOf8qKaiy8+wf5KQ0d2pBs9nYjBhGm
         ILLSUxXjwgkDcVX7NtWifRhXHfiu0m22p0bSrCkUGOcRwy5QUxZTyEf599Ntu8ok8gXC
         Psmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEc0mfB3ZM4HYpJo5hxdD7zFkGMFJF1Yp7XKdezlPaA=;
        b=C4FfouSEwtE0UwfRFKtSzUe2SZ/taVIb0oR7HPJBdQsWV2BMwpvdBWfwfxDNqEcrr1
         rjat6I0qA+zXL3gj7UpCm6omfXM9JW1v+3bt4L0fTvNytq1eDFLbu7HGBaGKubFDACNj
         4SYcaihl2v3CjB7novOXjEmHBdnRYfwW28HdnOVAHjQGo58exeU1c5kZUwTJYkyPrmyJ
         GhGOrjueGkoVPNayy5VMrM5LXWcBudEWqfagTlS8jF2ZR7yAixKizy7qX9gqXMp5hs2q
         RwZ3xySxXEGjRfDXZwsjr0ssiOLoh3P6laCe3c4WzUYY78tey42JKIL9NnEmJNcXrIXU
         0Jew==
X-Gm-Message-State: ALyK8tI0ElK5G4hx5KOhdtr1snqJgTJM78kujHiHt91TgjCGbsUQX8sHlPXHc+cBxVzluw==
X-Received: by 10.194.3.51 with SMTP id 19mr22994599wjz.57.1464513613938;
        Sun, 29 May 2016 02:20:13 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id n15sm28385818wjr.1.2016.05.29.02.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 29 May 2016 02:20:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, john@phrozen.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] MIPS: ralink: fix spis group pinmux
Date:   Sun, 29 May 2016 11:20:22 +0200
Message-Id: <1464513622-16905-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

pwm function for spis conflicts with uart2 and uart1, fix this by changing it
to pwm_uart2, which reflects the real use of these pins with these pinmux
(2 for pwm and 2 for uart).

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/ralink/mt7620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 251c165..6de3f5b 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -175,7 +175,7 @@ static struct rt2880_pmx_func spi_cs1_grp_mt7628[] = {
 };
 
 static struct rt2880_pmx_func spis_grp_mt7628[] = {
-	FUNC("pwm", 3, 14, 4),
+	FUNC("pwm_uart2", 3, 14, 4),
 	FUNC("util", 2, 14, 4),
 	FUNC("gpio", 1, 14, 4),
 	FUNC("spis", 0, 14, 4),
-- 
2.1.4
