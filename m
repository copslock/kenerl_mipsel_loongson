Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:55:56 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59559 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011956AbaJTUzGeK2DL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:06 +0200
Received: by mail-pd0-f173.google.com with SMTP id g10so5708297pdj.32
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qnDrejLbytQeEVRSYBakfuYYzeGlI6nG53tVkDRkqdo=;
        b=itx6vcm/M7E0Vir2fYZKF6xnvz32toEWQIs18VVjVwl1CgA0XMe9DOkvRBN4qpZ/rg
         ghYLUEjOac4p/nZ+BZ+rCPdpUyrk4RYwuhQ6IS7ILb8yvIxCwMYOdqzUq49KlkIYC9Ky
         yj2pdzC8KVy1brWdo4ohr7vUxGeq/Dg5zek43n9UXyyPGMKmm+r6XCnWxpjSAWzPaXgc
         6Pvv8IYFH9KwYeYoW7AEDWunvFjJLTr9uLcwFAaYYQYey7ctMVSMjHFkXF9IdsNM0T53
         6QSEWQyIvAmawfQxm7DT9z5cahlYTrdBTMEBGt0uWq8WGnFV4b8juEmd/skSNrDtyuXi
         hOCw==
X-Received: by 10.68.192.196 with SMTP id hi4mr29856266pbc.50.1413838499228;
        Mon, 20 Oct 2014 13:54:59 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.54.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:54:58 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 3/9] tty: serial: bcm63xx: Fix typo in MODULE_DESCRIPTION
Date:   Mon, 20 Oct 2014 13:54:02 -0700
Message-Id: <1413838448-29464-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43382
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
index 2315190..a70910e 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -905,5 +905,5 @@ module_init(bcm_uart_init);
 module_exit(bcm_uart_exit);
 
 MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
-MODULE_DESCRIPTION("Broadcom 63<xx integrated uart driver");
+MODULE_DESCRIPTION("Broadcom 63xx integrated uart driver");
 MODULE_LICENSE("GPL");
-- 
2.1.1
