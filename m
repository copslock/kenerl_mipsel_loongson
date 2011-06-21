Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 16:43:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38871 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491165Ab1FUOnm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jun 2011 16:43:42 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5LEhfYR012652;
        Tue, 21 Jun 2011 15:43:41 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5LEhebu012648;
        Tue, 21 Jun 2011 15:43:40 +0100
Date:   Tue, 21 Jun 2011 15:43:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org, binutils@sourceware.org
Subject: XLR Linux/MIPS kernel build error
Message-ID: <20110621144340.GA11931@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17224

I'm getting a build error with gcc 4.6.0 and binutils 2.21:

[...]
  AS      arch/mips/kernel/entry.o
  AS      arch/mips/kernel/genex.o
/home/ralf/src/linux/upstream-linus/arch/mips/kernel/genex.S: Assembler messages:
/home/ralf/src/linux/upstream-linus/arch/mips/kernel/genex.S:524: Internal error!
Assertion failure in append_insn at ../../gas/config/tc-mips.c line 2867.
Please report this bug.
make[4]: *** [arch/mips/kernel/genex.o] Error 1
make[3]: *** [arch/mips/kernel] Error 2
make[2]: *** [arch/mips] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2
make: Leaving directory `/home/ralf/src/linux/obj/nlm_xlr-build'

Not sure what's blowin up there and I haven't had a chance to try other
binutils versions yet.  Is this something known?  None of the other MIPS
kernel defconfigs is encountering this issue.

  Ralf
