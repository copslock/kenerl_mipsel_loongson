Received:  by oss.sgi.com id <S553832AbRAPQhF>;
	Tue, 16 Jan 2001 08:37:05 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:58327 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553825AbRAPQhE>;
	Tue, 16 Jan 2001 08:37:04 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA18434;
	Tue, 16 Jan 2001 17:34:45 +0100 (MET)
Date:   Tue, 16 Jan 2001 17:34:45 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010116142449.B13302@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010116172956.5546O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Ralf Baechle wrote:

> The Indy has it's memory starting at phys. 0x08000000; a part of it is also
> mirrored at physical address zero.  So in case of an Indy the totalpages
> number should indicate 128mb too much which means that Flo's machine should
> have only 128mb real memory.  Right Florian?

 The memory map suggests it is so.

 But how does the Indy handle our kernel being linked at 0x80000000?  Does
the kernel always fit the mirrored area? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
