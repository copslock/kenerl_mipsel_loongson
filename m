Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA27309
	for <pstadt@stud.fh-heilbronn.de>; Sat, 21 Aug 1999 01:02:17 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09268; Fri, 20 Aug 1999 15:56:30 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA16019
	for linux-list;
	Fri, 20 Aug 1999 15:50:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA28067
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 20 Aug 1999 15:50:28 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04724
	for <linux@cthulhu.engr.sgi.com>; Fri, 20 Aug 1999 15:50:21 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-29.uni-koblenz.de [141.26.131.29])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA18948
	for <linux@cthulhu.engr.sgi.com>; Sat, 21 Aug 1999 00:50:17 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA14751;
	Sat, 21 Aug 1999 00:49:44 +0200
Date: Sat, 21 Aug 1999 00:49:44 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Warner Losh <imp@village.org>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: ECOFF
Message-ID: <19990821004944.D25686@uni-koblenz.de>
References: <19990819154712.A13843@uni-koblenz.de> <199908202245.QAA39630@harmony.village.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <199908202245.QAA39630@harmony.village.org>; from Warner Losh on Fri, Aug 20, 1999 at 04:45:59PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Aug 20, 1999 at 04:45:59PM -0600, Warner Losh wrote:

> In message <19990819154712.A13843@uni-koblenz.de> Ralf Baechle writes:
> : Does anybody still rely on the linker support for ECOFF binaries?  I'd
> : like to drop the ECOFF emulations (mipsbig and mipslittle) from ld.
> 
> Doesn't LILO for the little endian ARC machines require this?

You mean Milo ...  Milo needs to be ECOFF but our compiler produces ELF
output.  Furthermore since we need relocatable ECOFF binaries for the
SNI firmware (actually the specs require it, but only on SNI we really
need it) we have to link PIC code to ECOFF.  And that is way too strong
stuff for ld to cope with.  That's why we're using elf2ecoff which is
now included with every Linux kernel.

  Ralf
