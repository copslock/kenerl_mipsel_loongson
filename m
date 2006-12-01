Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 09:40:58 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.172]:52778 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037860AbWLAJkx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 09:40:53 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2560184uga
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 01:40:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=htNn/jqLzg6aKMBFrh4x0Ek/xMhkjbreJbPmd+mc766S0wfNQBhoPYzhD824Z4c8+j3t2qoPCyX/7XhxGHgMvQeGobVovbduGXQqpbwL0q2APL1wuVoj4X6uQpYRQBkMyJ/4XUA3PTNzZ8D+zbxWTHtXzzix3VfMkQosUYu13lo=
Received: by 10.78.83.13 with SMTP id g13mr4620878hub.1164966052368;
        Fri, 01 Dec 2006 01:40:52 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 01:40:52 -0800 (PST)
Message-ID: <cda58cb80612010140y5a95faceybffedbd4dd9900db@mail.gmail.com>
Date:	Fri, 1 Dec 2006 10:40:52 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Is _do_IRQ() not needed anymore ?
Cc:	linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi,

First thanks for your work on irq cleanup.

Now it seems that __do_IRQ() is not needed anymore. I dunno if it's
true for all platforms though. Does something like this make sense for
example ?

-- >8 --
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5ff94e5..a4c5306 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -913,8 +913,13 @@ config SYS_SUPPORTS_BIG_ENDIAN
 config SYS_SUPPORTS_LITTLE_ENDIAN
 	bool

+config GENERIC_HARDIRQS_NO__DO_IRQ
+	bool
+	default n
+
 config IRQ_CPU
 	bool
+	select GENERIC_HARDIRQS_NO__DO_IRQ

 config IRQ_CPU_RM7K
 	bool


-- 
               Franck
