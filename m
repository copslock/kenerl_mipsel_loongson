Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 14:48:51 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:4815 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022723AbXCXOsu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2007 14:48:50 +0000
Received: from localhost (p2115-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.115])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6C2E5B6D0; Sat, 24 Mar 2007 23:47:28 +0900 (JST)
Date:	Sat, 24 Mar 2007 23:47:27 +0900 (JST)
Message-Id: <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, vagabon.xyz@gmail.com
Subject: Re: Building 64 bit kernel on Cobalt
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46049BAD.1010705@gentoo.org>
References: <4603DA74.70707@gentoo.org>
	<20070324.002440.93023010.anemo@mba.ocn.ne.jp>
	<46049BAD.1010705@gentoo.org>
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
X-archive-position: 14659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 23 Mar 2007 23:31:57 -0400, Kumba <kumba@gentoo.org> wrote:
> Well, o64 went away as we all know.  It was never a favourable
> option for very good reasons (although I used it right up until it
> died and I was forced off of it).  The replacement for it, that was
> more preferred and resulted in similar code was building a kernel
> for any of these three systems using CONFIG_BUILD_ELF64 + -msym32
> (auto selected in the Makefile) + the make vmlinux.32 target.  I
> believe this method is what Debian uses for building their mips
> kernels for SGI systems, but don't quote me on that.  If someone
> from Debian wants to comment, please do.

The replacement is CONFIG_BUILD_ELF64=n (it adds -msym32 option) +
CONFIG_BOOT_ELF32=y (it adds vmlinux.32 to "all" target).  Not
CONFIG_BUILD_ELF64=y.

CONFIG_BUILD_ELF64=n enables -msym32 option, which means the kernel
load address should be CKSEG0.  And if the kernel load address was
CKSEG0, -msym32 make the kernel smaller and faster so it is absolutely
preferred.

CONFIG_BOOT_ELF32=y enables objcopying vmlinux to vmlinux.32.

---
Atsushi Nemoto
