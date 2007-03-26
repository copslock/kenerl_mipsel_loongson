Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 15:44:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:18384 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022812AbXCZOoh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2007 15:44:37 +0100
Received: from localhost (p8030-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.30])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DB797A41F; Mon, 26 Mar 2007 23:43:16 +0900 (JST)
Date:	Mon, 26 Mar 2007 23:43:16 +0900 (JST)
Message-Id: <20070326.234316.23009158.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4607CF1D.50904@gentoo.org>
References: <4606C063.1030802@gentoo.org>
	<20070326.193641.15269037.nemoto@toshiba-tops.co.jp>
	<4607CF1D.50904@gentoo.org>
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
X-archive-position: 14696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Mar 2007 09:48:13 -0400, Kumba <kumba@gentoo.org> wrote:
> # mips64-unknown-linux-gnu-ld --version
> GNU ld version 2.16.1
> 
> # mips64-unknown-linux-gnu-gcc --version
> mips64-unknown-linux-gnu-gcc (GCC) 4.1.1 (Gentoo 4.1.1-r3)
> 
> And the disassembly of vmlinux.32 for the handle_int function is attached.

Thanks.  Is this a disassembly of _failed_ kernel?

If so, it looks KBUILD_64BIT_SYM32 is not defined.  So strange...

And even if %highest, etc. were used, it should work for CKSEG0
kernel, while using only %hi should be just an optimization.  Another
strangeness.

> 80006ad0:	3c1b0000 	lui	k1,0x0
> 80006ad4:	677b0000 	daddiu	k1,k1,0
> 80006ad8:	001bdc38 	dsll	k1,k1,0x10
> 80006adc:	677b8047 	daddiu	k1,k1,-32697
> 80006ae0:	001bdc38 	dsll	k1,k1,0x10
> 80006ae4:	df7b5008 	ld	k1,20488(k1)

The address of kernelsp should be 0xffffffff80475008.  It seems
a regular value.

---
Atsushi Nemoto
