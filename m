Received:  by oss.sgi.com id <S553724AbQKPOIf>;
	Thu, 16 Nov 2000 06:08:35 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:46049 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553715AbQKPOIW>;
	Thu, 16 Nov 2000 06:08:22 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA16404;
	Thu, 16 Nov 2000 14:41:14 +0100 (MET)
Date:   Thu, 16 Nov 2000 14:41:13 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@oss.sgi.com
Subject: Re: Build failure for R3000 DECstation
In-Reply-To: <20001116022710.E6979@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001116142410.15690A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 16 Nov 2000, Ralf Baechle wrote:

> I'm still not completly happy - it's a somewhat hackish solution.  I'm
> thinking about a special file which can be mmaped into the process address
> space and contains processor specific optimized code.  This also has other
> uses.  One that comes to my mind are trampolines.  Right now we have to
> make a syscall to flush the cache.  But on the RM7000 some cacheflush
> operations are available in userspace.  I'm sure we can come up with more
> uses.

 I don't actually think this is needed.  All I worry about are inline
functions.  They must be fast and work on anything equal or better then
the host they were built for.  Normal functions are not a problem -- they
may be converted to wrappers that call various backends indirectly.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
