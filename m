Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jan 2011 21:42:00 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.126.187]:53922 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491197Ab1A3Ul5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Jan 2011 21:41:57 +0100
Received: from flocke.fritz.box (p5086E681.dip.t-dialin.net [80.134.230.129])
        by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
        id 0MUASM-1PbMeR3KoE-00QXfx; Sun, 30 Jan 2011 21:41:46 +0100
Received: from stefan by flocke.fritz.box with local (Exim 4.72)
        (envelope-from <stefan@weilnetz.de>)
        id 1Pje5g-0001U6-Qq; Sun, 30 Jan 2011 21:41:44 +0100
From:   Stefan Weil <weil@mail.berlios.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Stefan Weil <weil@mail.berlios.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Arnaud Patard <apatard@mandriva.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Loongson: Fix potentially wrong string handling
Date:   Sun, 30 Jan 2011 21:41:44 +0100
Message-Id: <1296420104-5679-1-git-send-email-weil@mail.berlios.de>
X-Mailer: git-send-email 1.7.2.3
X-Provags-ID: V02:K0:nG43jotu6AUcUO34iS9wi7Ehk4HnpJ3hzy75Q5gd4sj
 jEy5Ja7ZDIVLYnc5lIN/TLb/cNZzHT0l3rFM2Z3FtO1HCkq71B
 mtcvMLjPSQfPbH87WXjCybtr6MOJB+neMqCP2FtWVegte6Ez4T
 oYB+psAv01LhrVN8AFrWvj7MMsbDa9HfEUEY0yzd9bWpKHDHZn
 Y6gVx3LDD0PUKMzGmkdkB9QgbUOc+0FXU9X67ulf5u+we3mIAh
 PDgJFI4CtmHP1
Return-Path: <stefan@weilnetz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weil@mail.berlios.de
Precedence: bulk
X-list: linux-mips

This error was reported by cppcheck:
arch/mips/loongson/common/machtype.c:56: error: Dangerous usage of 'str' (strncpy doesn't always 0-terminate it)

If strncpy copied MACHTYPE_LEN bytes, the destination string str
was not terminated.

The patch adds one more byte to str and makes sure that this byte is
always 0.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: Arnaud Patard <apatard@mandriva.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Weil <weil@mail.berlios.de>
---
 arch/mips/loongson/common/machtype.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 81fbe6b..2efd5d9 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -41,7 +41,7 @@ void __weak __init mach_prom_init_machtype(void)
 
 void __init prom_init_machtype(void)
 {
-	char *p, str[MACHTYPE_LEN];
+	char *p, str[MACHTYPE_LEN + 1];
 	int machtype = MACH_LEMOTE_FL2E;
 
 	mips_machtype = LOONGSON_MACHTYPE;
@@ -53,6 +53,7 @@ void __init prom_init_machtype(void)
 	}
 	p += strlen("machtype=");
 	strncpy(str, p, MACHTYPE_LEN);
+	str[MACHTYPE_LEN] = '\0';
 	p = strstr(str, " ");
 	if (p)
 		*p = '\0';
-- 
1.7.2.3
