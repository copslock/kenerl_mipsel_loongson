Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 01:52:56 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:62576 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992212AbcJFXwtDVIqi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 01:52:49 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E3A418851DC1E;
        Fri,  7 Oct 2016 00:52:37 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 7 Oct 2016
 00:52:42 +0100
Received: from [10.20.78.81] (10.20.78.81) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 7 Oct 2016
 00:52:41 +0100
Date:   Fri, 7 Oct 2016 00:52:32 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix -mabi=64 build of vdso.lds
In-Reply-To: <a226de28606d340f3e4cf0d6f6f4b4d12e766a69.1475791723.git-series.james.hogan@imgtec.com>
Message-ID: <alpine.DEB.2.00.1610062349100.31859@tp.orcam.me.uk>
References: <a226de28606d340f3e4cf0d6f6f4b4d12e766a69.1475791723.git-series.james.hogan@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-7"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.20.78.81]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55364
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

On Thu, 6 Oct 2016, James Hogan wrote:

> The native ABI vDSO linker script vdso.lds is built by preprocessing
> vdso.lds.S, with the native -mabi flag passed in to get the correct ABI
> definitions. Unfortunately however certain toolchains choke on -mabi=64
> without a corresponding compatible -march flag, for example:
> 
> cc1: error: ¡-march=mips32r2¢ is not compatible with the selected ABI
> scripts/Makefile.build:338: recipe for target 'arch/mips/vdso/vdso.lds' failed
> 
> Fix this by including ccflags-vdso in the KBUILD_CPPFLAGS for vdso.lds,
> which includes the appropriate -march flag.
> 
> Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.4.x-
> ---

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

 NB by default GCC is configured for the default of `-march=from-abi', 
which is why saying `-mabi=64' only often works as such GCC implicitly 
switches to a compatible `-march=' setting (i.e. `mips3' vs `mips1' for 
o32).  However when configured with `-march=' set to a particular ISA 
level, such as `mips32r2' quoted above you need to select a compatible ISA 
explicitly when switching to a 64-bit ABI (arguably you could configure 
with `-march=mips64r2' instead as with a 32-bit ABI such a setting would 
limit the instruction set to the 32-bit subset automatically).

 Also I've noticed $(aflags-vdso) duplicate `-I' and `-E' options already 
included with $(ccflags-vdso); I wonder if the duplicates should simply be 
removed or whether $(cflags-vdso) ought to filter from $(KBUILD_CFLAGS) 
and $(aflags-vdso) -- from $(KBUILD_AFLAGS) instead (or $(ccflags-vdso) 
should just take the options from $(KBUILD_CPPFLAGS)).  Also why `-E' is 
supposed to take an argument?  Can you please have a look at it?

  Maciej
