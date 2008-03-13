Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 05:40:15 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:30907 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28581011AbYCMFkN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Mar 2008 05:40:13 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m2D5e6QB002803
	for <linux-mips@linux-mips.org>; Wed, 12 Mar 2008 22:40:06 -0700 (PDT)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Mar 2008 22:40:05 -0700
Received: from [128.224.162.181] ([128.224.162.181]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 13 Mar 2008 06:40:02 +0100
Message-ID: <47D8BDDC.9010607@windriver.com>
Date:	Thu, 13 Mar 2008 13:38:36 +0800
From:	"tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] MT-VPE : Fix the usage of kmalloc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2008 05:40:03.0147 (UTC) FILETIME=[AF6DE9B0:01C884CC]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

The return value of kmalloc() should be check, otherwise it is potential
risk.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 vpe.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index c06eb81..35767de 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -885,6 +885,10 @@ static int vpe_elfload(struct vpe * v)
        }
 
        v->load_addr = alloc_progmem(mod.core_size);
+#ifndef CONFIG_MIPS_VPE_LOADER_TOM
+       if (!(v->load_addr))
+               return -ENOMEM;
+#endif
        memset(v->load_addr, 0, mod.core_size);
 
        printk("VPE loader: loading to %p\n", v->load_addr);
