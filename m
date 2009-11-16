Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 17:59:02 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:60456 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493433AbZKPQ6e (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 17:58:34 +0100
Received: by pxi3 with SMTP id 3so191879pxi.22
        for <multiple recipients>; Mon, 16 Nov 2009 08:58:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=I7KvDe5c3IPUK6TUWJvF1/9A7/d2xUtHS4me+ZOYzWQ=;
        b=JjPXwG1CIb8bHyleqVKNdaz6b8c6tUrEpiaX8/0TVEROPSHUHmaIDYpNYbeOfz+nIK
         UGatt82oHMuj0GspaSDTPlqIv1koi7uwh+HfJ0/8lwbg+U402idEVU1lkDlz8QBSId30
         OuMdOP4elloHbp2l5AD0487mKb9/1ZEJxd4oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AUWxdDUkfGBCPDYpG4U808o2UdoS80/TtqVcPSFyzE1veTDPMi1GNt+DiSjtNRauq+
         ak7G8Bp6qPdmRzG75ldFQv+PGAAQ+CLA3AruiFW2zAvB1nLvywdDmSCG6O68mOPWJFwu
         k8WCx5wyeMLiY23F/5LLdQVzES4FD4yo1W9uU=
Received: by 10.115.133.38 with SMTP id k38mr10172731wan.120.1258390707124;
        Mon, 16 Nov 2009 08:58:27 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm4349128pxi.5.2009.11.16.08.58.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 08:58:26 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/2] loongson: lemote-2f: add NAS support
Date:	Tue, 17 Nov 2009 00:58:14 +0800
Message-Id: <e52e8ba2b6dee47e44b155693d9237ece9657890.1258390323.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1258390323.git.wuzhangjin@gmail.com>
References: <cover.1258390323.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258390323.git.wuzhangjin@gmail.com>
References: <cover.1258390323.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch add support to Lemote's Loongson-2F based network attached
system.

The kernel support to this machine is almost the same as fuloong2f, the
only difference is that it use the serial port provided by loongson2f
processor as yeeloong2f does.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/bootinfo.h      |    3 ++-
 arch/mips/loongson/common/machtype.c  |    1 +
 arch/mips/loongson/common/serial.c    |    1 +
 arch/mips/loongson/common/uart_base.c |    1 +
 arch/mips/loongson/lemote-2f/reset.c  |    2 ++
 5 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 07d4115..be28e3b 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -67,7 +67,8 @@
 #define MACH_LEMOTE_ML2F7      3
 #define MACH_LEMOTE_YL2F89     4
 #define MACH_DEXXON_GDIUM2F10  5
-#define MACH_LOONGSON_END      6
+#define MACH_LEMOTE_NAS        6
+#define MACH_LOONGSON_END      7
 
 extern char *system_type;
 const char *get_system_type(void);
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 87b502f..6f77a73 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -22,6 +22,7 @@ static const char *system_types[] = {
 	[MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
 	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
 	[MACH_DEXXON_GDIUM2F10]         "dexxon-gidum-2f-10inches",
+	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
 	[MACH_LOONGSON_END]             NULL,
 };
 
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index dc6488c..45601e4 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -45,6 +45,7 @@ static struct plat_serial8250_port uart8250_data[][2] = {
 	[MACH_LEMOTE_ML2F7]             {PORT_M(3), {} },
 	[MACH_LEMOTE_YL2F89]            {PORT_M(3), {} },
 	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3), {} },
+	[MACH_LEMOTE_NAS]               {PORT_M(3), {} },
 	[MACH_LOONGSON_END]             {},
 };
 
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index c3db78a..1ab7309 100644
--- a/arch/mips/loongson/common/uart_base.c
+++ b/arch/mips/loongson/common/uart_base.c
@@ -23,6 +23,7 @@ unsigned long __maybe_unused uart8250_base[] = {
 	[MACH_LEMOTE_ML2F7]	(LOONGSON_LIO1_BASE + 0x3f8),
 	[MACH_LEMOTE_YL2F89]	(LOONGSON_LIO1_BASE + 0x3f8),
 	[MACH_DEXXON_GDIUM2F10]	(LOONGSON_LIO1_BASE + 0x3f8),
+	[MACH_LEMOTE_NAS]	(LOONGSON_LIO1_BASE + 0x3f8),
 	[MACH_LOONGSON_END]	0,
 };
 EXPORT_SYMBOL(uart8250_base);
diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson/lemote-2f/reset.c
index 0458a1c..980299d 100644
--- a/arch/mips/loongson/lemote-2f/reset.c
+++ b/arch/mips/loongson/lemote-2f/reset.c
@@ -141,6 +141,7 @@ void mach_prepare_reboot(void)
 {
 	switch (mips_machtype) {
 	case MACH_LEMOTE_FL2F:
+	case MACH_LEMOTE_NAS:
 		fl2f_reboot();
 		break;
 	case MACH_LEMOTE_ML2F7:
@@ -158,6 +159,7 @@ void mach_prepare_shutdown(void)
 {
 	switch (mips_machtype) {
 	case MACH_LEMOTE_FL2F:
+	case MACH_LEMOTE_NAS:
 		fl2f_shutdown();
 		break;
 	case MACH_LEMOTE_ML2F7:
-- 
1.6.2.1
