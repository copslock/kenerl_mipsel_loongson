Received:  by oss.sgi.com id <S42228AbQG1K15>;
	Fri, 28 Jul 2000 03:27:57 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17005 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42218AbQG1K1k>;
	Fri, 28 Jul 2000 03:27:40 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA11437
	for <linux-mips@oss.sgi.com>; Fri, 28 Jul 2000 03:19:49 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA23086 for <linux-mips@oss.sgi.com>; Fri, 28 Jul 2000 03:26:46 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA80721
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Jul 2000 03:25:14 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [153.19.144.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA04279
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jul 2000 03:25:11 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA27423;
	Fri, 28 Jul 2000 12:22:20 +0200 (MET DST)
Date:   Fri, 28 Jul 2000 12:22:19 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: strace on Linux/MIPS?
In-Reply-To: <3980C9F0.96B48253@mvista.com>
Message-ID: <Pine.GSO.3.96.1000728121841.24359F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 27 Jul 2000, Jun Sun wrote:

> Great!  Can you pinpoint the related files?  I took a snapshot of CVS on
> 6/27 and hacked heavily to get it work on my NEC board.  It would be
> very difficult for me to move to the new kernel.  It would be better if
> I can just reverse-merge with the related changes.

 Well, you can always take a unified diff of your own changes and try to
apply it to a new snapshot.  Depending on the amount of changes you might
need to apply certain hunks manually but the overall process is usually
quite easy. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
