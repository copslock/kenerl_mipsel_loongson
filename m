Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2003 23:46:26 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:57003 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225425AbTLKXq0>; Thu, 11 Dec 2003 23:46:26 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 62A1F47607; Fri, 12 Dec 2003 00:46:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 08CE72D328; Fri, 12 Dec 2003 00:46:23 +0100 (CET)
Date: Fri, 12 Dec 2003 00:46:23 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Steven J. Hill" <sjhill@realitydiluted.com>,
	durai <durai@isofttech.com>,
	uclinux-dev <uclinux-dev@uclinux.org>,
	mips <linux-mips@linux-mips.org>
Subject: Re: Network problem in mips
In-Reply-To: <20031211233058.GB20373@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0312120037480.23228@jurand.ds.pg.gda.pl>
References: <008f01c3bff7$252e3b40$0a05a8c0@DURAI> <3FD88C4D.6010700@realitydiluted.com>
 <1071184052.19738.12.camel@dhcp23.swansea.linux.org.uk>
 <20031211233058.GB20373@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 12 Dec 2003, Ralf Baechle wrote:

> > Seems a little out of order. Not everyone immediately understands you
> > need the ksyms to interpret a trace
> 
> Guess that should be mentioned in the FAQ - anybody got a pointer to a
> little how to for writing useful bug reports?

 Well, REPORTING-BUGS in the Linux source seems pretty good for a start.  
README provides a few hints as well, although with a little bias towards
i386.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
