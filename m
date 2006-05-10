Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 13:25:04 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:55249 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133474AbWEJLYx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 13:24:53 +0200
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 46B744455A; Wed, 10 May 2006 13:24:52 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Fdmnn-0006yc-Kd; Wed, 10 May 2006 12:24:23 +0100
Date:	Wed, 10 May 2006 12:24:23 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] use generic DWARF_DEBUG
Message-ID: <20060510112423.GC7813@networkno.de>
References: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp> <20060510071937.GA7813@networkno.de> <20060510.165616.108981664.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510.165616.108981664.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 10 May 2006 08:19:37 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > There was something MIPS specific for n64 (DWARF64) uuntil very
> > recently. GCC HEAD switched n64 Linux to DWARF32 some days ago.
> 
> The MIPS specifis issue for n64 is covered by current vmlinux.lds.S ?
> If no, the patch would have no bad side-effects.

Well, I don't know since I don't use gdb on the kernel. I just wanted
to give a heads-up there was a change, your patch might even be a fix
for n64 kernels compiled with latest gcc. :-)

> Also, I suppose we can use STABS_DEBUG too, but not sure.  Current
> MIPS vmlinux.lds.S have this line:
> 
>   .comment : { *(.comment) }
> 
> and it seems conflicts with a .comment line in STABS_DEBUG.  Can we
> use generic STABS_DEBUG and drop the .comment line in mips
> vmlinux.lds.S ?

Isn't stabs in general deprecated by now?


Thiemo
