Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2008 17:16:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:195 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021828AbYGIQQh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2008 17:16:37 +0100
Received: from localhost (p5236-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 11767A042; Thu, 10 Jul 2008 01:16:33 +0900 (JST)
Date:	Thu, 10 Jul 2008 01:18:18 +0900 (JST)
Message-Id: <20080710.011818.26096759.anemo@mba.ocn.ne.jp>
To:	sam@ravnborg.org
Cc:	linux-sparse@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080708204547.GA16742@uranus.ravnborg.org>
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
	<20080708204547.GA16742@uranus.ravnborg.org>
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
X-archive-position: 19750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 8 Jul 2008 22:45:47 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> > The linus-mips kernel uses '$(CC) -dM -E' to generates arguments for
> > sparse.  With gcc 4.3, it generates lot of '-D' options and causes
> > pre_buffer overflow.
> 
> Why does mips have this need when all other archs does not?
> We should fix sparse so it is dynamically allocated - but
> that is not an excuse for mips to use odd stuff like this.
> 
> So please someone from mips land explain why this is needed.

This was introduced by commit 59b3e8e9aac69d2d02853acac7e2affdfbabca50.
("[MIPS] Makefile crapectomy.")

Before the commit, CHECKFLAGS was adjusted like this:

CHECKFLAGS-y				+= -D__linux__ -D__mips__ \
					   -D_MIPS_SZINT=32 \
					   -D_ABIO32=1 \
					   -D_ABIN32=2 \
					   -D_ABI64=3
CHECKFLAGS-$(CONFIG_32BIT)		+= -D_MIPS_SIM=_ABIO32 \
					   -D_MIPS_SZLONG=32 \
					   -D_MIPS_SZPTR=32 \
					   -D__PTRDIFF_TYPE__=int
CHECKFLAGS-$(CONFIG_64BIT)		+= -m64 -D_MIPS_SIM=_ABI64 \
					   -D_MIPS_SZLONG=64 \
					   -D_MIPS_SZPTR=64 \
					   -D__PTRDIFF_TYPE__="long int"
CHECKFLAGS-$(CONFIG_CPU_BIG_ENDIAN)	+= -D__MIPSEB__
CHECKFLAGS-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -D__MIPSEL__
CHECKFLAGS				= $(CHECKFLAGS-y)
CHECKFLAGS-$(CONFIG_CPU_R3000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS1
CHECKFLAGS-$(CONFIG_CPU_TX39XX)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS1
CHECKFLAGS-$(CONFIG_CPU_R6000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS2
CHECKFLAGS-$(CONFIG_CPU_R4300)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS3
CHECKFLAGS-$(CONFIG_CPU_VR41XX)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS3
CHECKFLAGS-$(CONFIG_CPU_R4X00)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS3
CHECKFLAGS-$(CONFIG_CPU_TX49XX)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS3
CHECKFLAGS-$(CONFIG_CPU_MIPS32_R1)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS32
CHECKFLAGS-$(CONFIG_CPU_MIPS32_R2)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS32
CHECKFLAGS-$(CONFIG_CPU_MIPS64_R1)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS64
CHECKFLAGS-$(CONFIG_CPU_MIPS64_R2)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS64
CHECKFLAGS-$(CONFIG_CPU_R5000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
CHECKFLAGS-$(CONFIG_CPU_R5432)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
CHECKFLAGS-$(CONFIG_CPU_NEVADA)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
CHECKFLAGS-$(CONFIG_CPU_RM7000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
CHECKFLAGS-$(CONFIG_CPU_RM9000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
CHECKFLAGS-$(CONFIG_CPU_SB1)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS64
CHECKFLAGS-$(CONFIG_CPU_R8000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4
CHECKFLAGS-$(CONFIG_CPU_R10000)	+= -D_MIPS_ISA=_MIPS_ISA_MIPS4

And now:

CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -xc /dev/null | \
	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
	sed -e 's/^\#define /-D/' -e "s/ /='/" -e "s/$$/'/")
ifdef CONFIG_64BIT
CHECKFLAGS		+= -m64
endif

It looks fairly simple, unless you run make C=1 V=1 ...

---
Atsushi Nemoto
