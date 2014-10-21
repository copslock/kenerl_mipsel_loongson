Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 00:24:40 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40749 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012091AbaJUWXfwLTks (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 00:23:35 +0200
Received: by mail-pa0-f43.google.com with SMTP id lf10so2330980pab.30
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=++vM6f61ayP+vxtsUgPJva6trijh1+poxateOS346PM=;
        b=QRvC4E6yq4ClqOenlfC+Xps4RYmr1dbDHNxEyxMFuNTTbp9FO/S4uzeUwVmU2EDbGk
         3GVE4JN1Y9wpyAE8o9KeTQYdF9Sj4YG+XpeYwXyzGu6MrlWISj0KpSwn0CTFCgchdG+Z
         F2CXZijGLgas0/QGijYAj8URoIzRMFQSnd7WYyLfgDyLfrVYeSBmNpje9pPVPNd54kFQ
         PBC5IGu7MaXgJw+csjwJp2ZBjlVPCPJqEwN2vI9cIX5gIeEWe98YhklQNS0Yz69/4Z2L
         oAAROJiZx5jn5FeQCe4gLqnD303wq+3ZVlcgyKfoaLYoWGpbTDRGJAGhKINVR5H49kwo
         XKog==
X-Received: by 10.70.48.138 with SMTP id l10mr13974709pdn.139.1413930209402;
        Tue, 21 Oct 2014 15:23:29 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id al4sm12702816pbc.19.2014.10.21.15.23.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 15:23:28 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de,
        geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V3 04/10] tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
Date:   Tue, 21 Oct 2014 15:23:00 -0700
Message-Id: <1413930186-23168-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43440
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

Remove the extra '<' character.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index de95573..b615af2 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -906,5 +906,5 @@ module_init(bcm_uart_init);
 module_exit(bcm_uart_exit);
 
 MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
-MODULE_DESCRIPTION("Broadcom 63<xx integrated uart driver");
+MODULE_DESCRIPTION("Broadcom 63xx integrated uart driver");
 MODULE_LICENSE("GPL");
-- 
2.1.1
