Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 08:38:20 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:64720 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492006AbZKVHiN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Nov 2009 08:38:13 +0100
Received: by pzk35 with SMTP id 35so3327558pzk.22
        for <multiple recipients>; Sat, 21 Nov 2009 23:38:05 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8hFOXkZEEv74cczBky5s7ezplDUM6mIimLiEzcR3qjw=;
        b=UT9HexokBgw9HxPVFWcclCWJ5jVnWCbSLFcfk6hC6zD9PEK8QS28WVkgpus6hZbOu0
         iehchgFOdFUoTk6Vd7sPUPsccAk/C+hqEr2v50LdBj2XK96CMd+/FFOI77Bs7TfnN9BV
         WLqLT+fSmsvTQHM56LyDkQtOBw/lqLJQgJ0TA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WBEaxZn0CJTxzuGGQ/JIuQt7Wrom3pGh+wy5DcLkcYT9poIOc9BafExJ7BWoMbJg1y
         3dk+ilx5mFNePDzbtFEIvqYvuFOXvLUJWzMdwUH/WNgdCz6YGS0sGmCXMf7EiNGf4Rm5
         hzx3U33/rg+fAl7WrueuaBvY1g0bHzmL+yzts=
Received: by 10.114.252.2 with SMTP id z2mr5609982wah.156.1258875485467;
        Sat, 21 Nov 2009 23:38:05 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2140286pzk.14.2009.11.21.23.37.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 23:38:04 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [urgent] [loongson] machtype: Fixup of prom_init_machtype()
Date:	Sun, 22 Nov 2009 15:37:53 +0800
Message-Id: <1258875473-13260-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The old version cut off everything of arcs_cmdline after machtype=xxxx,
which is totally wrong, we need to copy out the machtype=xxxx and then
operate it.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/machtype.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 2a46b4d..0ed52b3 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -15,6 +15,9 @@
 #include <loongson.h>
 #include <machine.h>
 
+/* please ensure the length of the machtype string is less than 50 */
+#define MACHTYPE_LEN 50
+
 static const char *system_types[] = {
 	[MACH_LOONGSON_UNKNOWN]         "unknown loongson machine",
 	[MACH_LEMOTE_FL2E]              "lemote-fuloong-2e-box",
@@ -34,18 +37,19 @@ const char *get_system_type(void)
 
 void __init prom_init_machtype(void)
 {
-	char *str, *p;
+	char *p, str[MACHTYPE_LEN];
 	int machtype = MACH_LEMOTE_FL2E;
 
 	mips_machtype = LOONGSON_MACHTYPE;
 
-	str = strstr(arcs_cmdline, "machtype=");
-	if (!str)
+	p = strstr(arcs_cmdline, "machtype=");
+	if (!p)
 		return;
-	str += strlen("machtype=");
+	p += strlen("machtype=");
+	strncpy(str, p, MACHTYPE_LEN);
 	p = strstr(str, " ");
 	if (p)
-		*p++ = '\0';
+		*p = '\0';
 
 	for (; system_types[machtype]; machtype++)
 		if (strstr(system_types[machtype], str)) {
-- 
1.6.2.1
