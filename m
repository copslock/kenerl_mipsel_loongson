Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 17:05:42 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:7635 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031913AbYGKQFk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2008 17:05:40 +0100
Received: from localhost (p1011-ipad211funabasi.chiba.ocn.ne.jp [58.91.157.11])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 16ED7AB24; Sat, 12 Jul 2008 01:05:35 +0900 (JST)
Date:	Sat, 12 Jul 2008 01:07:21 +0900 (JST)
Message-Id: <20080712.010721.18574863.anemo@mba.ocn.ne.jp>
To:	viro@ZenIV.linux.org.uk, ralf@linux-mips.org
Cc:	sam@ravnborg.org, linux-sparse@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080710173945.GE28946@ZenIV.linux.org.uk>
References: <20080710.011818.26096759.anemo@mba.ocn.ne.jp>
	<20080709163212.GA1227@uranus.ravnborg.org>
	<20080710173945.GE28946@ZenIV.linux.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 10 Jul 2008 18:39:45 +0100, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> So...  Only 3 symbols out of the entire bunch are arch-dependent *and* not
> provided by sparse itself.  Absolute majority of the rest is never ever
> used in the tree.
> 
> I very much doubt that mips situation is seriously different...

Then, how about this?  Ralf, is this filter reasonable?


Subject: [PATCH] mips: reduce symbols passed to CHECKFLAGS

Without this patch, gcc 4.3 will produces so many symbols and causes
pre_buffer[] overflow in sparse.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d319cd6..6c4eb9f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -619,7 +619,7 @@ LDFLAGS			+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -xc /dev/null | \
-	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
+	egrep '(MIPS|mips|_ABI|_TYPE__)' | \
 	sed -e 's/^\#define /-D/' -e "s/ /='/" -e "s/$$/'/")
 ifdef CONFIG_64BIT
 CHECKFLAGS		+= -m64
