Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jul 2004 20:52:48 +0100 (BST)
Received: from gw-nam4.philips.com ([IPv6:::ffff:161.88.253.58]:60065 "EHLO
	gw-nam4.philips.com") by linux-mips.org with ESMTP
	id <S8225009AbUG1Two>; Wed, 28 Jul 2004 20:52:44 +0100
Received: from smtpscan-nam4.philips.com (smtpscan-nam4.mail.philips.com [167.81.103.7])
	by gw-nam4.philips.com (Postfix) with ESMTP id 369F996085
	for <linux-mips@linux-mips.org>; Wed, 28 Jul 2004 19:52:37 +0000 (UTC)
Received: from smtpscan-nam4.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 16D0195
	for <linux-mips@linux-mips.org>; Wed, 28 Jul 2004 19:52:37 +0000 (GMT)
Received: from smtprelay-nam2.philips.com (smtprelay-nam2.philips.com [167.81.103.9])
	by smtpscan-nam4.philips.com (Postfix) with ESMTP id E38246B
	for <linux-mips@linux-mips.org>; Wed, 28 Jul 2004 19:52:36 +0000 (GMT)
Received: from anrrmh02.diamond.philips.com (anrrmh02-srv.diamond.philips.com [167.81.112.96]) 
	by smtprelay-nam2.philips.com (8.9.3p3/8.9.3-1.2.2m-20040401) with ESMTP id TAA26770
	for <linux-mips@linux-mips.org>; Wed, 28 Jul 2004 19:52:36 GMT
From: greg.roelofs@philips.com
To: <linux-mips@linux-mips.org>
Subject: apparent math-emu hang on movf instruction
Date: Wed, 28 Jul 2004 12:54:04 -0700
Message-ID: <OFFE4A0198.56A3A2A2-ON88256EDF.006D0D9F@philips.com>
X-MIMETrack: Serialize by Router on anrrmh02/H/SERVER/PHILIPS(Release 6.0.2CF1HF681 | June
 22, 2004) at 28/07/2004 15:51:10,
	Serialize complete at 28/07/2004 15:51:10
MIME-Version: 1.0
Return-Path: <greg.roelofs@philips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.roelofs@philips.com
Precedence: bulk
X-list: linux-mips

I hope this isn't a FAQ or a complete newbie oversight, but I haven't
found any mention of a similar problem in the FAQs or in the last 18
months' archives of this list.

I have some floating-point code that hangs, apparently on a movf
instruction, with CPU usage pegged at 99%.  It's interruptible, but
that's the best that can be said about it.

The C code in question is a simple comparison of an integer array
element with a floating-point constant (0.0, in fact).  When (cross-)
compiled with either gcc 3.3.4 or 3.3.1 and -O1 (or -O2) and -mtune=r4600
-mips32, it generates the movf instruction.  Compiled either without
optimization or without the r4600/mips32 options, it generates a branch
instead; that version works.  My attempts so far to create a simplified
test case have not succeeded; it seems to be slightly tricky to get GCC
to emit this instruction.  (I'm not an expert in either GCC, the Linux
kernel, or MIPS hardware, btw, so apologies if I'm completely off-track
here.)

The kernel is question is a 2.4.20 derivative (MontaVista Linux 3.1),
and the processor is a Philips PR4450:  MIPS32 core, no floating-point,
some minor extensions and timing differences in a few instructions.
We're using the kernel's FP emulation rather than GCC's soft-float,
and my working assumption at this point is that it's a problem with
the emulation, since movf is described as "move conditional on floating-
point false."

	Q1:  Is that a correct assumption?

I've just started looking at the kernel's emulation code, and one thing
that pops out immediately is that there's no mention of movf anywhere
in arch/mips/math-emu, though cp1emu.c does cover movc, movn, movz, and
plain mov (at least, their .fmt variants).  Nor does the latest(?) CVS
version (http://www.linux-mips.org/cvsweb/linux/arch/mips/math-emu/
cp1emu.c?rev=1.32&content-type=text/x-cvsweb-markup).  On the other hand,
they also don't mention bc1t, "branch on FP true"--which works--so I'm
probably not on the right track here.

	Q2:  Am I?  I would have expected an unemulated instruction to
	     throw an illegal instruction exception or cause an oops or
	     something, not to spin indefinitely.

	Q3:  Any suggestions for what to test/look at/do next?

(Of course, it's also possible that it's a hardware problem of some sort,
although it doesn't feel that way to me.  Then again, I don't trust such
feelings very far...)

Here's the C code that fails:

	if (a[m][n] != 0.0)
	    i++;

Here's its assembler output ($f20 was previously loaded with zero via
"mtc1 $0,$f20", and $16 contains the pointer a[m]):

        l.s     $f2,0($16)      # $f2 = a[m][n]  (32-bit)
        lw      $3,24($sp)      # $3 = i
        cvt.d.w $f0,$f2         # FP: convert int32 ($f2) to double ($f0)
        c.eq.d  $f0,$f20        # FP: conditional:  $f0 == $f20 ?
        addu    $2,$3,1         # add unsigned:  $2 = i + 1
        la      $4,$LC32        # "DEBUG:  checking ..." (later printf)
        movf    $3,$2,$fcc0     # move if FP false (fcc0 = 0):  $3 = $2 = i+1
        sw      $3,24($sp)      # i = $3 (store on stack)
	 ... [printf stuff, etc.]

Thanks for any help/suggestions,
-- 
Greg Roelofs            `Name an animal that's small and fuzzy.' `Mold.'
Philips Semiconductors   greg.roelofs@philips.com
