Received:  by oss.sgi.com id <S305167AbQASRK2>;
	Wed, 19 Jan 2000 09:10:28 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:27460 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305165AbQASRKN>; Wed, 19 Jan 2000 09:10:13 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA07535; Wed, 19 Jan 2000 09:14:32 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA13621
	for linux-list;
	Wed, 19 Jan 2000 08:58:55 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA65552
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Jan 2000 08:58:35 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from tower.ti.com (tower.ti.com [192.94.94.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA02043
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Jan 2000 08:58:14 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep6.itg.ti.com ([157.170.188.9])
	by tower.ti.com (8.9.3/8.9.3) with ESMTP id KAA16824;
	Wed, 19 Jan 2000 10:58:03 -0600 (CST)
Received: from dlep6.itg.ti.com (localhost [127.0.0.1])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA16500;
	Wed, 19 Jan 2000 10:57:58 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA16488;
	Wed, 19 Jan 2000 10:57:57 -0600 (CST)
Received: from ti.com (IDENT:jharrell@pcp97780pcs.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA26345;
	Wed, 19 Jan 2000 10:58:01 -0600 (CST)
Message-ID: <3885ED9B.C8969F26@ti.com>
Date:   Wed, 19 Jan 2000 10:00:11 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     sgi-mips <linux@cthulhu.engr.sgi.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>, bbrown <bbrown@ti.com>,
        vwells <vwells@ti.com>, kmcdonald <kmcdonald@ti.com>,
        mhassler <mhassler@ti.com>
Subject: Question concerning cache coherency
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I have an interesting issue that I would like to run past the MIPS/Linux
newsgroup.  I am
currently porting the MIPS/Linux code to a development board that has a
IDT64475 MIPS
core (64-bit R4xxx core).  I notice that this part does not have any
method of maintaining
cache coherency (i.e., no hardware support for cache coherency).  It is
highly likely that we
will be plugging in a network card on a PCI bus that would be DMA'ing to
a shared memory
space in SDRAM.  I assume that the problem of cache coherency is fixed
by mapping the shared
memory as uncached.  I have not dug into the network drivers (or the
kernel) enough to know whether
this is how the problem is addressed on typical MIPS architectures.  I
guess I have two questions
related to this issue;  Do devices that DMA, typically access uncached
memory  and if so, is a second buffer
required to copy from kernel to user space?  The second question is
concerning the performance hit in
running out of uncached memory,  Have people seen significant
performance degradation when
using uncached memory.  Any insight that anybody can provide would be
greatly appreciated.

Thanks,
Jeff


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
