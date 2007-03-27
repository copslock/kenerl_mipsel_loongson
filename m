Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 15:54:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:17096 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021891AbXC0Oyc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2007 15:54:32 +0100
Received: from localhost (p3060-ipad207funabasi.chiba.ocn.ne.jp [222.145.85.60])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6E798BC27; Tue, 27 Mar 2007 23:53:10 +0900 (JST)
Date:	Tue, 27 Mar 2007 23:53:10 +0900 (JST)
Message-Id: <20070327.235310.128618679.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46086A90.7070402@gentoo.org>
References: <4607CF1D.50904@gentoo.org>
	<20070326.234316.23009158.anemo@mba.ocn.ne.jp>
	<46086A90.7070402@gentoo.org>
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
X-archive-position: 14731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Mar 2007 20:51:28 -0400, Kumba <kumba@gentoo.org> wrote:
> Lets try this one; the kernel was built with gcc-4.1.2 and binutils-2.17 this 
> time around, and I tested it before running objdump on it.  It just hangs right 
> after loading:
> 
>  > bootp(): console=ttyS0,38400 root=/dev/md0
> Setting $netaddr to 192.168.1.12 (from server )
> Obtaining  from server
> 4358278+315290 entry: 0x80401000

Now I can not see any problem with the disassembled code.  No idea why
it does not work at all...

BTW, why IP32 does not support 32-bit kernel, though it has 32-bit
firmware?
---
Atsushi Nemoto
