Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KG27EC031946
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 09:02:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KG27ai031945
	for linux-mips-outgoing; Tue, 20 Aug 2002 09:02:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KG22EC031919
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 09:02:02 -0700
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17hBV3-0005QS-00; Tue, 20 Aug 2002 11:04:57 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17hBVc-0006lY-00; Tue, 20 Aug 2002 12:05:32 -0400
Date: Tue, 20 Aug 2002 12:05:32 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Mips cross toolchain
Message-ID: <20020820160532.GA25800@nevyn.them.org>
References: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 10:58:13AM -0500, Lyle Bainbridge wrote:
> Hi,
> 
> I'm a linux kernel newbie, and this is my first linux-mips posting.
> I have built a big endian, elf, cross toolchain for mips32 (I'm using
> an Alchemy Au1500 SOC) based on the GCC 3.0.4, Binutils 2.11.2 and
> Newlib 1.9.0.  My intention is to now use it to compile the 2.4.19 kernel.
> 
> I am still figuring out how to cross compile the kernel, but I was
> wondering if I had used the correct versions of GCC and Binutils to
> succesfully build a stable kernel.  Also, are there any patches I would
> need? So far I've used the stock distributions from gnu.org.
> 
> Any advice would be most appreciated.

You'll have better luck if you use the current releases.  That's 3.2
and 2.13 and (I think) 1.10.0.  Not sure if newlib 1.10.0 is released
or not.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
