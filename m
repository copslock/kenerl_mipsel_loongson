Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f42DgH603449
	for linux-mips-outgoing; Wed, 2 May 2001 06:42:17 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f42DeJF03397;
	Wed, 2 May 2001 06:40:35 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA25652;
	Wed, 2 May 2001 15:21:11 +0200 (MET DST)
Date: Wed, 2 May 2001 15:21:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Florian Lohoff <flo@rfc822.org>, Pete Popov <ppopov@mvista.com>,
   linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
In-Reply-To: <20010430172419.B30998@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010502151446.25334B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 30 Apr 2001, Ralf Baechle wrote:

> >  It could be doable with __builtin_frame_address().  Haven't investigated
> > it further, though. 
> 
> MIPS ABI doesn't define that ra gets stored at a constant offset in
> the stackframe, so that won't work.

 Hmm, I think we check look how gcc gets __builtin_return_address() 
(specifically for levels greater than 0) and use the same way.  We don't
need to stick to the ABI in the kernel (building non-PIC we already
violate it anyway) and we can assume the code is to be built by gcc. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
