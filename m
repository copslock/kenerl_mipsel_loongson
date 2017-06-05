Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 01:14:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24276 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993870AbdFEXOT4GAtM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 01:14:19 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 311C068EFB7E6;
        Tue,  6 Jun 2017 00:14:08 +0100 (IST)
Received: from [10.20.78.130] (10.20.78.130) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 6 Jun 2017
 00:14:12 +0100
Date:   Tue, 6 Jun 2017 00:14:03 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 0/9] Instruction emulation fixes
Message-ID: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.130]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Ralf,

 Here is a bunch of instruction emulation fixes and clean-ups, mostly 
though not only affecting branches in the FPU emulator.  The severity of 
failures addressed varies, see the individual patch descriptions for 
details.  These patches have been verified to a varying extent, depending 
on the nature of the individual change, by running the GCC and glibc test 
suites for the MIPS16 o32 little-endian multilib.

 NB I don't know why `checkpatch.pl' complains about the correctly 
line-wrapped commit references with some of these patches.

 Please queue for the next release cycle and backport as noted with each 
of the patches.

 NB there is also an API mismatch between `init_fpu' returning SIGFPE and 
its caller `__compute_return_epc_for_insn', however I can't figure out why 
the incorrect return status is only passed up if NO_R6EMU, so I'm leaving 
it to whoever understands the dependency here to fix up.  Offhand it looks 
to me like the whole containing `!used_math()' conditional is bogus though 
-- we've got an exception in a delay slot of a COP1 branch, so the FPU 
clearly must have been used already or we wouldn't have reached the delay 
slot to trap in in the first place.  For the same reason we do not need to 
check `cpu_has_mips_r6' other than for telling overlapping R6 BC1EQZ and 
MIPS-3D BC1ANY2 minor opcodes apart, which we don't do anyway.

 So more fixes and clean-ups are due around here it would seem.  But this 
is too much for the amount of time I can afford right now, so I'll be 
leaving them for the next opportunity.

  Maciej
