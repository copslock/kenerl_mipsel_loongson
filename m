Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 17:59:28 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:58160 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492921AbZKPQ6g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 17:58:36 +0100
Received: by pwi15 with SMTP id 15so3498190pwi.24
        for <multiple recipients>; Mon, 16 Nov 2009 08:58:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=g+I0ANITTKDj4NYKv7HgOS5uQy19rzC333WY1z3v9c0=;
        b=NT7P5YcktwQh3stgrl9JL7+1W2FhfzwDZGIU2KPnClEWmRrzW9je1bGn7AL3rF6kbu
         NvmMLP8YJNrOE4fgJlfrXLUNsKrw+jcVWtdThr5Qw/72FsVr+FvgC5Z5pSgC72NFRLGe
         tiJiwpvSTUSqlN+PyekiOcJSu2AnxIOfMuWHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gD0CKvVXeiclNAZBdt3DJwj9ln7w3qMOjlVp5KV/BD6k10FScKe7kRc8iHwLtVB/ZV
         siwI6q7LkL6M9QX4N+nz1gIbpKfXZCwW2JRnUSsCIb2QGKdJ4Kqdh3/uQ2VYSHoBl+mV
         m4/pDJ8fqermyZkwaLfwjRUUUe9hKn72biOdw=
Received: by 10.115.98.29 with SMTP id a29mr15480578wam.142.1258390710167;
        Mon, 16 Nov 2009 08:58:30 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm4349128pxi.5.2009.11.16.08.58.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 08:58:29 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/2] loongson: lemote-2f: add lynloong support
Date:	Tue, 17 Nov 2009 00:58:15 +0800
Message-Id: <f090a0d94d52dd40dadfda678f83ab99f56a86c9.1258390323.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <e52e8ba2b6dee47e44b155693d9237ece9657890.1258390323.git.wuzhangjin@gmail.com>
References: <cover.1258390323.git.wuzhangjin@gmail.com>
 <e52e8ba2b6dee47e44b155693d9237ece9657890.1258390323.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258390323.git.wuzhangjin@gmail.com>
References: <cover.1258390323.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch add a new machtype and kernel options for lynloong, which can
help to select lynloong specific source code and tell users which type
of machine they are using via the /proc/cpuinfo interface.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/bootinfo.h      |    3 ++-
 arch/mips/loongson/common/machtype.c  |    1 +
 arch/mips/loongson/common/serial.c    |    1 +
 arch/mips/loongson/common/uart_base.c |    1 +
 arch/mips/loongson/lemote-2f/reset.c  |    2 ++
 5 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index be28e3b..09eee09 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -68,7 +68,8 @@
 #define MACH_LEMOTE_YL2F89     4
 #define MACH_DEXXON_GDIUM2F10  5
 #define MACH_LEMOTE_NAS        6
-#define MACH_LOONGSON_END      7
+#define MACH_LEMOTE_LL2F       7
+#define MACH_LOONGSON_END      8
 
 extern char *system_type;
 const char *get_system_type(void);
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 6f77a73..2a46b4d 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -23,6 +23,7 @@ static const char *system_types[] = {
 	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
 	[MACH_DEXXON_GDIUM2F10]         "dexxon-gidum-2f-10inches",
 	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
+	[MACH_LEMOTE_LL2F]              "lemote-lynloong-2f",
 	[MACH_LOONGSON_END]             NULL,
 };
 
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index 45601e4..ea29db0 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -46,6 +46,7 @@ static struct plat_serial8250_port uart8250_data[][2] = {
 	[MACH_LEMOTE_YL2F89]            {PORT_M(3), {} },
 	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3), {} },
 	[MACH_LEMOTE_NAS]               {PORT_M(3), {} },
+	[MACH_LEMOTE_LL2F]              {PORT(3), {} },
 	[MACH_LOONGSON_END]             {},
 };
 
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index 1ab7309..275bed6 100644
--- a/arch/mips/loongson/common/uart_base.c
+++ b/arch/mips/loongson/common/uart_base.c
@@ -24,6 +24,7 @@ unsigned long __maybe_unused uart8250_base[] = {
 	[MACH_LEMOTE_YL2F89]	(LOONGSON_LIO1_BASE + 0x3f8),
 	[MACH_DEXXON_GDIUM2F10]	(LOONGSON_LIO1_BASE + 0x3f8),
 	[MACH_LEMOTE_NAS]	(LOONGSON_LIO1_BASE + 0x3f8),
+	[MACH_LEMOTE_LL2F]	(LOONGSON_PCIIO_BASE + 0x2f8),
 	[MACH_LOONGSON_END]	0,
 };
 EXPORT_SYMBOL(uart8250_base);
diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson/lemote-2f/reset.c
index 980299d..44bb984 100644
--- a/arch/mips/loongson/lemote-2f/reset.c
+++ b/arch/mips/loongson/lemote-2f/reset.c
@@ -142,6 +142,7 @@ void mach_prepare_reboot(void)
 	switch (mips_machtype) {
 	case MACH_LEMOTE_FL2F:
 	case MACH_LEMOTE_NAS:
+	case MACH_LEMOTE_LL2F:
 		fl2f_reboot();
 		break;
 	case MACH_LEMOTE_ML2F7:
@@ -160,6 +161,7 @@ void mach_prepare_shutdown(void)
 	switch (mips_machtype) {
 	case MACH_LEMOTE_FL2F:
 	case MACH_LEMOTE_NAS:
+	case MACH_LEMOTE_LL2F:
 		fl2f_shutdown();
 		break;
 	case MACH_LEMOTE_ML2F7:
-- 
1.6.2.1
