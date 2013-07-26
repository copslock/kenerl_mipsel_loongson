Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jul 2013 16:04:12 +0200 (CEST)
Received: from mail-qe0-f41.google.com ([209.85.128.41]:41477 "EHLO
        mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824790Ab3GZOEGUtWN6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jul 2013 16:04:06 +0200
Received: by mail-qe0-f41.google.com with SMTP id b4so1014592qen.0
        for <linux-mips@linux-mips.org>; Fri, 26 Jul 2013 07:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=sVXS2zcJ+wZBOdBsmCsdRtOC88JNaTC04QwmgCCcEFI=;
        b=jwQLpuy+UjfrZbDnGfqX0FCHWf1qqbGvaDHdUpJFYxHIbMiOtL/iZz0exs3/TP7QkQ
         txPBXMdBR+xmySbbPKkfLL9KY6fzi6+rFmwNtLQ7/rj7Pb3SwRrPR6DiA2FUt3kq8wUA
         1xkwe1TMBkNeZB02DJkC6og9VV8c/0hqCCYB/YjRw7sMN2CGVPBBI2gojfuavL3TcYd7
         JRZPzKdEii4sXa8tBwLtnsFRBSMtEQkG9mIyERI9ZQcECFIDzcMCaDyG+9YsCsxjlcDy
         beK1LkqStDE+srw7Y0C5/2CBPWT9P2CF202pZ8Q+d9ZMFw/9rqsHsvvSTOPY8n02jloM
         wZsA==
X-Received: by 10.224.134.194 with SMTP id k2mr6707321qat.50.1374847439818;
        Fri, 26 Jul 2013 07:03:59 -0700 (PDT)
Received: from ixro-alexj.ixiacom.com ([205.168.23.154])
        by mx.google.com with ESMTPSA id g9sm221759qaz.4.2013.07.26.07.03.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 07:03:59 -0700 (PDT)
From:   Alexandru Juncu <alexj@rosedu.org>
To:     ralf@linux-mips.org, jchandra@broadcom.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandru Juncu <alexj@rosedu.org>
Subject: [PATCH] MIPS:Netlogic: Remove redundant value in operation.
Date:   Fri, 26 Jul 2013 17:03:35 +0300
Message-Id: <1374847415-28449-1-git-send-email-ajuncu@ixiacom.com>
X-Mailer: git-send-email 1.8.1.2
X-Gm-Message-State: ALoCoQnwbaYkDzA8t6ZQq8x2D4ZjPGf42tC3XIKkZgzAtgeHVbZenq86I0MuFKGouTHUuUh0uA2d
Return-Path: <alexj@rosedu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexj@rosedu.org
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

From: Alexandru Juncu <alexj@rosedu.org>

Removed parameters checked twice in logical OR operation.
Suggested by coccinelle and manually verified.

Signed-off-by: Alexandru Juncu <alexj@rosedu.org>
---
 arch/mips/netlogic/xlp/usb-init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/xlp/usb-init.c b/arch/mips/netlogic/xlp/usb-init.c
index ef3897e..d5378ef 100644
--- a/arch/mips/netlogic/xlp/usb-init.c
+++ b/arch/mips/netlogic/xlp/usb-init.c
@@ -75,8 +75,7 @@ static void nlm_usb_intr_en(int node, int port)
 	port_addr = nlm_get_usb_regbase(node, port);
 	val = nlm_read_usb_reg(port_addr, USB_INT_EN);
 	val = USB_CTRL_INTERRUPT_EN  | USB_OHCI_INTERRUPT_EN |
-		USB_OHCI_INTERRUPT1_EN | USB_CTRL_INTERRUPT_EN	|
-		USB_OHCI_INTERRUPT_EN | USB_OHCI_INTERRUPT2_EN;
+		USB_OHCI_INTERRUPT1_EN | USB_OHCI_INTERRUPT2_EN;
 	nlm_write_usb_reg(port_addr, USB_INT_EN, val);
 }
 
-- 
1.8.1.2
