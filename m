Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:36:02 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50110 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007476AbaK1Ed1KfQQp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:27 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so6099922pab.0
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3tzRwWIUaKwQo3IWK56c6OKhOJxzG/yVWQiowATujvQ=;
        b=DgbjlzapL0RkhwkQPmxhH98zwiipv4pJbwrbBN66lPasvw/FNLgzovHLmCBZo8krV6
         x6/9fwbujlKM+R0D41t3AEWlVU9EN+MZyuBIDjCG2/X4nDx1DBvEB2fGIplawbOzAg19
         kLQuofBzm+P2hVcw7vHFk+jQw4331Q+cHNGNf2CfiyP75W8dG/h+JG7WBObWuuvk4VhE
         +X6oBUMzGMUVsDOWv94A149e1Z2vi/k6TdgLNOfpuGpC00TVQPiTLI8bTjiVNVFiUL/Q
         k21daUTl2/AzeuU5NV+8XkKGd53o1Ulnp5lvitxLhwOxNJBkzXvYRnkQiFy24IkG9tit
         6QiQ==
X-Received: by 10.68.229.33 with SMTP id sn1mr69187107pbc.63.1417149200757;
        Thu, 27 Nov 2014 20:33:20 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:20 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 10/16] MIPS: Fall back to the generic restart notifier
Date:   Thu, 27 Nov 2014 20:32:16 -0800
Message-Id: <1417149142-3756-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

If the machine doesn't set its own _machine_restart callback, call the
common do_kernel_restart() instead.  This allows arch-independent reset
drivers from drivers/power/reset/ to be used to reboot the machine.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 07fc5244aed4..cf23ab520701 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -29,6 +29,8 @@ void machine_restart(char *command)
 {
 	if (_machine_restart)
 		_machine_restart(command);
+	else
+		do_kernel_restart(command);
 }
 
 void machine_halt(void)
-- 
2.1.0
