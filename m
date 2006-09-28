Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 14:08:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23243 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038643AbWI1NIe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 14:08:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8SD9RQH032318;
	Thu, 28 Sep 2006 14:09:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8SD9PmS032317;
	Thu, 28 Sep 2006 14:09:25 +0100
Date:	Thu, 28 Sep 2006 14:09:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: wrong SP restored after DBE exception
Message-ID: <20060928130925.GA3394@linux-mips.org>
References: <17690.54995.407882.581783@zeus.sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17690.54995.407882.581783@zeus.sw.starentnetworks.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 27, 2006 at 03:53:55PM -0400, Dave Johnson wrote:

> I'm running into an odd problem with the DBE exception handler.

There is a fundamental problem with the way unmaskable exceptions other
than cache errors and NMI are handled.  This is the disassembly of the
kernel's exception entry path starting at the general exception vector:

a8000000003bae20 <except_vec3_generic>:
a8000000003bae20:       401b6800        mfc0    k1,$13
a8000000003bae24:       337b007c        andi    k1,k1,0x7c
a8000000003bae28:       001bd878        dsll    k1,k1,0x1
a8000000003bae2c:       3c1a003f        lui     k0,0x3f
a8000000003bae30:       035bd02d        daddu   k0,k0,k1
a8000000003bae34:       df5ad2d8        ld      k0,-11560(k0)
a8000000003bae38:       03400008        jr      k0
a8000000003bae3c:       00000000        nop
[...]

A few types of exceptions will be handled by just using $k0 and $k1; must
will save the registers right away:

[...]
a800000000020440:       401a6000        mfc0    k0,$12
a800000000020444:       001ad0c0        sll     k0,k0,0x3
a800000000020448:       0740000a        bltz    k0,0xa800000000020474
a80000000002044c:       03a0d82d        move    k1,sp
a800000000020450:       403b2000        dmfc0   k1,$4
a800000000020454:       3c1aa800        lui     k0,0xa800
a800000000020458:       001bddfa        dsrl    k1,k1,0x17
a80000000002045c:       675a0000        daddiu  k0,k0,0
a800000000020460:       001ad438        dsll    k0,k0,0x10
a800000000020464:       675a0043        daddiu  k0,k0,67
a800000000020468:       001ad438        dsll    k0,k0,0x10
a80000000002046c:       037ad82d        daddu   k1,k1,k0
a800000000020470:       df7bf008        ld      k1,-4088(k1)
a800000000020474:       03a0d02d        move    k0,sp
a800000000020478:       677dfed0        daddiu  sp,k1,-304
a80000000002047c:       ffba00e8        sd      k0,232(sp)
(c0_status.exl is cleared a mile further down)
[...]

If we take a DBE exception in this code we're in trouble and I've seen
systems delivering DBEs highly asynchronously.  Afar the Broadcom SOCs
fall into that class.

So the interesting part is if we take a data bus exception between
the stack pointer adjustment and and before EXL is cleared.  We're taking
a nested exception so c0_epc and c0_cause.bd will not be updated.  So
when the bus error handler will save the $sp value it saw on entry but
will return to the EPC of the first exception, that is only one stack
frame will be popped.  Whops ...

  Ralf
