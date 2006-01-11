Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 14:41:10 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:9698 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133475AbWAKOkq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2006 14:40:46 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1EwhCe-0004WV-OI; Wed, 11 Jan 2006 09:43:56 -0500
Date:	Wed, 11 Jan 2006 09:43:56 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: QEMU and kernel 2.6.15
Message-ID: <20060111144355.GA17275@nevyn.them.org>
References: <20060111.002431.93019846.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111.002431.93019846.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 11, 2006 at 12:24:31AM +0900, Atsushi Nemoto wrote:
> Hi.  I'm a QEMU newbie.  Does anybody tried QEMU 0.8.0 with recent
> linux-mips kernel ?

You've configured the kernel for QEMU, right?  And are usin QEMU from
CVS?

> Checking for 'wait' instruction...  available.
> 
> 
> I can get qemu prompt by typing C-a c and 'info register' shows
> PC=0x80010d40 (qemu_handle_int+0xe0).
> 
> (qemu) info registers
> pc=0x80010d40 HI=0x00000000 LO=0x00000000 ds 0000 801b6cd8 0
> GPR00: r0 00000000 at 10008401 v0 8027fbe8 v1 00000000
> GPR04: a0 80281f0c a1 80281e9c a2 8027fbe8 a3 80281f0c
> GPR08: t0 10008400 t1 1000001f t2 00000000 t3 00000000
> GPR12: t4 7fffffff t5 ffffffff t6 00100100 t7 7fffffff
> GPR16: s0 00000002 s1 80281f08 s2 00000000 s3 00000000
> GPR20: s4 00000000 s5 00000000 s6 00000000 s7 00000000
> GPR24: t8 00000000 t9 00000001 k0 80281e80 k1 80281e80
> GPR28: gp 80280000 sp 80281dd0 s8 80281e80 ra 801b74f8
> CP0 Status  0x10008400 Cause   0x80000400 EPC    0x801b74f4
>     Config0 0x80008081 Config1 0x1e190c8a LLAddr 0x00000001

It worked for me the last time I tried, but that was a couple
of weeks ago.  The port may have gotten broken...


-- 
Daniel Jacobowitz
CodeSourcery
