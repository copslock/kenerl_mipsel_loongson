Received:  by oss.sgi.com id <S305164AbQBRJr6>;
	Fri, 18 Feb 2000 01:47:58 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:41580 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQBRJrz>;
	Fri, 18 Feb 2000 01:47:55 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA03754; Fri, 18 Feb 2000 01:43:24 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA19578
	for linux-list;
	Fri, 18 Feb 2000 01:30:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA01698
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 18 Feb 2000 01:29:59 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA01933
	for <linux@cthulhu.engr.sgi.com>; Fri, 18 Feb 2000 01:29:52 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 99BDF7F5; Fri, 18 Feb 2000 10:29:39 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 09AED8FC4; Fri, 18 Feb 2000 10:25:06 +0100 (CET)
Date:   Fri, 18 Feb 2000 10:25:05 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Current cvs kernerl fails to compile for decstation
Message-ID: <20000218102505.B369@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On Decstation:


make[3]: Entering directory `/data/kernel/linux/drivers/net'
gcc -D__KERNEL__ -I/data/kernel/linux/include -Wall -Wstrict-prototypes -O2 -fom
it-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -pipe    -DEXPOR
T_SYMTAB -c slhc.c
In file included from slhc.c:74:
/data/kernel/linux/include/net/tcp.h:343: #error HZ != 100 && HZ != 1024.
make[3]: *** [slhc.o] Error 1
make[3]: Leaving directory `/data/kernel/linux/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/data/kernel/linux/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/data/kernel/linux/drivers'
make: *** [_dir_drivers] Error 2


------------

#if HZ == 100
#define TCP_TW_RECYCLE_TICK (7+2-TCP_TW_RECYCLE_SLOTS_LOG)
#elif HZ == 1024
#define TCP_TW_RECYCLE_TICK (10+2-TCP_TW_RECYCLE_SLOTS_LOG)
#else
#error HZ != 100 && HZ != 1024.
#endif

-------------

Hrmpf ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
