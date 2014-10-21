Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:33:39 +0200 (CEST)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37715 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012001AbaJUE3DhWXJv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:29:03 +0200
Received: by mail-pd0-f170.google.com with SMTP id z10so497668pdj.29
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hiaC4iBtCySvuUsUTurtzGjhw66f68p8dPRgxtHsULc=;
        b=n1fXmp1NY0I0r4OyGEl5SjwllZgLNU5ZpaMEJs9k2HKDCMQ6jer3X3mrsby+czLf20
         QFmiG4tYXb//a9/qryFxihXt6r0LsrpDO1PnJlz5m0UACty1CuEYpT5p5VLHUxDfrPH6
         zPELla03KLXS0EbBCyhHaLyzQdEKPcWCwbFV+G30hUd6Ch3PgEx+o1LDPJAdoQ4pylhS
         7QWV/5XgO3O+LnsLgBV69ddPsfMoyo+1pUHGCnsuM9/CnnmiKosVszlSBMz0GGpKbKmv
         fzIOkMazoqG5P/JkFYvspkkerpnIA2ojBKetHZQy/LFYB0lajhFp1ipuB4WCog0h+fCz
         eyvQ==
X-Received: by 10.68.69.16 with SMTP id a16mr32281500pbu.55.1413865737573;
        Mon, 20 Oct 2014 21:28:57 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:57 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 17/17] MAINTAINERS: Add entry for bcm63xx/bcm33xx UDC gadget driver
Date:   Mon, 20 Oct 2014 21:28:07 -0700
Message-Id: <1413865687-15255-18-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43415
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

This hardware shows up on the newly-supported BCM3384 cable chip, as well
as several old BCM63xx DSL chips.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96608c7..7916665 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,6 +2093,12 @@ S:	Maintained
 F:	arch/arm/mach-bcm/bcm63xx.c
 F:	arch/arm/include/debug/bcm63xx.S
 
+BROADCOM BCM63XX/BCM33XX UDC DRIVER
+M:	Kevin Cernekee <cernekee@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/gadget/udc/bcm63xx_udc.*
+
 BROADCOM BCM7XXX ARM ARCHITECTURE
 M:	Marc Carino <marc.ceeeee@gmail.com>
 M:	Brian Norris <computersforpeace@gmail.com>
-- 
2.1.1
