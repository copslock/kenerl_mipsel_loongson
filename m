Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2007 17:11:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:53482 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022618AbXCYQLV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Mar 2007 17:11:21 +0100
Received: from localhost (p7179-ipad25funabasi.chiba.ocn.ne.jp [220.104.85.179])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CD1ECA685; Mon, 26 Mar 2007 01:10:00 +0900 (JST)
Date:	Mon, 26 Mar 2007 01:10:00 +0900 (JST)
Message-Id: <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org,
	vagabon.xyz@gmail.com
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46062400.8080307@gentoo.org>
References: <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
	<20070324231602.GP2311@networkno.de>
	<46062400.8080307@gentoo.org>
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
X-archive-position: 14673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 25 Mar 2007 03:25:52 -0400, Kumba <kumba@gentoo.org> wrote:
> Going on this, I propose the following patch to fix our lovely SGI/Cobalt 
> systems, and eliminate a confusing Kconfig option whose time is likely long 
> since passed.  The attached patch achieves the following:
> 
> * Introduces a new flag for IP22, IP32, and Cobalt called 'kernel_loads_in_ckseg0'.
> * Introduces a new header, mem-layout.h, in include/asm-mips/mach-<platform>/ 
> for this flag for these three systems, and a dummy entry for mach-generic, 
> calling it in where appropriate.
> * Removes CONFIG_BUILD_ELF64 from Kconfig, Makefile, and several defconfigs, and 
> replaces its few references in header files with 'kernel_loads_in_ckseg0', with 
> appropriate flips in logic (except in stackframe.h).
> * Includes Frank's patch to eliminate the need for -mno-explicit-relocs.
> * Moves -msym32 calling to the Makefile locations for the three machines that 
> actually need it.

I can not see why you handle IP22, IP32, Cobalt as so "special".
There are many other platforms which supports 64-bit and uses CKSEG0
load address (well, actually all 64-bit platforms except for IP27).

So I think Franck's approach, which enables -msym32 and defines
KBUILD_64BIT_SYM32 automatically if load-y was CKSEG0, is better.  Are
there any problem with his patchset?

---
Atsushi Nemoto
