Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 10:19:26 +0100 (CET)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:36108 "EHLO
        mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493049Ab0A0JTV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2010 10:19:21 +0100
Received: by yxe31 with SMTP id 31so4594627yxe.21
        for <multiple recipients>; Wed, 27 Jan 2010 01:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=eT1IWvp64mKmGwW+V+DifXm0cDSHROqm2nIoRIDsgCk=;
        b=HAhUBcEgnKoffABhKyGIORuTvAOlLKoMkl2rAhh29H2qmnD1gx7QlWOTEmcEioyxVA
         Dh3Uupfi2vzIKANdeQZclsspqAMe/Ey0hKWQEJHXLNgz88aktHdntb2coyfZ/vJjdzrr
         84WHD6TjA4mRIrli/+F0OLhr55Z5othx2M9qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=rSOylGmBzNYTLG0G+QDZJyTBh61AHBdmMmoML398R3A5NBYfCjM9HX3pgPVNu4f+eT
         lfM/R8EcQ8meiy0eVopKO+CzJv1YR8Odz1xjfqDmBNDO7NqU9pMbAXOf4znslJgBVzrA
         o0gxoGW10JFZ1NCf6yLDUfu64WnAGHBpJf/QM=
Received: by 10.90.47.6 with SMTP id u6mr2051618agu.22.1264583953583;
        Wed, 27 Jan 2010 01:19:13 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm4111656gxk.2.2010.01.27.01.19.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 01:19:12 -0800 (PST)
Date:   Wed, 27 Jan 2010 18:18:54 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue] MIPS: Alchemy: add missing bracket
Message-Id: <20100127181854.91a24a6f.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17369

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/alchemy/devboards/db1x00/board_setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 416294f..559d9b2 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -30,7 +30,7 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/pm.h
+#include <linux/pm.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_eth.h>
-- 
1.6.6.1
