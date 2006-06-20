Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 15:58:19 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:48600 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133798AbWFTO6J (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 15:58:09 +0100
Received: from localhost (p6234-ipad209funabasi.chiba.ocn.ne.jp [58.88.117.234])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3D6ACB9A7; Tue, 20 Jun 2006 23:58:05 +0900 (JST)
Date:	Tue, 20 Jun 2006 23:59:11 +0900 (JST)
Message-Id: <20060620.235911.132303870.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: fix FIXADDR_TOP for TX39/TX49
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030517.214555.74756802.anemo@mba.ocn.ne.jp>
References: <20030517.214555.74756802.anemo@mba.ocn.ne.jp>
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
X-archive-position: 11790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 17 May 2003 21:45:55 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> This patch fixes FIXADDR_TOP for TX39/TX49.  FIXADDR_TOP is used not
> only if CONFIG_HIGHMEM is enabled.  It is also used for high limit
> address for vmalloc.  

Now this patch is 3 years old :-)  Updated.


FIXADDR_TOP is used for HIGHMEM and for upper limit of vmalloc area on
32bit kernel.  TX39XX and TX49XX have "reserved" segment in CKSEG3
area.  0xff000000-0xff3fffff on TX49XX and 0xff000000-0xfffeffff on
TX39XX are reserved (unmapped, uncached) therefore can not be used as
mapped area.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/fixmap.h b/include/asm-mips/fixmap.h
index 73a3028..c7f4ee1 100644
--- a/include/asm-mips/fixmap.h
+++ b/include/asm-mips/fixmap.h
@@ -70,7 +70,11 @@ #define set_fixmap_nocache(idx, phys) \
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
+#if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
+#define FIXADDR_TOP	(0xff000000UL - 0x2000)
+#else
 #define FIXADDR_TOP	(0xffffe000UL)
+#endif
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
