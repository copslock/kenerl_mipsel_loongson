Received:  by oss.sgi.com id <S553767AbRAHOwr>;
	Mon, 8 Jan 2001 06:52:47 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:40206 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553764AbRAHOwZ>;
	Mon, 8 Jan 2001 06:52:25 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 024857F6; Mon,  8 Jan 2001 15:52:22 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id DA104F44B; Mon,  8 Jan 2001 15:53:02 +0100 (CET)
Date:   Mon, 8 Jan 2001 15:53:02 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Current CVS kernel no-go on R4k Decstation 
Message-ID: <20010108155302.A18422@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
i am seeing this on my R4k Decstation (5000/150) 

This was the first try 

[...]
Freeing unused PROM memory: 124k freed
Freeing unused kernel memory: 60k freed
[init:1] Illegal instruction 0320f809 at 0fb651c4 ra=0fb651cc
[init:1] Illegal instruction 8f998018 at 0fb651c8 ra=0fb651cc

Second try doesnt give me any output at all after
the "Freeing unused kernel ..."

CVS Checkout @ 20010108 ~15:00 MESZ

This DECstation is a DS5000/1xx
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes.
Primary data cache 8kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.0-test11 (flo@paradigm) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #1 Mon Jan 8 15:35:19 CET 2001
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS2 root=/dev/sda2
Calibrating delay loop... 49.81 BogoMIPS
Memory: 62600k/65536k available (1269k kernel code, 2936k reserved, 69k data, 60k init)
[...]

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
