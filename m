Received:  by oss.sgi.com id <S42204AbQF1Hh2>;
	Wed, 28 Jun 2000 00:37:28 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17250 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42201AbQF1HhF>;
	Wed, 28 Jun 2000 00:37:05 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA29006
	for <linux-mips@oss.sgi.com>; Wed, 28 Jun 2000 00:32:13 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA12929
	for <linux@engr.sgi.com>;
	Wed, 28 Jun 2000 00:36:13 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net ([62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA06673
	for <linux@engr.sgi.com>; Wed, 28 Jun 2000 00:36:11 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port105.duesseldorf.ivm.de [195.247.65.105])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id JAA01601;
	Wed, 28 Jun 2000 09:35:21 +0200
X-To:   linux@engr.sgi.com
Message-ID: <XFMail.000628093522.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <39596570.68939D9@mvista.com>
Date:   Wed, 28 Jun 2000 09:35:22 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Jun Sun <jsun@mvista.com>
Subject: RE: argument mismatch in prom_init() for DDB5074?
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 28-Jun-00 Jun Sun wrote:
> 
> I compiled an image for DDB5074.  I got a TLB fault immediately after
> the control enters prom_init() function.  A further probe shows that the
> caller are passing differents arguments to prom_init than what the
> callee expected.  See code excerpt below.
> 
> Does this mean the code of DDB5074 is outdated?  In any case, can
> someone give me a hint on how to fix this?  It does not look obvious at
> the first sight...

That's probably ok. The different bootloaders on different platforms loaders pass
different arguments to the kernel.

harry@localhost:~> cd linux/arch/mips
harry@localhost:~/linux/arch/mips > grep prom_init\( `find . -name '*.c'`
./arc/init.c:int __init prom_init(int argc, char **argv, char **envp,
int*prom_vec)
./baget/prom/init.c:int __init prom_init(unsigned int mem_upper)
./ddb5074/prom.c:void __init prom_init(const char *s)
./dec/prom/init.c:int __init prom_init(int argc, char **argv,
./kernel/setup.c:extern int prom_init(int, char **, char **, int *);
./kernel/setup.c:       prom_init(argc, argv, envp, prom_vec);                   
                       
The call in setup.c just has to make shure that all possible arguments are passed
to the platform specific prom_init(). How they are interpreted is up to
prom_init().

-- 
Regards,
Harald
