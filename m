Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:47:46 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:56309 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013490AbaKLIrOUlhmR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:14 +0100
Received: by mail-pa0-f48.google.com with SMTP id ey11so12448850pad.7
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+S6p5WZ8HPRVXCcFKj/jg6bJm9jGcz4n1qkms9grIrY=;
        b=sR1cw2F7WwFbFHtHkOKkTsjc2PtTpmvSFpvquANkb7+1193avRTsNi6bt/mqGfeTM9
         D6hT2VnP8ZMMOvcJ/bD2SRDxHtHlZuPXh1GanPNZ12pWWOe0JXlWqnWCovsuDfNjN1fc
         0atbI/qQUS//zESVyTLsjLuznnPnM4LF7bAdhdCu4057FYGJhry0dcyCVZkPfHUWwUFK
         JCYLosH+gVIdmF+UavK+gGsSDtLMdgYJJYyXe+vCBSsUORl6tcxLubHDz5wskR9VbQ13
         oAqxOgvztHPFwtsOET3F9BA9U4Qn6WdKCXjCVroY/PDFM1swjyjw+rR9iJiGRX3VAY29
         Jg7Q==
X-Received: by 10.66.122.2 with SMTP id lo2mr46597794pab.9.1415782028347;
        Wed, 12 Nov 2014 00:47:08 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:07 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 2/8] serial: core: Add big_endian flag
Date:   Wed, 12 Nov 2014 00:46:27 -0800
Message-Id: <1415781993-7755-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44030
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

Add a big_endian flag alongside membase, regshift, and iotype.  Most
drivers currently use readl/writel, but if it is necessary to support
a BE SoC, the driver can check this field to see which MMIO accessor
functions to use.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 21c2e05..ae372f4 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -138,7 +138,7 @@ struct uart_port {
 	unsigned char		x_char;			/* xon/xoff char */
 	unsigned char		regshift;		/* reg offset shift */
 	unsigned char		iotype;			/* io access style */
-	unsigned char		unused1;
+	unsigned char		big_endian;		/* BE registers */
 
 #define UPIO_PORT		(0)
 #define UPIO_HUB6		(1)
-- 
2.1.1
