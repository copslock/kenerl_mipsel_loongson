Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jun 2007 17:44:15 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:5575 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022052AbXF3QoN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 30 Jun 2007 17:44:13 +0100
Received: from localhost (p2031-ipad213funabasi.chiba.ocn.ne.jp [124.85.67.31])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 66A1BB64C; Sun,  1 Jul 2007 01:44:07 +0900 (JST)
Date:	Sun, 01 Jul 2007 01:44:54 +0900 (JST)
Message-Id: <20070701.014454.126142904.anemo@mba.ocn.ne.jp>
To:	michael@frogfoot.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Unhandled kernel unaligned access debugging
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070629163951.GG5929@marmite.frogfoot.net>
References: <20070629163951.GG5929@marmite.frogfoot.net>
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
X-archive-position: 15582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 29 Jun 2007 18:39:51 +0200, Michael Wood <michael@frogfoot.com> wrote:
> I think understand more or less what this means, but am unsure of how to
> debug it.  I think OpenWRT is using the vanilla kernel, but maybe I'm
> missing something.  Is this because I'm not using the kernel from
> linux-mips.org?

It is not vanilla kernel.  squashfs is not merged mainline yet.

> Unhandled kernel unaligned access[#1]:
> Cpu 0
> $ 0   : 00000000 10008400 69725020 94001b90
> $ 4   : 94003200 7265746e 00000002 00000000
> $ 8   : 94016338 940162b0 94016228 940161a0
> $12   : 94e5653c 943a0000 943a0000 94e5659c
> $16   : 94001b80 00000000 94003200 00000002
> $20   : 00000000 00000000 00000000 00000000
> $24   : 00000000 9410b8a0
> $28   : 943e4000 943e5ec0 00000000 94175e40
> Hi    : 00000003
> Lo    : 00000002
> epc   : 941742bc drain_freelist+0x6c/0xf8     Not tainted
> ra    : 94175e40 cache_reap+0xc0/0x124
> Status: 10008402    KERNEL EXL
> Cause : 10800010
> BadVA : 7265746e
> PrId  : 00018448
...
> 0xffffffff941742bc <drain_freelist+108>:        lw      v1,0(a1)

The value of a1 (0x7265746e) is not a kernel address and I do not
think drain_freelist use such an address.  So it would not be an
"unaligned access" problem.  I support it would be some sort of memory
corruption.

---
Atsushi Nemoto
