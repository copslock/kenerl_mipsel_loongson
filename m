Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBILV4D16256
	for linux-mips-outgoing; Tue, 18 Dec 2001 13:31:04 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBILUxo16253;
	Tue, 18 Dec 2001 13:31:00 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAB07240; Tue, 18 Dec 2001 12:29:08 -0800 (PST)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA09794;
	Tue, 18 Dec 2001 21:22:50 +0100 (MET)
Date: Tue, 18 Dec 2001 21:22:50 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Jim Paris <jim@jtan.com>,
   linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
In-Reply-To: <3C1F9AD2.1269192E@mvista.com>
Message-ID: <Pine.GSO.3.96.1011218211601.5786C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jun Sun wrote:

> I was thinking most ISA dirvers should simply use inb/outb to access ioports.
> Don't really any ISA devices have their own memory space.  But, anyway, who
> can still remember those dark ages?

 The so called "shared memory" (mapped in the ISA space; usually below
1MB) for frame storage existed on a few models of better ISA Ethernet
boards.  And, of course, VGA boards have memory mapped in the ISA space.
Certain implementations occupy up to 4MB of ISA space when used in a SVGA
mode.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
