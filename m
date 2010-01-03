Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 06:48:23 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:45433 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491146Ab0ACFsT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 06:48:19 +0100
Received: by ywh12 with SMTP id 12so15230255ywh.21
        for <multiple recipients>; Sat, 02 Jan 2010 21:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=pE6Q5w/mXZYicjgMDza343474hzNYfc77DE58tiQNQc=;
        b=MzqmQSy9OZploWvy4C/Drlf3zUkp5H60HkULkleNwoE6X5L4+go4G+6zSnqle2yAlu
         ZoHIEloygHYZYCbJgate46XYJfu/6ldeohUeHebNDFcPIJu6GUfSeJVYqVD0A6VdkS0a
         Tc5hO/WCe7QgRX7Rc9EWr5dK2bgjN3ChSuIJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=LvNH3681HLToApL+it5T8r3/zQJYUxN8fw9bGjBD1o+raKbaIbkDpt/c4N0AdNg5uJ
         FfojG/73omAO1WetgdtLlUfoDijKmFguA+4wNtD58UWMm2BgqNIsDVJu1sw5+QhxS479
         Cig+IWMh9RsoMt+EbmmeJbTiCDSk6n1N3nj50=
Received: by 10.91.159.2 with SMTP id l2mr2828701ago.73.1262497692074;
        Sat, 02 Jan 2010 21:48:12 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm8384121gxk.14.2010.01.02.21.48.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 21:48:11 -0800 (PST)
Date:   Sun, 3 Jan 2010 14:47:34 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: remove unnecessary "Linux started"
Message-Id: <20100103144734.b0e10cf2.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1843

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/mipssim/sim_setup.c    |    4 ----
 arch/mips/mti-malta/malta-init.c |    1 -
 arch/mips/powertv/init.c         |    2 --
 3 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/mips/mipssim/sim_setup.c b/arch/mips/mipssim/sim_setup.c
index 0824f6a..55f22a3 100644
--- a/arch/mips/mipssim/sim_setup.c
+++ b/arch/mips/mipssim/sim_setup.c
@@ -49,9 +49,6 @@ void __init plat_mem_setup(void)
 	set_io_port_base(0xbfd00000);
 
 	serial_init();
-
-	pr_info("Linux started...\n");
-
 }
 
 extern struct plat_smp_ops ssmtc_smp_ops;
@@ -60,7 +57,6 @@ void __init prom_init(void)
 {
 	set_io_port_base(0xbfd00000);
 
-	pr_info("\nLINUX started...\n");
 	prom_meminit();
 
 #ifdef CONFIG_MIPS_MT_SMP
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index f1b14c8..414f0c9 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -355,7 +355,6 @@ void __init prom_init(void)
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
-	pr_info("\nLINUX started...\n");
 	prom_init_cmdline();
 	prom_meminit();
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index de0e46a..0afe227 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -117,8 +117,6 @@ void __init prom_init(void)
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
-	pr_info("\nLINUX started...\n");
-
 	if (prom_argc == 1)
 		strlcat(arcs_cmdline, prom_argv, COMMAND_LINE_SIZE);
 
-- 
1.6.5.7
