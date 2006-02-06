Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 13:37:28 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:27856 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3458482AbWBFNhT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2006 13:37:19 +0000
Received: from localhost (p8116-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.116])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 43FB5D8A; Mon,  6 Feb 2006 22:42:50 +0900 (JST)
Date:	Mon, 06 Feb 2006 22:42:31 +0900 (JST)
Message-Id: <20060206.224231.126575297.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] use CONFIG_64BIT for /proc/kcore fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060116155343.GE26771@deprecation.cyrius.com>
References: <20050121005954.GA10260@nevyn.them.org>
	<20050214020209.GA25335@nevyn.them.org>
	<20060116155343.GE26771@deprecation.cyrius.com>
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
X-archive-position: 10345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

CONFIG_MIPS64 was replaced by CONFIG_64BIT a while ago.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4188df8..0ff9a34 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -202,7 +202,7 @@ static inline int page_is_ram(unsigned l
 }
 
 static struct kcore_list kcore_mem, kcore_vmalloc;
-#ifdef CONFIG_MIPS64
+#ifdef CONFIG_64BIT
 static struct kcore_list kcore_kseg0;
 #endif
 
@@ -255,7 +255,7 @@ void __init mem_init(void)
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
 
-#ifdef CONFIG_MIPS64
+#ifdef CONFIG_64BIT
 	if ((unsigned long) &_text > (unsigned long) CKSEG0)
 		/* The -4 is a hack so that user tools don't have to handle
 		   the overflow.  */
