Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:38:15 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:61271 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013709AbaKXXgnDChkc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:36:43 +0100
Received: by mail-pa0-f54.google.com with SMTP id fb1so10572891pad.27
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qh7jP3L1OJAW0Zj3aw4Efhyjbtqdg59GGo4IjvyMv2k=;
        b=D602YW8I0PPX8HDxqTlJvD3PtBEqlqqnMaxFC0RxxP7AJFqBb0tOiNuygLIw/SvGrE
         eBBXe3rZZOcH4F7hJaoVRkU4xTf8mFqSuRVtcJOP1fRG81h+uTkZQua3/vcoi8wDfMK6
         EM8N0zqB0IShsaOIQoMuy80AAvdiBrhVqviFCvw/2rOghO82C0cyTKeO9kWvUazZuQky
         krEOXA4S8SKrINtBXRSXgT2GJeOUGq3PxeR/rpg8taBsnjkRYFwYJxr8nrEQYSNzZ6lr
         j/OBXaKUaWuZTwZRqE9umTPqICY7RVcNnL7L02gakm2K0+NMcC8tuYG88nXHVLXfmDIu
         CFtQ==
X-Received: by 10.66.155.2 with SMTP id vs2mr37521276pab.135.1416872197406;
        Mon, 24 Nov 2014 15:36:37 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id aq1sm13382876pbd.29.2014.11.24.15.36.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 15:36:36 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH V3 6/7] serial: of_serial: Support big-endian register accesses
Date:   Mon, 24 Nov 2014 15:36:21 -0800
Message-Id: <1416872182-6440-7-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44418
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

If the device node has a "big-endian" property and 32-bit registers, tell
the serial driver to use UPIO_MEM32BE instead of UPIO_MEM32.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/of_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 56982da4..efac1dd 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -109,7 +109,8 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			port->iotype = UPIO_MEM;
 			break;
 		case 4:
-			port->iotype = UPIO_MEM32;
+			port->iotype = of_device_is_big_endian(np) ?
+				       UPIO_MEM32BE : UPIO_MEM32;
 			break;
 		default:
 			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
-- 
2.1.0
