Received:  by oss.sgi.com id <S42380AbQI1TEc>;
	Thu, 28 Sep 2000 12:04:32 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:48146 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42347AbQI1TES>;
	Thu, 28 Sep 2000 12:04:18 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C5F437DD; Thu, 28 Sep 2000 21:04:16 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3DF3F9014; Thu, 28 Sep 2000 20:53:59 +0200 (CEST)
Date:   Thu, 28 Sep 2000 20:53:59 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: R3k Decstation broken
Message-ID: <20000928205359.A767@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
it seems the r3k decstation stuff is broken 

>>boot 3/tftp console=ttyS2
1532656+0+130384
This DECstation is a DS5000/1xx
Loading R[23]00 MMU routines.
CPU revision is: 00000230
Primary instruction cache 64kb, linesize 4 bytes
Primary data cache 64kb, linesize 4 bytes
Linux version 2.4.0-test8-pre1 (flo@slimer.rfc822.org) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #3 Thu Sep 28 18:40:38 GMT 2000
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS2
Calibrating delay loop... 

Full Stop !

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
