Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2003 17:09:56 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:12418 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225212AbTG2QJy>; Tue, 29 Jul 2003 17:09:54 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA09375;
	Tue, 29 Jul 2003 18:09:45 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 29 Jul 2003 18:09:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Teresa Tao <Teresat@tridentmicro.com>, linux-mips@linux-mips.org
Subject: Re: mmap'ed memory cacheable or uncheable
In-Reply-To: <20030728142401.K25784@mvista.com>
Message-ID: <Pine.GSO.3.96.1030729180353.9217B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 28 Jul 2003, Jun Sun wrote:

> > How about if I specify the following flags in my mmap routine just like what the pgprot_noncached micro did.
> > 	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
> > 	pgprot_val(vma->vm_page_prot) |= _CACHE_UNCACHED;
> > 
> > Will this have kernel make the mmap'd memory non-cacheable? Or is there a mmap non-cacheable patch?
> 
> I think this might work.  Did you try it?  The performance will be bad
> though as mmap() is used widely by userland.

 See mmap_mem() for how to select between cached and uncached mmap()ing
cleanly. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
