Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4VABVx05091
	for linux-mips-outgoing; Thu, 31 May 2001 03:11:31 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4VABRh05086
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 03:11:27 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07985
	for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 03:08:32 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA13793;
	Thu, 31 May 2001 10:37:42 +0200 (MET DST)
Date: Thu, 31 May 2001 10:37:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, Joe deBlaquiere <jadb@redhat.com>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B15306A.3AACAF3E@mvista.com>
Message-ID: <Pine.GSO.3.96.1010531103211.11865C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 30 May 2001, Jun Sun wrote:

> Agree.  Having dual semantics for the return value is bad.
> 
> I was actually suggesting to have a new subcall in sysmips (e.g.,
> MIPS_NEW_ATOMIC_SET) and still working within the sysmips() call framework.
> 
> Is there any concern as for adding a new syscall?

 I'd prefer to avoid sysmips() (as a whole, not only the MIPS_ATOMIC_SET
subcall) for the reasons I've written previously.  There is really no
point in saving five bytes in the syscall tables just to make use of the
existing mess. 

 Note that adding MIPS_NEW_ATOMIC_SET doesn't make sysmips() more
consistent at all. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
