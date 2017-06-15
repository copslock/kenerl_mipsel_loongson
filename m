Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 01:04:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62282 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994787AbdFOXEcOhqGr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 01:04:32 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CC7E8549EB6BA;
        Fri, 16 Jun 2017 00:04:20 +0100 (IST)
Received: from [10.20.78.209] (10.20.78.209) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 00:04:24 +0100
Date:   Fri, 16 Jun 2017 00:04:15 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 00/10] Instruction emulation fixes
Message-ID: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.209]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58483
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

 Version 2 addresses points raised in the review of the original 
submission: missing proper justification for changes #5 and #8 and an 
entirely new change #10 to lower the log priority of the noise produced.

 Please queue for the next release cycle and backport as noted with each 
of the patches.

  Maciej
