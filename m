Received:  by oss.sgi.com id <S553791AbQJPPzl>;
	Mon, 16 Oct 2000 08:55:41 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:30951 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553784AbQJPPzY>;
	Mon, 16 Oct 2000 08:55:24 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA19268;
	Mon, 16 Oct 2000 17:41:45 +0200 (MET DST)
Date:   Mon, 16 Oct 2000 17:41:45 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
In-Reply-To: <39E7EB73.9206D0DB@mvista.com>
Message-ID: <Pine.GSO.3.96.1001016173427.18406D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 13 Oct 2000, Jun Sun wrote:

> b) Andreas Jaeger recommanded Ulf's patch against the CVS tree.  He
> recommanded 
> 
> ftp://oss.sgi.com/pub/linux/mips/src/binutils/binutils-000420.diff.gz.  
> 
> But I only found the following file.
> 
> ftp://oss.sgi.com/pub/linux/mips/binutils/binutils-000424.diff.gz

 I've forward-ported the patch to the final 2.10 release.  It's available
at ftp://ftp.ds2.pg.gda.pl/pub/macro/ and http://www.ds2.pg.gda.pl/~macro/
(the latter is slightly outdated though -- I need to update it from RPM
packages).

> c) Maciej reported he got binutils v2.10 working for glibc 2.2.  No
> details or any distribution.

 The package is available from ftp://ftp.ds2.pg.gda.pl/pub/macro/.  Newer
versions get uploaded as they are ready. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
