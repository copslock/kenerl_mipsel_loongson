Received:  by oss.sgi.com id <S42299AbQGaQ00>;
	Mon, 31 Jul 2000 09:26:26 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:47379 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42233AbQGaQ0N>;
	Mon, 31 Jul 2000 09:26:13 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA29920
	for <linux-mips@oss.sgi.com>; Mon, 31 Jul 2000 09:18:39 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id JAA78473 for <linux-mips@oss.sgi.com>; Mon, 31 Jul 2000 09:24:25 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA26111
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 31 Jul 2000 09:22:52 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [153.19.144.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09536
	for <linux@cthulhu.engr.sgi.com>; Mon, 31 Jul 2000 09:22:46 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA23850;
	Mon, 31 Jul 2000 18:22:36 +0200 (MET DST)
Date:   Mon, 31 Jul 2000 18:22:36 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com, jpuhlman@mvista.com
Subject: Re: Bus error of gdb 5.0 with MIPS patch
In-Reply-To: <398300E5.143F5370@mvista.com>
Message-ID: <Pine.GSO.3.96.1000731180916.21648P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 29 Jul 2000, Jun Sun wrote:

> (gdb) n
> [tcsetpgrp failed in terminal_inferior: Not a typewriter]
> Bus error
> 
> -----------
> 
> P.S., Does anybody know how to fix "tcsetpgrp ..." error?

 Hmm, I believe it indicates a problem with the shell.  I used to observe
it when my glibc disagreed with my kernel about struct stat64.  Try to
disable large file support for the shell until struct stat64 gets fixed. 

 About the bus error -- try to compile gdb with debugging support and make
it dump core on the bus error (you might need to tweak ulimit).  Then try
to locate the crash address with gdb (`info stack' might be particularly
useful).  It's most likely gdb cannot figure an address of the next
instruction properly.

 What version of libc?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
