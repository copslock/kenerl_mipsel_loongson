Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8FIx604121
	for linux-mips-outgoing; Thu, 8 Nov 2001 07:18:59 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8FHg004107;
	Thu, 8 Nov 2001 07:17:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA12742;
	Thu, 8 Nov 2001 16:16:58 +0100 (MET)
Date: Thu, 8 Nov 2001 16:16:58 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, dony.he@huawei.com,
   linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
In-Reply-To: <20011107024146.A1740@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1011108160211.6973H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 7 Nov 2001, Ralf Baechle wrote:

> > In somewhere between 2.4.6 and 2.4.9, the call to flush_cache_all()
> > disappered from vmalloc_area_pages().  I have a data corruption
> > problem in vmalloc()ed area without this call.  I think we still need
> > this call.
> 
> Entirely correct.  I'm just trying to find why this call got removed
> in 2.4.10.  Clearly wrong;  I had not noticed that these two lines
> got removed and thus was assuming the code of those two must somehow
> be malfunctioning.

 See a mail titled "flush_tlb_all in vmalloc_area_pages" dated Sep 7th,
2001 sent to the linux-kernel list for the patch in question.  There was a
discussion on cache flushing wrt to a TLB on the list under "[PATCH]
change name of rep_nop" subject later as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
