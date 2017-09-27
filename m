Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 19:21:36 +0200 (CEST)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:46248 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990404AbdI0RV3qO0za (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 19:21:29 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 32A7B3F94F;
        Wed, 27 Sep 2017 19:21:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QhWg4jcwU2mO; Wed, 27 Sep 2017 19:21:14 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 185C23F414;
        Wed, 27 Sep 2017 19:21:09 +0200 (CEST)
Date:   Wed, 27 Sep 2017 19:21:08 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170927172107.GB2631@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk>
 <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60182
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

>  BTW I think that when we get to supporting 128-bit registers we want to 
> avoid changing the definition of LONG_{L,S} macros, because these are used 
> for purposes beyond context access.
> 
>  Instead I think these macros as well all the ones in <asm/stackframe.h> 
> should remain unchanged and the save and restoration of the 64-bit upper 
> halves done separately, most likely in `switch_to', which is where all the 
> user context registers which like these upper halves are not touched by 
> the kernel (and which are not handled lazily by other means) are switched.

Hmm... What about a 32-bit kernel and bits 63:32 sign-extended by kernel
instructions? LONG_{L,S} saves/restores 31:0 using LW/SW thus 63:32 will
be lost in exceptions?

>  Can you try a regular 32-bit MIPS Debian distribution instead?

BusyBox at

https://packages.debian.org/stretch/mipsel/busybox-static/download

seemed appropriate but yields "illegal instruction" which I suppose is
interesting in itself. My MIPS toolchain is somewhat limited at the moment
so I will need to get back on this.

>  BTW, I have just noticed that DMULT, DMULTU, DDIV and DDIVU instructions 
> are not implemented.  Which means that a 64-bit kernel will only work if 
> compiled with `-march=r5900' and emulation is required for 64-bit user 
> programs.

Indeed. In the R5900 patch these instructions are emulated (or simulated as
it is called in the source) in

https://github.com/frno7/linux/blob/1c8247e352d1eb7ae9022a76ecf19f74264534f7/arch/mips/kernel/traps.c

along with LLD, SCD, etc.

Fredrik
