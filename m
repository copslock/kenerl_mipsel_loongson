Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2011 05:19:22 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:42305 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490965Ab1G0DTP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jul 2011 05:19:15 +0200
Received: by pzk36 with SMTP id 36so1884641pzk.34
        for <multiple recipients>; Tue, 26 Jul 2011 20:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=t93P9qlFU/1QO6XdcV+AZFhSydDB5JhEN3c+qDoO0pU=;
        b=GjwGscypYZCqCOq3w+HXi452VzzDYmIK2r4b13HI87i+Y7uvTPpTH+am/M3DWaY8VU
         2necuT2hMAFiX6Mz96jMNmDoA9Bif+la/+lOw/0HKEoOAlM4orOzihdSwtP7NFAgy7V8
         J4l9B4WZirnNPqQJ+i3duiXG+xqIuiIUMFvQE=
Received: by 10.68.1.170 with SMTP id 10mr9748491pbn.380.1311736747587;
        Tue, 26 Jul 2011 20:19:07 -0700 (PDT)
Received: from sdk (sannin29007.nirai.ne.jp [203.160.29.7])
        by mx.google.com with ESMTPS id k3sm1210725pbj.45.2011.07.26.20.19.04
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:19:06 -0700 (PDT)
Date:   Wed, 27 Jul 2011 12:19:01 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>, joe@perches.com,
        yuasa@linux-mips.org
Subject: MIPS: fix rc32434 pci build error
Message-Id: <20110727121901.9ef04d00.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 30730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19338


arch/mips/pci/pci-rc32434.c: In function 'rc32434_pci_init':
arch/mips/pci/pci-rc32434.c:217:16: error: 'rcrc32434_res_pci_io1' undeclared (first use in this function)
arch/mips/pci/pci-rc32434.c:217:16: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/mips/pci/pci-rc32434.o] Error 1

This problem is included in the following commit.

  commit 28f65c11f2ffb3957259dece647a24f8ad2e241b
  Author: Joe Perches <joe@perches.com>
  Date:   Thu Jun 9 09:13:32 2011 -0700

      treewide: Convert uses of struct resource to resource_size(ptr)

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/pci/pci-rc32434.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci-rc32434.c b/arch/mips/pci/pci-rc32434.c
index 764362c..5f3a69c 100644
--- a/arch/mips/pci/pci-rc32434.c
+++ b/arch/mips/pci/pci-rc32434.c
@@ -215,7 +215,7 @@ static int __init rc32434_pci_init(void)
 	rc32434_pcibridge_init();
 
 	io_map_base = ioremap(rc32434_res_pci_io1.start,
-			      resource_size(&rcrc32434_res_pci_io1));
+			      resource_size(&rc32434_res_pci_io1));
 
 	if (!io_map_base)
 		return -ENOMEM;
-- 
1.7.3.4
