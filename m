Received:  by oss.sgi.com id <S305157AbQDTNC2>;
	Thu, 20 Apr 2000 06:02:28 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:49176 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQDTNCE>; Thu, 20 Apr 2000 06:02:04 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA08953; Thu, 20 Apr 2000 06:06:06 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA78323
	for linux-list;
	Thu, 20 Apr 2000 05:47:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA85489
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 05:47:00 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA06195
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 05:46:58 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 94799802; Thu, 20 Apr 2000 14:46:59 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 643D18FC4; Thu, 20 Apr 2000 14:41:39 +0200 (CEST)
Date:   Thu, 20 Apr 2000 14:41:39 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: Should send SIGFPE to .*
Message-ID: <20000420144139.F1247@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
i just rediscovered the kernel messages in the kern.log ...

Apr 19 20:12:41 repeat kernel: Setting flush to zero for top.
Apr 19 20:12:41 repeat kernel: Unimplemented exception for insn 46001124 at 0x00403588 in top.
Apr 19 20:12:41 repeat kernel: Should send SIGFPE to top

This is something i not really understand - After "Setting flush to zero" the
instruction is "retried" and enters the exception again and say
"Unimplemented exception" which means - The CPU doesnt support it
and then "Simulates" this instruction in "simfp(insn)" - Until
now nothing bad has happened and these two kernel messages
should be encapsulated by a "#if DEBUG_FP_EXCEPTION" or something.

Now i get an "Should send SIGFPE to top" which i dont understand - Shouldnt
SIGFPE signal Floating Point errors (like div by zero) - As the code
gets simulated in simfp this function should be responsible for 
sending the signal if something goes wrong ?

arch/mips/kernel/traps.c

    354                 printk(KERN_DEBUG "Unimplemented exception for insn %08x at 0x%08lx in %s.\n",
    355                        insn, regs->cp0_epc, current->comm);
    356                 simfp(insn);
    357         }
    358 
    359         if (compute_return_epc(regs))
    360                 goto out;
    361         //force_sig(SIGFPE, current);
    362         printk(KERN_DEBUG "Should send SIGFPE to %s\n", current->comm);
    363 
    364 out:
    365         unlock_kernel();


Might it be that compute_return_epc in branch.c does not support
the mentioned instructions (FP instructions ?) and though can not
calculate the correct epc ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."iii
