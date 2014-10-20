Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:55:21 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:60645 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011930AbaJTUzBxmM1B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:01 +0200
Received: by mail-pa0-f43.google.com with SMTP id lf10so5944126pab.2
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8T6wcHrs0YplUg7jynimfhQz+s5KaOxsLTerO3zmj5w=;
        b=LMDAomLCfny4GjCdM0qanG0Xl6rOivnvUr6B4dDHsMJhXygYPh6fZ66Ysm+cMH6jxz
         noO/wFDtaSGnZXqlo+14N1W87Pn39rJCvPMNEGxmS+sfgYLndvMK8mWgtThoLFZrUzuP
         jSslMg+SwvsirJTi9HY5893Ht4Mbva0yxVCMHqX+EqTgoumLF9Nj5RyW28WhsViydWr1
         G/VmvqszVCUbV4qdhSOT3OiyBImQV4s/tFhFOx5ToqEf4eaxZnyxK/3ErQkhVP2/EICx
         bgC6SnhdtmRro+W4h/DNi0f9KNVUfUtxK5PK9T/7ZCHMTssFVwYgtTFVUTV5y+ZV6FdN
         u1pA==
X-Received: by 10.66.243.36 with SMTP id wv4mr30377981pac.36.1413838495973;
        Mon, 20 Oct 2014 13:54:55 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.54.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:54:55 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 1/9] tty: serial: bcm63xx: Allow bcm63xx_uart to be built on other platforms
Date:   Mon, 20 Oct 2014 13:54:00 -0700
Message-Id: <1413838448-29464-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43380
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

This device was originally supported on bcm63xx only, but it shows up on
a wide variety of MIPS and ARM chipsets spanning multiple product lines.
Now that the driver has eliminated dependencies on bcm63xx-specific
header files, we can build it on any non-bcm63xx kernel.

Compile-tested on x86, both statically and as a module.  Tested for
functionality on bcm3384 (a new MIPS platform under active development).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 649b784..4a5c0c8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1283,7 +1283,7 @@ config SERIAL_TIMBERDALE
 config SERIAL_BCM63XX
 	tristate "bcm63xx serial port support"
 	select SERIAL_CORE
-	depends on BCM63XX
+	depends on MIPS || ARM || COMPILE_TEST
 	help
 	  If you have a bcm63xx CPU, you can enable its onboard
 	  serial port by enabling this options.
-- 
2.1.1
