Received:  by oss.sgi.com id <S42211AbQF1Ck1>;
	Tue, 27 Jun 2000 19:40:27 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:35867 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42201AbQF1CkK>;
	Tue, 27 Jun 2000 19:40:10 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA08002
	for <linux-mips@oss.sgi.com>; Tue, 27 Jun 2000 19:35:18 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA48503
	for <linux@engr.sgi.com>;
	Tue, 27 Jun 2000 19:39:41 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA00628
	for <linux@engr.sgi.com>; Tue, 27 Jun 2000 19:39:34 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id TAA19535;
	Tue, 27 Jun 2000 19:39:46 -0700
Message-ID: <39596570.68939D9@mvista.com>
Date:   Tue, 27 Jun 2000 19:39:44 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: argument mismatch in prom_init() for DDB5074?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I compiled an image for DDB5074.  I got a TLB fault immediately after
the control enters prom_init() function.  A further probe shows that the
caller are passing differents arguments to prom_init than what the
callee expected.  See code excerpt below.

Does this mean the code of DDB5074 is outdated?  In any case, can
someone give me a hint on how to fix this?  It does not look obvious at
the first sight...

=============
arch/mips/kernel/setup.c:
init_arch(...)
{
	unsigned int s;

	/* Determine which MIPS variant we are running on. */
	cpu_probe();

	prom_init(argc, argv, envp, prom_vec);

...
}

===========
arch/mips/ddb5074/prom.c:
void __init prom_init(const char *s)
{
    int i = 0;
    unsigned long mem_size, free_start, free_end, start_pfn,
bootmap_size;

//  _serinit();

    if (s != (void *)-1)
	while (*s && i < sizeof(arcs_cmdline)-1)
	    arcs_cmdline[i++] = *s++;
    arcs_cmdline[i] = '\0';
...

Jun
