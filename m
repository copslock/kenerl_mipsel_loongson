Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2014 02:30:17 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34063 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010191AbaJCAaP3ckeb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Oct 2014 02:30:15 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so353005pad.36
        for <multiple recipients>; Thu, 02 Oct 2014 17:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KxwsBNz+OFPwgdU9AfU/HSd+wgKHwKfk63CTN79yh5A=;
        b=BGpO2lIs+P5ohnmVtLm4MrzIib/kZCrEfJ53lphHxIuVT25qDliFqqv45XTNG0yBm3
         fhdnSsXxedt36nPEJ1X/VFuOEyevyGNMPqrqWUTmuqKFCySVBaswQESOkvtgvET0gGYk
         RleMwsGs3rL7eNCjSD/gwX/QpQeSQCVTjWp2Q6DndVBsLhY0ZkEgHNtACiBIqR3BM0+S
         kqc2+CDbGEgsotyFKeBordStNiT9HWwQCWPRpVaFyOGoZB0f00cl1QuGv/eNCMO+66kQ
         sWqucvA2dihmBro2kCvSacuxNMPkd67x3FPQ9oLIv9S32OpYOBU5b4bUAkhSjzbXTs4I
         dobg==
X-Received: by 10.66.141.77 with SMTP id rm13mr1022012pab.91.1412296208815;
        Thu, 02 Oct 2014 17:30:08 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id wi10sm4972075pbc.95.2014.10.02.17.30.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Oct 2014 17:30:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: DTS: add a .gitignore file to ignore .dtb
Date:   Thu,  2 Oct 2014 17:29:47 -0700
Message-Id: <1412296187-2370-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42932
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

Build for Broadcom XLP revealed that we are not ignoring DTB files and
that would clobber the git status output. Fix that by adding a
.gitignore file in arch/mips/boot/dts/.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/mips/boot/dts/.gitignore

diff --git a/arch/mips/boot/dts/.gitignore b/arch/mips/boot/dts/.gitignore
new file mode 100644
index 000000000000..b60ed208c779
--- /dev/null
+++ b/arch/mips/boot/dts/.gitignore
@@ -0,0 +1 @@
+*.dtb
-- 
1.9.1
