Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TLjBnC002644
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 14:45:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TLjAnL002643
	for linux-mips-outgoing; Wed, 29 May 2002 14:45:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TLj3nC002638;
	Wed, 29 May 2002 14:45:04 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA29138;
	Wed, 29 May 2002 23:46:59 +0200 (MET DST)
Date: Wed, 29 May 2002 23:46:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Justin Carlson <justinca@cs.cmu.edu>, linux-mips@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
In-Reply-To: <20020529143305.D888@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020529234323.17584P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 29 May 2002, Ralf Baechle wrote:

> >  I converted a few flush_cache_all() invocations to __flush_cache_all() 
> > where appropriate late last year, but the function is a bit older.  I
> > think you might dig the linux-kernel list archives for a discussion on the
> > semantics of flush_cache_all() (it's a nop for many MIPS CPUs) and
> > friends.  The short description in Documentation/cachetlb.txt is a bit
> > insufficient, I'm afraid. 
> 
> I don't like that function very much; it's sort of a shotgun approach
> to flushing caches in a part of the kernel that's not too performance
> relevant.  The whole interface sucks, should be replaced by something
> more finegrained.

 Well, I suspect the API might be somewhat influenced by SPARC's oddities. 
;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
