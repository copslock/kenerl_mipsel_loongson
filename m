Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KGBEEC032189
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 09:11:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KGBEpp032188
	for linux-mips-outgoing; Tue, 20 Aug 2002 09:11:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f39.dialo.tiscali.de [62.246.16.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KGB3EC032179
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 09:11:07 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7KG2NT25481;
	Tue, 20 Aug 2002 18:02:23 +0200
Date: Tue, 20 Aug 2002 18:02:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Mips cross toolchain
Message-ID: <20020820180223.A24985@linux-mips.org>
References: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>; from lyle@zevion.com on Tue, Aug 20, 2002 at 10:58:13AM -0500
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 10:58:13AM -0500, Lyle Bainbridge wrote:

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

Looks like you installed the toolchain in a different directory that
it was built for.

  Ralf
