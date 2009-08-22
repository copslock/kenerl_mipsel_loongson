Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Aug 2009 18:10:44 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:33731 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493202AbZHVQKM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Aug 2009 18:10:12 +0200
Received: by bwz4 with SMTP id 4so1099534bwz.0
        for <multiple recipients>; Sat, 22 Aug 2009 09:10:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zY2EHmdN9z4T3w79JVKY8oNIiDp8aoPqXhQb4LQSuGQ=;
        b=milZSKJ5Qi6cY6Dle1LxUkLPlKbRhPZ4jApwBlQL7LuV17pxuCnOFcbo7RKxNxcNKA
         07K+crZHG+aCf3Cf3WU4kJahtxk5UfflZHC7ofKd7bMcG2EE81jLB4Q1b9zlnMV4sYyC
         hUSxECQ9KM2rKB7PfYlUkXLO2AtybdxNYlhtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y5MrbpcR4E6uLTocKd5YoWzXo2bMYUb6oCXI9ghtHHlu8DSKua57q6cAiSiOiMgEnn
         eacFxOwTell7aTs8ks/4UqyyJXKxORa/CI+aFb1hgUXzbJm+lRG9lNq8cCLRZhaEPPnH
         V+pW35gPM+s6ZuCzPiUGPdAejTB4To2oaOiZI=
Received: by 10.223.144.204 with SMTP id a12mr1591871fav.49.1250957406947;
        Sat, 22 Aug 2009 09:10:06 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id f31sm4121507fkf.38.2009.08.22.09.10.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Aug 2009 09:10:06 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/2] Alchemy: simple cpu subtype detector.
Date:	Sat, 22 Aug 2009 18:10:00 +0200
Message-Id: <1250957401-14447-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1250957401-14447-1-git-send-email-manuel.lauss@gmail.com>
References: <1250957401-14447-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/au1000.h |   34 ++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 854e95f..85713f8 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -130,6 +130,40 @@ static inline int au1xxx_cpu_needs_config_od(void)
 	return 0;
 }
 
+#define ALCHEMY_CPU_UNKNOWN	-1
+#define ALCHEMY_CPU_AU1000	0
+#define ALCHEMY_CPU_AU1500	1
+#define ALCHEMY_CPU_AU1100	2
+#define ALCHEMY_CPU_AU1550	3
+#define ALCHEMY_CPU_AU1200	4
+#define ALCHEMY_CPU_AU1300	5
+
+static inline int alchemy_get_cputype(void)
+{
+	switch (read_c0_prid() & 0xffff0000) {
+	case 0x00030000:
+		return ALCHEMY_CPU_AU1000;
+		break;
+	case 0x01030000:
+		return ALCHEMY_CPU_AU1500;
+		break;
+	case 0x02030000:
+		return ALCHEMY_CPU_AU1100;
+		break;
+	case 0x03030000:
+		return ALCHEMY_CPU_AU1550;
+		break;
+	case 0x04030000:
+		return ALCHEMY_CPU_AU1200;
+		break;
+	case 0x800c0000:
+		return ALCHEMY_CPU_AU1300;
+		break;
+	}
+
+	return ALCHEMY_CPU_UNKNOWN;
+}
+
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
-- 
1.6.4
