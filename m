Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA19013
	for <pstadt@stud.fh-heilbronn.de>; Tue, 24 Aug 1999 00:07:24 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA06289; Mon, 23 Aug 1999 14:48:13 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA14045
	for linux-list;
	Mon, 23 Aug 1999 14:38:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA72796
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 23 Aug 1999 14:38:39 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07164
	for <linux@cthulhu.engr.sgi.com>; Mon, 23 Aug 1999 14:36:58 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-5.uni-koblenz.de [141.26.131.5])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA06003
	for <linux@cthulhu.engr.sgi.com>; Mon, 23 Aug 1999 23:34:36 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA20888;
	Mon, 23 Aug 1999 23:30:43 +0200
Date: Mon, 23 Aug 1999 23:30:43 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tom Woelfel <Tom.Woelfel@eed.ericsson.se>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: ECOFF
Message-ID: <19990823233043.B19012@uni-koblenz.de>
References: <19990819154712.A13843@uni-koblenz.de> <199908231009.MAA27147@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <199908231009.MAA27147@sun168.eu>; from Tom Woelfel on Mon, Aug 23, 1999 at 12:09:26PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 23, 1999 at 12:09:26PM +0200, Tom Woelfel wrote:

> Ralf Baechle writes:
>  > Does anybody still rely on the linker support for ECOFF binaries?  I'd
>  > like to drop the ECOFF emulations (mipsbig and mipslittle) from ld.
> 
> I still have an Indy with the "very old boot prom" problem (it's 5.3
> in your HOWTO ;-). I don't have an idea if this in any way related to
> this. But if so (and in case "old prom Indy's" will then not boot)
> it seems to me a good idea to put a hint or a workaround in the HOWTO.

No problem, that's why we have elf2ecoff as part of the kernel sources.
Directly linking elf to ecoff is too strong stuff for ld anyway, at
least for some of the ultra hairy case we have to handle.

  Ralf
