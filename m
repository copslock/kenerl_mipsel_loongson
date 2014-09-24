Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 19:55:56 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58755 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009681AbaIXRzjfiPhf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 19:55:39 +0200
Received: by mail-pd0-f173.google.com with SMTP id y10so9050537pdj.18
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zv9VMJ0UYIBWql6AQUbdl2l2HjHkgKqvPoY79QBBbE8=;
        b=mWmxF2Ca//q/JCbKtXtdTpVwGUawYZ2EbxiIFNPy5k6Er7j8SJOxGEVDigclVFR2fZ
         qQHOAxQovCce/q3kMrE7E93h/1IZeuzbpv+bdWnUGNNGPiXHkMcFRXzHZpNtqhJQpjrZ
         hiA7lMdsOTr736Wc6tpk1HrGKSmbRdLC7ECnSSlVAGC+QYf/CiVTwAJSA2a9vaxWbqDN
         6uPjjPI4L56xFNiwaTkgqIXF5JLfhCspvw2wWZMGcB+krcng7+nJDRw5f50Owh2AXtzJ
         /DGl3XTEfXIW+aGFXQ1N2FxDGsBeVYM/MeWmVe8H0A0BRxY8EG2gbAecgRZO6g7kupjr
         IKeA==
X-Received: by 10.70.87.169 with SMTP id az9mr14717864pdb.63.1411581333175;
        Wed, 24 Sep 2014 10:55:33 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id iu1sm15303768pbc.53.2014.09.24.10.55.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Sep 2014 10:55:32 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ganesanr@broadcom.com, jchandra@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] MIPS: Netlogic: handle modular USB case
Date:   Wed, 24 Sep 2014 10:55:10 -0700
Message-Id: <1411581311-6458-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1411581311-6458-1-git-send-email-f.fainelli@gmail.com>
References: <1411581311-6458-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42771
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

Commit 1004165f346a ("MIPS: Netlogic: USB support for XLP") and then
commit 9eac3591e78b ("MIPS: Netlogic: Add support for USB on XLP2xx")
added usb-init and usb-init-xlp2 as objects to build when CONFIG_USB is
enabled.

If CONFIG_USB is made modular, these two files will also get built as
modules (obj-m), which will result in the following linking failure:

ERROR: "nlm_io_base" [arch/mips/netlogic/xlp/usb-init.ko] undefined!
ERROR: "nlm_nodes" [arch/mips/netlogic/xlp/usb-init-xlp2.ko] undefined!
ERROR: "nlm_set_pic_extra_ack" [arch/mips/netlogic/xlp/usb-init-xlp2.ko]
undefined!
ERROR: "xlp_socdev_to_node" [arch/mips/netlogic/xlp/usb-init-xlp2.ko]
undefined!
ERROR: "nlm_io_base" [arch/mips/netlogic/xlp/usb-init-xlp2.ko]
undefined!

Just check whether CONFIG_USB is defined for this build, and if that is
the case, add these objects to the list of built-in object files.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/netlogic/xlp/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index be358a8050c5..577889f7275e 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,6 +1,8 @@
 obj-y				+= setup.o nlm_hal.o cop2-ex.o dt.o
 obj-$(CONFIG_SMP)		+= wakeup.o
-obj-$(CONFIG_USB)		+= usb-init.o
-obj-$(CONFIG_USB)		+= usb-init-xlp2.o
+ifdef CONFIG_USB
+obj-y				+= usb-init.o
+obj-y				+= usb-init-xlp2.o
+endif
 obj-$(CONFIG_SATA_AHCI)		+= ahci-init.o
 obj-$(CONFIG_SATA_AHCI)		+= ahci-init-xlp2.o
-- 
1.9.1
