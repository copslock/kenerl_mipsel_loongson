Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 15:52:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:1276 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133449AbWDNOwD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Apr 2006 15:52:03 +0100
Received: from localhost (p1197-ipad209funabasi.chiba.ocn.ne.jp [58.88.112.197])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 39D1C8ECA; Sat, 15 Apr 2006 00:03:55 +0900 (JST)
Date:	Sat, 15 Apr 2006 00:04:18 +0900 (JST)
Message-Id: <20060415.000418.07644633.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Makefile crapectomy.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S8133763AbWCTMd3/20060320123329Z+1908@ftp.linux-mips.org>
References: <S8133763AbWCTMd3/20060320123329Z+1908@ftp.linux-mips.org>
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
X-archive-position: 11098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 20 Mar 2006 12:33:21 +0000, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Wed Mar 8 11:35:00 2006 +0000
> Commit: 434c1922d9865f1da02a2db604c1fdf8bee56b71
> Gitweb: http://www.linux-mips.org/g/linux/434c1922
> Branch: master
> 
> Dump all the ridiculously complicated stuff that was needed support
> compilers older and newer than 3.0.

This commit breaks sparse for 64bit kernel.  The -m64 option is
required.  Also, some macro values (such as _MIPS_TUNE, etc.)  contain
double-quote characters so it would be better quoting arguments by
single-quote characters.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0d86f31..61359b7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -616,7 +616,10 @@ LDFLAGS			+= -m $(ld-emul)
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(CFLAGS) -dM -E -xc /dev/null | \
 	egrep -vw '__GNUC_(MAJOR|MINOR|PATCHLEVEL)__' | \
-	sed -e 's/^\#define /-D/' -e 's/ /="/' -e 's/$$/"/')
+	sed -e 's/^\#define /-D/' -e "s/ /='/" -e "s/$$/'/")
+ifdef CONFIG_64BIT
+CHECKFLAGS		+= -m64
+endif
 endif
 
 OBJCOPYFLAGS		+= --remove-section=.reginfo
