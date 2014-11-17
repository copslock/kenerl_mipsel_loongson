Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 00:30:12 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:49686 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013796AbaKQXaKN2zLw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 00:30:10 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XqVk6-00031s-0o from Maciej_Rozycki@mentor.com ; Mon, 17 Nov 2014 15:29:58 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 17 Nov
 2014 23:29:56 +0000
Date:   Mon, 17 Nov 2014 23:29:52 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re:  MIPS: c-r4k.c: Fix the 74K D-cache alias erratum workaround
In-Reply-To: <546A56C9.4060608@imgtec.com>
Message-ID: <alpine.DEB.1.10.1411172321110.2881@tp.orcam.me.uk>
References: <546A56C9.4060608@imgtec.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

On Mon, 17 Nov 2014, Leonid Yegoshin wrote:

> > Fix the 74K D-cache alias erratum workaround so that it actually works.
> > Our current code sets MIPS_CACHE_VTAG for the D-cache, but that flag
> > only has any effect for the I-cache.  Additionally MIPS_CACHE_PINDEX is
> > set for the D-cache if CP0.Config7.AR is also set for an affected
> > processor, leading to confusing information in the bootstrap log (the
> > flag isn't used beyond that).
> 
> > So delete the setting of MIPS_CACHE_VTAG and rely on MIPS_CACHE_ALIASES,
> > set in a common place, removing I-cache coherency issues seen in GDB
> > testing with software breakpoints, gdbserver and ptrace(2), on affected
> > systems.
> 
> > While at it add a little piece of explanation of what CP0.Config6.SYND
> > is so that people do not have to chase documentation.
> 
> This shift to MIPS_CACHE_ALIASES is not needed, a use of MIPS_CACHE_VTAG in
> dcache is actually a way how to prevent some very specific situations in
> 74K(E77)/1074K(E17) cache handling. It is not a case of cache aliasing and
> name VTAG is used because it is related with virtual address conversion
> tagging. I reused MIPS_CACHE_VTAG just to save some spare bits in
> cpu_info.options and because D-cache never had virtual tagging like I-cache.
> 
> The setting d-cache aliases then CPU hasn't it is a significant performance
> loss and should be avoided.
> 
> Please don't use this patch.

 I repeat, there is no use in the current kernel of the MIPS_CACHE_VTAG 
flag for the D-cache, there's no single piece of code throughout the 
kernel that would check the presence of this flag once it has been set 
and this erratum workaround piece is the only place where the flag is 
set for the D-cache.  The flag is completely ignored for the D-cache and 
the only existing uses of this flag are for the I-cache.

 Leonid, I spent several hours chasing cache coherency issues util I 
realised the workaround in its current form does not do anything, so 
unless you propose an alternative fix, this change is the only way known 
to bring systems affected to sanity.

 Ralf, please apply the change for now, if Leonid provides us with a 
better fix later on, then my patch can be reverted.  Thanks.

  Maciej
