Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA31697
	for <pstadt@stud.fh-heilbronn.de>; Mon, 28 Jun 1999 23:48:11 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA3704443; Mon, 28 Jun 1999 14:45:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA67935
	for linux-list;
	Mon, 28 Jun 1999 14:41:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA38280
	for <linux@engr.sgi.com>;
	Mon, 28 Jun 1999 14:41:09 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08862
	for <linux@engr.sgi.com>; Mon, 28 Jun 1999 14:40:54 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-26.uni-koblenz.de [141.26.131.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA20609
	for <linux@engr.sgi.com>; Mon, 28 Jun 1999 23:40:51 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id MAA00836;
	Mon, 28 Jun 1999 12:39:50 +0200
Date: Mon, 28 Jun 1999 12:39:50 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andrew Linfoot <andy@derfel99.freeserve.co.uk>
Cc: Ulf Carlsson <ulfc@thepuffingroup.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: File corruption
Message-ID: <19990628123950.B735@uni-koblenz.de>
References: <19990622032859.B6955@thepuffingroup.com> <19990622152145.A1059@uni-koblenz.de> <19990623014923.A8953@thepuffingroup.com> <19990625002853.D17220@uni-koblenz.de> <002701bebf17$cd9e4fd0$0a02030a@snafu> <19990625185906.A9050@thepuffingroup.com> <001901bebf2d$e1951530$0a02030a@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <001901bebf2d$e1951530$0a02030a@snafu>; from Andrew Linfoot on Fri, Jun 25, 1999 at 06:11:52PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 25, 1999 at 06:11:52PM +0100, Andrew Linfoot wrote:

> CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE

This is what the firmware detected.

> Loading R4000 MMU routines.

This will always say R4000 if it's a R4000 class CPU.

> CPU revision is: 00000450
> Primary instruction cache 16kb, linesize 16 bytes)
> Primary data cache 16kb, linesize 16 bytes)
> Secondary cache sized at 1024K linesize 128

Which says that you have an R4400SC V5.0.

> an interesting point here is that /proc/cpuinfo tells me i only have an
> r4000!

Good spotting, the CPU detection code has a bug causes only V4 CPUs to be
detected as R4400.  The difference is just cosmetics; R4000 and R4400 are
almost the same.  Especially it's unrelated to the file corruption problem.

  Ralf
