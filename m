Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:33:22 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39254 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012000AbaJUE3CZQEVo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:29:02 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so509191pad.36
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a1thbJDxDOKqe72Rmpeca7q9voYmJ5OXkiQ9CLqavTU=;
        b=cpK8cngFISzNVIvimdEDkAWnMASAk4dUg+61AZiN+9NfShsElCap43QtTWG8xUOPub
         ctTx45KpUdK/SCGIOjecLz45Ow2d1OSc7xkL1i2MC+lUWM0VNUv2Pc0+VC52+E1a9RFT
         kwtAP7xExB5Lba/jPCROK81RtSAnPBdZ9PheV5fn/voR2JeVD5PHwgEhspwFcNRlqtQD
         xhClYM9mwkaRSfomWYUcZUeOgQOnlR4N8AcQ/aleRUiAmuOqxjhh0RDysjL2Ra25YsM3
         pA9y8WldW36cQ6DrJGqLcldm4aL57CKdWrs+cvL0UqJQYuvi+lYjxgePC2DaIaM5RdeL
         vmSA==
X-Received: by 10.68.111.161 with SMTP id ij1mr567150pbb.10.1413865736335;
        Mon, 20 Oct 2014 21:28:56 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:55 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 16/17] MAINTAINERS: Add entry for BCM33xx cable chips
Date:   Mon, 20 Oct 2014 21:28:06 -0700
Message-Id: <1413865687-15255-17-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43414
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

Add myself as a maintainer for the new BCM3384 board support code.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d483627..96608c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2069,6 +2069,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git
 S:	Maintained
 N:	bcm2835
 
+BROADCOM BCM33XX MIPS ARCHITECTURE
+M:	Kevin Cernekee <cernekee@gmail.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/bcm3384/*
+F:	arch/mips/include/asm/mach-bcm3384/*
+F:	arch/mips/kernel/*bmips*
+
 BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	linux-arm-kernel@lists.infradead.org
-- 
2.1.1
