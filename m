Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 10:21:38 +0000 (GMT)
Received: from gprs137-41.eurotel.cz ([IPv6:::ffff:160.218.137.41]:27908 "EHLO
	kopretinka") by linux-mips.org with ESMTP id <S8225421AbUA1KVh>;
	Wed, 28 Jan 2004 10:21:37 +0000
Received: from ladis by kopretinka with local (Exim 3.36 #1 (Debian))
	id 1AlmBX-0000FV-00; Wed, 28 Jan 2004 10:40:35 +0100
Date: Wed, 28 Jan 2004 10:40:32 +0100
To: Kevin Paul Herbert <kph@cisco.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Removal of ____raw_readq() and ____raw_writeq() from asm-mips/io.h
Message-ID: <20040128094032.GB900@kopretinka>
References: <1075255111.8744.4.camel@shakedown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075255111.8744.4.camel@shakedown>
User-Agent: Mutt/1.5.4i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2004 at 05:58:31PM -0800, Kevin Paul Herbert wrote:
> In edit 1.68, the non-interrupt locking versions of
> raw_readq()/raw_writeq() were removed, in favor of locking ones. While
> this makes sense in general, it breaks the compilation of the sb1250
> which uses the non-locking versions (____raw_readq() and
> ____raw_writeq()) in interrupt handlers.
Why was someone using these function at all? if you don't need locking
simply do *reg_addr = val; 
> Personally, I think that it is very confusing to have so many similar
> macros with similar names and increasing numbers of underscores, so I
> don't really have a problem with this. I've modified
> arch/mips/sibyte/sb1250/time.c and arch/mips/sibyte/sb1250/irq.c to use
> the __ versions and have a few more instructions of overhead.
__ versions wasn't probably intended to use in C code. One should use
readq/writeq to get sane behaviour. These function was introduced to
hide architecture specific details. If you need something special, you
should introduce your own macros.
> My question is whether this removal was intended or not, or whether
> there are some other changes to the handlers in the sb1250-specific code
> that got dropped somewhere.
Yes it was. And I'm the one to blame for it ;)
> If the consensus is that the ____ versions really should perish for the
> sake of simplicity, I'll send my simple patches to the list to fix the
> sb1250 build.
Yes please.

	ladis
