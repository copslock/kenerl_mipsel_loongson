Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2006 15:51:44 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:56028 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3467572AbWBHPv3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2006 15:51:29 +0000
Received: from localhost (p8063-ipad01funabasi.chiba.ocn.ne.jp [61.207.82.63])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DFB5CA296; Thu,  9 Feb 2006 00:57:12 +0900 (JST)
Date:	Thu, 09 Feb 2006 00:56:55 +0900 (JST)
Message-Id: <20060209.005655.96684595.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use __raw access function for fb
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 2cb19e6..8c0cf1c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -809,7 +809,7 @@ struct fb_info {
 #define fb_writeq sbus_writeq
 #define fb_memset sbus_memset_io
 
-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || (defined(__sh__) && !defined(__SH5__)) || defined(__powerpc__)
+#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || (defined(__sh__) && !defined(__SH5__)) || defined(__powerpc__) || defined(__mips__)
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
