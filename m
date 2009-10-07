Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 20:16:44 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:39618 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493520AbZJGSP2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2009 20:15:28 +0200
Received: by ewy12 with SMTP id 12so10566931ewy.0
        for <multiple recipients>; Wed, 07 Oct 2009 11:15:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sxUlcjyUwGyUYC27fuEmRf04Fa375es73PaB9oOoNoo=;
        b=CGCg1dYqkVNUvHzcNr8rxmLBU7k3GHm0t46bsh4TCOU6CRzXuIP/iYVSOMdLL+YBYL
         iI+unAVcTr0rxULTYsZqvVBWFMlUuUbYQs53QdAjcUnSQnJfI64Kh8wYYxDFiUMzHmVS
         Wu0xyVZADzJ4sQu3tEGUSiRPsDm1mw2E05NMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=luuCJ+yMrmHKxcs7n8XdgWlO37posqDrNDLzzTHGk802SndE1ttCBEYhyXoPZWhtht
         gea6Xhzfv03JYdnU2iAY2joHjeyl9zFKskR0+//aJLzI+9eD5qZRClHvnVa5SDtdrA49
         //xDHjKJaDJcU7dUidTExKJ5oqgxGBYs1FH6E=
Received: by 10.216.85.194 with SMTP id u44mr75152wee.65.1254939323061;
        Wed, 07 Oct 2009 11:15:23 -0700 (PDT)
Received: from localhost.localdomain (p5496B5E8.dip.t-dialin.net [84.150.181.232])
        by mx.google.com with ESMTPS id f13sm94596gvd.21.2009.10.07.11.15.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 11:15:22 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/4] Alchemy: simple cpu subtype detector
Date:	Wed,  7 Oct 2009 20:15:14 +0200
Message-Id: <1254939315-8158-4-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254939315-8158-3-git-send-email-manuel.lauss@gmail.com>
References: <1254939315-8158-1-git-send-email-manuel.lauss@gmail.com>
 <1254939315-8158-2-git-send-email-manuel.lauss@gmail.com>
 <1254939315-8158-3-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

extract the alchemy chip variant from c0_prid register.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/au1000.h |   30 ++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index fceeca8..9174285 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -130,6 +130,36 @@ static inline int au1xxx_cpu_needs_config_od(void)
 	return 0;
 }
 
+#define ALCHEMY_CPU_UNKNOWN	-1
+#define ALCHEMY_CPU_AU1000	0
+#define ALCHEMY_CPU_AU1500	1
+#define ALCHEMY_CPU_AU1100	2
+#define ALCHEMY_CPU_AU1550	3
+#define ALCHEMY_CPU_AU1200	4
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
+	}
+
+	return ALCHEMY_CPU_UNKNOWN;
+}
+
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
-- 
1.6.5.rc2
