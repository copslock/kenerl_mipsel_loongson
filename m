Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:58:47 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:62054 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492396Ab0EDJzf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:35 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119599qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.217.204 with SMTP id hn12mr1746110qcb.100.1272966935417; 
        Tue, 04 May 2010 02:55:35 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:35 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:35 +0800
Message-ID: <x2q180e2c241005040255w292507eej2925a86c27ce921f@mail.gmail.com>
Subject: [PATCH 9/12] add video command line for gdium
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Gdium uses 1024x600 resolution. We need to pass an option to sm501 fb driver.

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 arch/mips/loongson/common/cmdline.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/loongson/common/cmdline.c
b/arch/mips/loongson/common/cmdline.c
index 1a06def..0c33f9f 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -50,4 +50,15 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " root=/dev/hda1");

 	prom_init_machtype();
+
+	/* append machine specific command line */
+	switch (mips_machtype) {
+	case MACH_DEXXON_GDIUM2F10:
+		/* gdium has a 1024x600 screen */
+		if ((strstr(arcs_cmdline, "video=")) == NULL)
+			strcat(arcs_cmdline, " video=sm501fb:1024x600@60");
+		break;
+	default:
+		break;
+	}
 }
-- 
1.5.6.5
