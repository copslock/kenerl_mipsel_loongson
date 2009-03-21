Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Mar 2009 05:51:03 +0000 (GMT)
Received: from ti-out-0910.google.com ([209.85.142.191]:47180 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S21366539AbZCUFu4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Mar 2009 05:50:56 +0000
Received: by ti-out-0910.google.com with SMTP id d27so817130tid.20
        for <multiple recipients>; Fri, 20 Mar 2009 22:50:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=uoz5f6sF0GoQ+7vkYNoPWgpmBJ6eUnF9PvrvOg2JhOI=;
        b=BzKraesYEEUcyCOZQSt34uHvfsUtv8wnTCW2PzorvVgLn3hVMYlg70M163CHskkokW
         2IZZorXVWzYZuzEe/CNzKT80zsRfBITuttJIp4x9OuxKb50BbmZL1YAzZtnp71D2QLq9
         DBAToOra96VPbfYMS+wNxNDwnbu//SKHLfOns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pQkDCEQiM10jU7QNmZHJWUn74y9Fp8fy9kh1Y/4WVisRQON9NaKv0Wl50BWmo2k59j
         374T5Ps8KVc/SgX8C7B6B6tGJP4MAIEvAvv4pRg//obIIwixyqgOECEPXKg7Op2EFl02
         i5PwEsZEKackqT4ythVk/nUdY06cGBLX869uk=
Received: by 10.110.46.3 with SMTP id t3mr6186245tit.20.1237614653014;
        Fri, 20 Mar 2009 22:50:53 -0700 (PDT)
Received: from localhost.localdomain ([58.212.81.44])
        by mx.google.com with ESMTPS id a14sm458187tia.27.2009.03.20.22.50.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Mar 2009 22:50:52 -0700 (PDT)
From:	Huang Weiyi <weiyi.huang@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH] MIPS: remove duplicated #include
Date:	Sat, 21 Mar 2009 13:50:48 +0800
Message-Id: <1237614648-3840-1-git-send-email-weiyi.huang@gmail.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <weiyi.huang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyi.huang@gmail.com
Precedence: bulk
X-list: linux-mips

Remove duplicated #include in arch/mips/kernel/linux32.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/mips/kernel/linux32.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 1a86f84..49aac6e 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -32,7 +32,6 @@
 #include <linux/module.h>
 #include <linux/binfmts.h>
 #include <linux/security.h>
-#include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/vfs.h>
 #include <linux/ipc.h>
-- 
1.6.0.4
