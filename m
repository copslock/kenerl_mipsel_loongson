Received:  by oss.sgi.com id <S42257AbQI2UYN>;
	Fri, 29 Sep 2000 13:24:13 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:37647 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42239AbQI2UYA>;
	Fri, 29 Sep 2000 13:24:00 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 794567DD; Fri, 29 Sep 2000 22:23:58 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8B7489014; Fri, 29 Sep 2000 22:22:27 +0200 (CEST)
Date:   Fri, 29 Sep 2000 22:22:27 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000929222227.C396@paradigm.rfc822.org>
References: <20000928214002.B767@paradigm.rfc822.org> <Pine.GSO.3.96.1000929112103.16748A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.GSO.3.96.1000929112103.16748A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Sep 29, 2000 at 11:36:07AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 29, 2000 at 11:36:07AM +0200, Maciej W. Rozycki wrote:
>  As for the rest -- /125 is R3K, right?  Chances are I made a stupid

Yep

> mistake and defined an address macro wrong.  I'll dig through the changes
> and see (/150 should be no problem once /125 works, as it's the same issue
> as /240 vs /260).  If I can't find anything relevant, please expect
> certain debugging patches from me for the /125 path.

/125 dies 

>>boot
1532656+0+141200
This DECstation is a DS5000/1xx
Loading R[23]00 MMU routines.
CPU revision is: 00000230
Primary instruction cache 64kb, linesize 4 bytes
Primary data cache 64kb, linesize 4 bytes
Linux version 2.4.0-test8-pre1 (flo@slimer.rfc822.org) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #1 Fri Sep 29 20:09:51 GMT 2000
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS2 root=/dev/sda1
Calibrating delay loop... 

Hang ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
