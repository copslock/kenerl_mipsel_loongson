Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 May 2017 03:38:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58817 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994896AbdEUBhxZeph4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 May 2017 03:37:53 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 99DAD308F1D27;
        Sun, 21 May 2017 02:37:45 +0100 (IST)
Received: from [10.20.78.45] (10.20.78.45) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Sun, 21 May 2017
 02:37:46 +0100
Date:   Sun, 21 May 2017 02:37:09 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Petar Jovanovic <Petar.Jovanovic@imgtec.com>
CC:     Petar Jovanovic <petar.jovanovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
In-Reply-To: <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org>
Message-ID: <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com>,<001b01d2ae25$d7554b80$85ffe280$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org>,<002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.45]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57905
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

On Mon, 15 May 2017, Petar Jovanovic wrote:

> Define Cavium Octeon as a CPU that has support for mips32r1, mips32r2 and
> mips64r1. This will affect show_cpuinfo() that will now correctly expose
> mips32r1, mips32r2 and mips64r1 as supported ISAs.

 I suspect it will affect more than just `show_cpuinfo', e.g. some inline 
asm, and you could have included a justification as to why this patch is 
correct, such as by referring to how `set_isa' sets flags in `isa_level'.  
Anyway it LGTM, so:

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

 Such problems pop up from time to time, so overall we probably want to 
have a consistency check with a BUG_ON or suchlike implemented somewhere, 
preferably once the console is running so that the kernel does not just 
silently hang without output, iterating over these macros and verifying 
against actual CPU info.

 HTH,

  Maciej
