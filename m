Received:  by oss.sgi.com id <S42210AbQJFMM0>;
	Fri, 6 Oct 2000 05:12:26 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:6532 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42201AbQJFMMA>;
	Fri, 6 Oct 2000 05:12:00 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA01333;
	Fri, 6 Oct 2000 14:05:13 +0200 (MET DST)
Date:   Fri, 6 Oct 2000 14:05:13 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Keith Owens <kaos@melbourne.sgi.com>
cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: insmod hates RELA? 
In-Reply-To: <22488.970829822@ocs3.ocs-net>
Message-ID: <Pine.GSO.3.96.1001006135933.1204A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 6 Oct 2000, Keith Owens wrote:

> Against modutils 2.3.17.  Does 2.3.17+this patch work on mips?

 That's exactly my patch. ;-)  Yes -- it stops complaining, but it doesn't
make it load the ipv6 module (the only one I have) successfully (the
kernel crashes, IIRC). I suppose it's not a modutils' fault, though -- my
development environment is not as stable as I wish so this may actually be
a gcc, binutils or kernel issue.  Unfortunately I cannot afford tracking
it down at the moment, but I'll look into it when I can.  Anyone feel free
to study the case independently.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
