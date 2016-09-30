Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2016 16:17:55 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34672 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbcI3ORrtwdTN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2016 16:17:47 +0200
Received: by mail-pf0-f196.google.com with SMTP id 21so5080021pfy.1;
        Fri, 30 Sep 2016 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0S3/incC98t1qjOnTFHMWnqeHw77vzyLUvE+pYxQNg8=;
        b=J3PX/S2kpQsROOZKX1NNjsgMBYm9i+ffiiJFX3Xq498bkaqiEYOPLB+fc4xwOKbVVB
         w0I/twviS1JVBfL/o1mxrE7IZxZm1dUUkdK6jmwpQTfmdbBIeiGLAa3CEqp2cZuwYES/
         Hw2avsc+dO68A9G7QHciI6GeDCvBhAStLS5YiBeqW+d5erm9T6eUe7VuQ2XNedPIswCe
         UJwT5zjpC7ukmJ+k8uemo4aLbv2pLhnd0sUa9HpweTHodSz0NV7q25AaqmZZ9GMzeTff
         242QATqDKs7OVjD40rcJ+5kONxdC7AnR5I4SoASR5faWfzvF3ahkGu7jPrYvPrYZMwVU
         eUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0S3/incC98t1qjOnTFHMWnqeHw77vzyLUvE+pYxQNg8=;
        b=kqY9BkLoK4lvL60+PshcXwicWGSOS/zbja6/+1MmxsqSyzpICFFdyubHBLS1NeT/VG
         SB1d46PltNZk6YAikWbZrPl3ZAt0XhbbjW31FFsTU6YnhioNLVac3okZbkSCt4cU/HcP
         wWsgwUe61YJEx+362DoOkvccodV/zqbK1igtBV3M6L+PaA/CdK7ClzoiOzjx33lgp6q+
         R289mxT2X0URChVdTEQ1J8mdsSfkgdZ704UoqEzsb8w30AY2Ur6aY4Y5UXWA/TClp470
         uJbkwhIMfIOuvnkfy+iJ9XeOmUDyA6RYLJka4Wawk6AlLWQ+2Q1o3DywvIP/odS5Zo3L
         f6jA==
X-Gm-Message-State: AA6/9Rke8qzYfi4a3i25vS8coST0yQs/L0ZQtsPFW3dQ94MQTailhK6M1qRy8Va3cn6zDA==
X-Received: by 10.98.150.157 with SMTP id s29mr11966359pfk.3.1475245061631;
        Fri, 30 Sep 2016 07:17:41 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id w9sm28452595pfg.34.2016.09.30.07.17.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 30 Sep 2016 07:17:41 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Support APPENDED_DTB
Date:   Fri, 30 Sep 2016 23:17:34 +0900
Message-Id: <20160930141734.3311-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.10.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Use appended DTB when available.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/bmips/setup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 6776042679dd..895baf517db8 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/libfdt.h>
 #include <linux/smp.h>
 #include <asm/addrspace.h>
 #include <asm/bmips.h>
@@ -150,6 +151,8 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = freq;
 }
 
+extern const char __appended_dtb;
+
 void __init plat_mem_setup(void)
 {
 	void *dtb;
@@ -159,6 +162,11 @@ void __init plat_mem_setup(void)
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 
+#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
+	if (!fdt_check_header(&__appended_dtb))
+		dtb = (void *)&__appended_dtb;
+	else
+#endif
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
-- 
2.10.0
