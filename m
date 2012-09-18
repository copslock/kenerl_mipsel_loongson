Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2012 11:29:49 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:58921 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903269Ab2IRJ3k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2012 11:29:40 +0200
Received: by bkcji2 with SMTP id ji2so3082621bkc.36
        for <multiple recipients>; Tue, 18 Sep 2012 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xI/qCL12pns6tTxYIHcox1v2nAhdHt1YUOmhHgaLGnM=;
        b=WLtjJi3GjMX3z3we8viOc/kl+gkJK5gurIJHX4P+8nmyOKXnVjOQGAIKc065p56nm5
         ED1YML9MPBvxOeWTxwCyt8kHkhnPlXVLzIRWNI37ZPD2hSGvk60g4mY5D+HlE80c9dP4
         9OQ+08ncmYgdk9DPMxv6zeqrjQdQ0Wr3I+8CslJ02KPINuXCWtF3TAEzwiLeFEVLL0nN
         SZT01XMA/CZpDEIizDsn9wUnRDVV3x7sbswEarvxot3YgW79ODhAi5L/83Q2sHpt3Kml
         012kpHEZN8Kn36iP816ppi4uRlPHe5j2LVM4Ik6c/hawRiFYuImg8DQ2EJ78UnG1pIqO
         DCqQ==
Received: by 10.204.128.214 with SMTP id l22mr5303445bks.86.1347960575001;
        Tue, 18 Sep 2012 02:29:35 -0700 (PDT)
Received: from ixxyvirt.lan (dslb-088-073-033-117.pools.arcor-ip.net. [88.73.33.117])
        by mx.google.com with ESMTPS id g6sm7212223bkg.2.2012.09.18.02.29.33
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Sep 2012 02:29:34 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: hide USE_OF
Date:   Tue, 18 Sep 2012 11:28:54 +0200
Message-Id: <1347960534-5760-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 34524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

b01da9f1 ("MIPS: Prune some target specific code out of prom.c") removed
the generic implementation of device_tree_init, breaking the kernel
build when manually selecting USE_OF.

Hide the config symbol so it can't be selected acidentially anymore.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

There are two alternatives I have thought of:
a) Make HAVE_OF depend on an additional config symbol selected by targets
 supporting OF.
and
b) create a weak implementation of device_tree_init.

Both depend on the assumption that there are/will be targets that support
booting with and without OF, but I don't know if anyone really wants that.

 arch/mips/Kconfig |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 678931c..529fb19 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2408,12 +2408,10 @@ config SECCOMP
 	  If unsure, say Y. Only embedded should say N here.
 
 config USE_OF
-	bool "Flattened Device Tree support"
+	bool
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
-	help
-	  Include support for flattened device tree machine descriptions.
 
 endmenu
 
-- 
1.7.10.4
