Received:  by oss.sgi.com id <S42281AbQGaRu5>;
	Mon, 31 Jul 2000 10:50:57 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:52780 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42245AbQGaRul>;
	Mon, 31 Jul 2000 10:50:41 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA11524
	for <linux-mips@oss.sgi.com>; Mon, 31 Jul 2000 10:43:06 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA53374
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 31 Jul 2000 10:50:16 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [153.19.144.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00125
	for <linux@cthulhu.engr.sgi.com>; Mon, 31 Jul 2000 10:50:11 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA25878;
	Mon, 31 Jul 2000 19:42:16 +0200 (MET DST)
Date:   Mon, 31 Jul 2000 19:42:16 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, jpuhlman@mvista.com
Subject: Re: Bus error of gdb 5.0 with MIPS patch
In-Reply-To: <3985B49E.58DAA36F@mvista.com>
Message-ID: <Pine.GSO.3.96.1000731194016.21648V-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 31 Jul 2000, Jun Sun wrote:

> >  What version of libc?
> 
> It is glibc 2.0.7.  Pretty old, but I don't think there is a newer one
> working stably with MIPS.

 Well, I can't test that, I am afraid.  I am only using glibc 2.2 (which
is 2.1.91 at the moment).  It works quite well, but I wouldn't name it
stable yet, I admit.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
