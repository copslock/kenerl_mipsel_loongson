Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KG17EC031756
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 09:01:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KG17Yj031755
	for linux-mips-outgoing; Tue, 20 Aug 2002 09:01:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mta7.pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KG12EC031738
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 09:01:02 -0700
Received: from localhost ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0H15006E7GM1ON@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Tue, 20 Aug 2002 09:03:38 -0700 (PDT)
Date: Tue, 20 Aug 2002 08:54:41 -0700
From: Pete Popov <ppopov@mvista.com>
Subject: Re: Mips cross toolchain
In-reply-to: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Message-id: <1029858882.13494.22.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Just FYI, the oss code for the Alchemy boards is out of date. The latest
code is in the sourceforge.net mips tree.  I meant to create patches and
send them to Ralf but I'm doing less and less dev work these days and
haven't been able to find the time.

As far as your toolchain, the last MontaVista release which included the
Alchemy boards was 2.95.3 based.  I can also tell you that gcc 3.2 works
fine, but I'm not sure if we needed any patches.

Pete

On Tue, 2002-08-20 at 08:58, Lyle Bainbridge wrote:
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
> 
> Thanks,
> Lyle Bainbridge
> Minneapolis, MN
> 
