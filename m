Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 19:53:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27735 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993648AbdEVRwzTeO80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 19:52:55 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1A96D896CF7BA;
        Mon, 22 May 2017 18:52:45 +0100 (IST)
Received: from [10.20.78.50] (10.20.78.50) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 22 May 2017
 18:52:47 +0100
Date:   Mon, 22 May 2017 18:52:10 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
In-Reply-To: <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com>
Message-ID: <alpine.DEB.2.00.1705221846340.2590@tp.orcam.me.uk>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com> <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org> <002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk> <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.50]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57940
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

On Mon, 22 May 2017, David Daney wrote:

> >   I suspect it will affect more than just `show_cpuinfo', e.g. some inline
> > asm, and you could have included a justification as to why this patch is
> > correct, such as by referring to how `set_isa' sets flags in `isa_level'.
> 
> That is correct, and exactly what I said in my reply to the patch when it was
> posted.  When the OCTEON code was merged, different code paths were taken in
> the kernel, and there was a deliberate decision to structure
> mach-cavium-octeon/cpu-feature-overrides.h the way we did it.
> 
> I also noted that the information exposed to userspace via /proc/cpuinfo
> should be represented in the kernel by a distinct mechanism from how the
> kernel makes internal decisions about CPU features.

 Explicit checks for Octeon should then be used instead in the individual 
pieces of code affected, e.g.:

	if (cpu_has_mips32r1 && !cpu_mach_octeon)

or suchlike, possibly with an explanatory comment as to why such an 
exclusion has been made.  The `cpu_has_mips32r1', etc. macros are supposed 
to be generic architectural checks.

 Also any design decisions should have been noted in the description of 
the original commit.

  Maciej
