Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 03:43:35 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55217 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006780AbaKXClMBagGk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 03:41:12 +0100
Received: by mail-pa0-f52.google.com with SMTP id eu11so8561175pac.25
        for <multiple recipients>; Sun, 23 Nov 2014 18:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C7ISku7C2fep5Hy/oaBiXaptj1X0h9pUASRIRsqrjWA=;
        b=nfLYBvXW0efutYCjV549qgL4WTODF4ui8WbYG5D7ini6tvyZR9H8OpSpGmB0Hfj2iS
         ICJoIycSRUo9ErZ3Pb9Mb3znjYqGWpxxoW3hafdcEmdb5NxMTNSOBOke6ghTgUt6OBnO
         8L5VfSlgjk7n+0dBTf/BV7zJMUSrtuKhj/fuSnECoW7hINJGcwDcVWmRNScCivBz/dXK
         Notga4jsyFDBwsDR5L5zWjuFVOj6ZsIQFGZnNLjvYt0mowa9DpnMQtkQUh3kuabR/b++
         3o7b+zmTwDM/A7N6c6oUAGSWCzmwM8OiH1r983hcaEuQrvcNHwcwJ1XSVdibmXYma2D7
         16Qw==
X-Received: by 10.70.61.136 with SMTP id p8mr28567149pdr.98.1416796866390;
        Sun, 23 Nov 2014 18:41:06 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id ml5sm10930673pab.32.2014.11.23.18.41.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Nov 2014 18:41:05 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 09/11] MIPS: Fall back to the generic restart notifier
Date:   Sun, 23 Nov 2014 18:40:44 -0800
Message-Id: <1416796846-28149-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44362
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
2.1.1
