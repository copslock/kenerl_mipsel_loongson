Received:  by oss.sgi.com id <S305176AbPLHXDP>;
	Wed, 8 Dec 1999 15:03:15 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:30544 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305175AbPLHXC5>; Wed, 8 Dec 1999 15:02:57 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA09959; Wed, 8 Dec 1999 15:12:04 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA20855
	for linux-list;
	Wed, 8 Dec 1999 14:46:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA78856
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Dec 1999 14:46:40 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from tower.ti.com (tower.ti.com [192.94.94.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA04481
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Dec 1999 14:46:18 -0800 (PST)
	mail_from (jharrell@ti.com)
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by tower.ti.com (8.9.3/8.9.3) with ESMTP id QAA18767
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Dec 1999 16:46:07 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA15864
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Dec 1999 16:45:45 -0600 (CST)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA15855
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Dec 1999 16:45:44 -0600 (CST)
Received: from dlep4.itg.ti.com (localhost [127.0.0.1])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA10622
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Dec 1999 16:46:06 -0600 (CST)
Received: from ti.com (IDENT:jharrell@c2k-udp232688uds.sc.ti.com [158.218.100.100])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id QAA10614
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Dec 1999 16:46:05 -0600 (CST)
Message-ID: <384EDFC5.FFAE939A@ti.com>
Date:   Wed, 08 Dec 1999 15:46:29 -0700
From:   Jeff Harrell <jharrell@ti.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     sgi-mips <linux@cthulhu.engr.sgi.com>
Subject: Exceptions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I have been working through the initialization code for the MIPS/Linux
kernel and have traced through to the point
where the MIPS exceptions are installed.  I have not been able to locate
the following routines

        handle_adel
        handle_ades
        handle_sys
        handle_bp
        handle_n
        handle_cpu
        handle_ov
        handle_tr
        handle_fpe

I see where these are defined by "extern asmlinkage" references but
can't locate the actual implementation of these
exceptions.  Any idea what files these routines might be located in?
Any help would be greatly appreciated

Thank you,
Jeff Harrell


---------8< excerpt from kernel/traps.c -----

 set_except_vector(1, handle_mod);
 set_except_vector(2, handle_tlbl);
 set_except_vector(3, handle_tlbs);
 set_except_vector(4, handle_adel);
 set_except_vector(5, handle_ades);
 /*
  * The Data Bus Error/ Instruction Bus Errors are signaled
  * by external hardware.  Therefore these two expection have
  * board specific handlers.
  */
 set_except_vector(6, handle_ibe);
 set_except_vector(7, handle_dbe);
 ibe_board_handler = default_be_board_handler;
 dbe_board_handler = default_be_board_handler;

 set_except_vector(8, handle_sys);
 set_except_vector(9, handle_bp);
 set_except_vector(10, handle_ri);
 set_except_vector(11, handle_cpu);
 set_except_vector(12, handle_ov);
 set_except_vector(13, handle_tr);
 set_except_vector(15, handle_fpe);


--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
