Received:  by oss.sgi.com id <S42248AbQI2Jgo>;
	Fri, 29 Sep 2000 02:36:44 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:53424 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42190AbQI2JgS>;
	Fri, 29 Sep 2000 02:36:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA17242;
	Fri, 29 Sep 2000 11:36:07 +0200 (MET DST)
Date:   Fri, 29 Sep 2000 11:36:07 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
In-Reply-To: <20000928214002.B767@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1000929112103.16748A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 28 Sep 2000, Florian Lohoff wrote:

> since this commit my machines are all broken (5000/260, 5000/150 
> and 5000/125) - They all hang in the "Calibrating delay loop ...".

 Well, I asked for testing before the commit, but nobody bothered to write
anything, so I assumed everything is correct, sigh...

 OK, the /240 is definitely tested (the uptime of my -test7 was three
weeks before I rebooted to test NFS problems) so /260 should work for you. 
But the latter is R4K.  As Ralf already remarked me in a separate mail,
64-bit registers can get corrupted for the 32-bit kernel (but 64-bit code
is used throughout the kernel, strange), so please change the "#if
_MIPS_ISA" at the beginning of include/asm-mips/div64.h into "#if 1" and
tell me if it works for the /260. 

 As for the rest -- /125 is R3K, right?  Chances are I made a stupid
mistake and defined an address macro wrong.  I'll dig through the changes
and see (/150 should be no problem once /125 works, as it's the same issue
as /240 vs /260).  If I can't find anything relevant, please expect
certain debugging patches from me for the /125 path.

 Note that these are hi-res timer changes rather than NTP fixes, BTW -- my
communication channel with Ralf got corrupted somehow at one time. 
Although the code affects the performance of NTP handling, there were
separate NTP changes, as well. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
