Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7JDJMRw006928
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 19 Aug 2002 06:19:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7JDJM61006927
	for linux-mips-outgoing; Mon, 19 Aug 2002 06:19:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7JDJFRw006918
	for <linux-mips@oss.sgi.com>; Mon, 19 Aug 2002 06:19:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA16512;
	Mon, 19 Aug 2002 15:22:22 +0200 (MET DST)
Date: Mon, 19 Aug 2002 15:22:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <1029761823.19375.16.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.3.96.1020819151339.14441F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 19 Aug 2002, Alan Cox wrote:

> We support ATA devices attached to arbitary busses. The newest ATA code
> supports arbitary mmio/pio addressing mechanisms. You don't need ISA or
> an ISA like bus.

 Hmm, does such hardware already exist?  I don't think it's reasonable to
make some code available to a user in a configuration that will never make
use of it.  E.g. a plain TURBOchannel box (or one with no I/O bus) won't
ever see a native ATA device (SCSI to ATA bridges obviously don't count). 
I'll check if the code builds at all. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
