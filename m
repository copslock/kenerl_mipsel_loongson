Received:  by oss.sgi.com id <S553665AbQKNOU4>;
	Tue, 14 Nov 2000 06:20:56 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:49861 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553655AbQKNOUh>;
	Tue, 14 Nov 2000 06:20:37 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA17764;
	Tue, 14 Nov 2000 15:19:11 +0100 (MET)
Date:   Tue, 14 Nov 2000 15:19:11 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com,
        lfs-discuss@linuxfromscratch.org, Andreas Jaeger <aj@suse.de>
Subject: Re: User/Group Problem
In-Reply-To: <20001113231949.B16012@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001114150916.17140A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 13 Nov 2000, Ralf Baechle wrote:

> >  Here is a patch I use since July successfully.  We need to wait until
> > 2.4.1 or so (or maybe even 2.5) is released for it to be applied as
> > 2.4.0-test* are currently code-frozen.  Maybe we could apply it to our CVS
> > for now?  Ralf, what do you think? 
> 
> There is second interpretation of this problem - the address passed to
> mmap is bogus, so this computation needs to be fixed.

 Where is it written mmap() is allowed to fail when a bogus VM address is
passed but MAP_FIXED is not set?  I believe mmap() should choose a
different VM address in this case, as long as much enough contiguous VM
space is available anywhere to satisfy the requested length.

 Surely, map_segment() (see dl-load.c) might call mmap(0, ...) after
mmap(<some_address>, ...) fails when MAP_FIXED is not set but wouldn't
that be a dirty hack?  We'd better fix the kernel. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
