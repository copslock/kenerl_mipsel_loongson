Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 19:56:15 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61623 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009693AbaIXRzkhjzZu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 19:55:40 +0200
Received: by mail-pa0-f43.google.com with SMTP id kx10so9106376pab.16
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7yLO4/vBWZc3Qp4cX899xnjEyMfrQkhBrtQ+6mqm5Yg=;
        b=l0/0+yOpnGMfQ/gbMb+JTN/JbM7LWXgps4h1Lo5mSy9KZ0w4/IUT9WRVlUvSlW9roz
         aiWJrqtIcePNi4Rp+9FJ87CRdrfVw4pWE4UPFNw8vBDaenf+ZXhJDga/WvmX6HaHRfH+
         aQQlmkjrnX1WqVYzsgn4BxMjJ09lkSxnspADoIeA5N6qoiXIl37jhyVTEIyEoOsTPCXd
         JO3cdV6Hdh/4l8+AtpoOi2W1/WZuSw5zhgArgOmE48/fhUCzL6XTOQUkkjnvSYSx56Uq
         xVhw0Y21WqQlHTnWEQBg2Z5Du2OXEsQeFeb7fJTxAV02d6O+kDCT+lgDFw6oe4kCUzra
         96Eg==
X-Received: by 10.70.96.102 with SMTP id dr6mr15244436pdb.86.1411581334327;
        Wed, 24 Sep 2014 10:55:34 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id iu1sm15303768pbc.53.2014.09.24.10.55.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Sep 2014 10:55:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ganesanr@broadcom.com, jchandra@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: Netlogic: handle modular AHCI builds
Date:   Wed, 24 Sep 2014 10:55:11 -0700
Message-Id: <1411581311-6458-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411581311-6458-1-git-send-email-f.fainelli@gmail.com>
References: <1411581311-6458-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Commits a951440971d0 ("MIPS: Netlogic: Support for XLP3XX on-chip SATA")
and fedfcb1137d2 ("MIPS: Netlogic: XLP9XX on-chip SATA support") added
ahci-init and ahci-init-xlp2 as objects to build when CONFIG_SATA_AHCI
is enabled.

If CONFIG_SATA_AHCI is made modular, these two files will also get built
as modules (obj-m), which will result in the following linking failure:

ERROR: "nlm_set_pic_extra_ack" [arch/mips/netlogic/xlp/ahci-init.ko]
undefined!
ERROR: "nlm_io_base" [arch/mips/netlogic/xlp/ahci-init.ko] undefined!
ERROR: "nlm_nodes" [arch/mips/netlogic/xlp/ahci-init-xlp2.ko] undefined!
ERROR: "nlm_set_pic_extra_ack"
[arch/mips/netlogic/xlp/ahci-init-xlp2.ko] undefined!
ERROR: "xlp_socdev_to_node" [arch/mips/netlogic/xlp/ahci-init-xlp2.ko]
undefined!
ERROR: "nlm_io_base" [arch/mips/netlogic/xlp/ahci-init-xlp2.ko]
undefined!

Just check whether CONFIG_SATA_AHCI is defined for this build, and if
that is the case, add these objects to the list of built-in object
files.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/netlogic/xlp/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index 577889f7275e..6b43af0a34d9 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -4,5 +4,7 @@ ifdef CONFIG_USB
 obj-y				+= usb-init.o
 obj-y				+= usb-init-xlp2.o
 endif
-obj-$(CONFIG_SATA_AHCI)		+= ahci-init.o
-obj-$(CONFIG_SATA_AHCI)		+= ahci-init-xlp2.o
+ifdef CONFIG_SATA_AHCI
+obj-y				+= ahci-init.o
+obj-y				+= ahci-init-xlp2.o
+endif
-- 
1.9.1
