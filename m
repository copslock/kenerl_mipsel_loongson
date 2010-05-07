Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 May 2010 15:33:44 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43782 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491037Ab0EGNdl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 May 2010 15:33:41 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o47DXZcG019013;
        Fri, 7 May 2010 14:33:36 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o47DXWTf018990;
        Fri, 7 May 2010 14:33:32 +0100
Date:   Fri, 7 May 2010 14:33:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     anemo@mba.ocn.ne.jp, kevink@paralogos.com,
        linux-mips@linux-mips.org, sshtylyov@mvista.com
Subject: Re: [PATCH v3] MIPS FPU emulator: allow Cause bits of FCSR to be
 writeable by ctc1
Message-ID: <20100507133331.GA18814@linux-mips.org>
References: <E1OAG5R-0003hc-AY@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1OAG5R-0003hc-AY@localhost>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 06, 2010 at 11:26:57PM -0600, Shane McDonald wrote:

> In the FPU emulator code of the MIPS, the Cause bits of the FCSR
> register are not currently writeable by the ctc1 instruction.
> In odd corner cases, this can cause problems.  For example,
> a case existed where a divide-by-zero exception was generated
> by the FPU, and the signal handler attempted to restore the FPU
> registers to their state before the exception occurred.  In this
> particular setup, writing the old value to the FCSR register
> would cause another divide-by-zero exception to occur immediately.
> The solution is to change the ctc1 instruction emulator code to
> allow the Cause bits of the FCSR register to be writeable.
> This is the behaviour of the hardware that the code is emulating.
> 
> This problem was found by Shane McDonald, but the credit for the
> fix goes to Kevin Kissell.  In Kevin's words:
> 
> I submit that the bug is indeed in that ctc_op:  case of the emulator.  The
> Cause bits (17:12) are supposed to be writable by that instruction, but the
> CTC1 emulation won't let them be updated by the instruction.  I think that
> actually if you just completely removed lines 387-388 [...]
> things would work a good deal better.  At least, it would be a more accurate
> emulation of the architecturally defined FPU.  If I wanted to be really,
> really pedantic (which I sometimes do), I'd also protect the reserved bits
> that aren't necessarily writable.

Committed a few your ago.  Thanks Shane!

  Ralf
