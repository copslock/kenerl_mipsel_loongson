Received:  by oss.sgi.com id <S553690AbRAPQKZ>;
	Tue, 16 Jan 2001 08:10:25 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:28631 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553812AbRAPQKQ>;
	Tue, 16 Jan 2001 08:10:16 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA17092;
	Tue, 16 Jan 2001 17:06:30 +0100 (MET)
Date:   Tue, 16 Jan 2001 17:06:29 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010116135737.A13302@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010116170209.5546K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Ralf Baechle wrote:

> > Before:
> > 	On node 0 totalpages: 589824
> > 	zone(0): 589824 pages.
> > 
> > 
> > After:
> > 	On node 0 totalpages: 65536
> > 	zone(0): 65536 pages.
> 
> I probably already got used too machines with gigs of memory to notice ;-)

 The number actually denotes the highest page, regardless of the number of
pages, so you only need a single page placed far away from address zero to
observe such large counts.

> Can you decode the addresses in $epc and $31 for me?

 Probably a memory access in free_all_bootmem() or so.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
