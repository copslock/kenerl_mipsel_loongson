Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4V3TH028532
	for linux-mips-outgoing; Wed, 30 May 2001 20:29:17 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4V3TEh28524
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 20:29:14 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA02693
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 20:29:13 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA10066;
	Wed, 30 May 2001 14:01:10 +0200 (MET DST)
Date: Wed, 30 May 2001 14:01:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B142495.66677A18@mvista.com>
Message-ID: <Pine.GSO.3.96.1010530135109.9456A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 29 May 2001, Jun Sun wrote:

> I think system V requires _test_and_set() being included in the libsys dynamic
> library.  Does Linux want to be sysv compatible?  If so, we should removed the
> inlined _test_and_set().

 Why should we remove the inlined _test_and_set()?  We do have a number of
other inlined functions in glibc, e.g. memcpy() and friends in
<bits/string.h> (not for MIPS, actually, but for other hosts), yet it does
not make glibc SVR4 incompatible.  Of course we always provide non-inlined
versions of such functions as well -- check with objdump if unsure. 

 Note they are *extern* inline.

> The need for kernel emulated test_and_set() in 64bit kernel is not obvious
> yet, and hopefully will never come.

 Agreed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
