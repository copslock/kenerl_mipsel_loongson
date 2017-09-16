Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Sep 2017 15:34:41 +0200 (CEST)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:46386 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdIPNee0xSbW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Sep 2017 15:34:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 52F344038A;
        Sat, 16 Sep 2017 15:34:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id asYl8vqErZoz; Sat, 16 Sep 2017 15:34:29 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 89B183F867;
        Sat, 16 Sep 2017 15:34:27 +0200 (CEST)
Date:   Sat, 16 Sep 2017 15:34:26 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170916133423.GB32582@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

>  For the initial R5900 support I think there are two options here, 
> depending on what hardware supports:
> 
> 1. If (for binary compatibility reasons) 128-bit GPR support can somehow 
>    be disabled in hardware, by flipping a CP0 register bit or suchlike, 
>    then I suggest doing that in the first stage.

Unfortunately I haven't found such a switch. There is also a set of 128-bit
multimedia instructions to consider (GCC is perhaps unlikely to generate
those but assembly code is an option too).

> 2. Otherwise I think that the context initialisation/switch code has to be 
>    adjusted such that the upper GPR halves are set to a known state, 
>    either zeroed or sign-extended from bit #63 (or #31 really, given the 
>    initial 32-bit port only) according to hardware requirements, so as to
>    make execution stable and prevent data from leaking between contexts.
> 
> Later on proper 128-bit support can be added, though for that to make 
> sense you need to have compiler support too, which AFAICT is currently 
> missing.  Myself I'd rather defer commenting on that further support until 
> we get to it, although of course someone else might be willing to sketch 
> an idea.

I have a working 32-bit kernel now, except that BusyBox randomly crashes
unless the kernel saves/restores 64-bit GPRs. The executables and libraries
declare "ELF 32-bit LSB, MIPS, MIPS-III version 1" so in theory, I suppose,
they ought to be 32-bit only. It is possible that the error lies in the
kernel handling of the GPRs but I have double-checked this in several ways.

The error, as it appears, is nasty for at least two reasons: it occurs
randomly (when the kernel arbitrarily resets the upper 96 bits of all GPRs)
and it can easily remain undetected and lead to silent data corruption.

Are there other Linux MIPS implementations that reset GPRs like this?

Fredrik
