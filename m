Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 23:10:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33582 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014871AbbCaVJ5xIKUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 23:09:57 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2VL9vkl002122;
        Tue, 31 Mar 2015 23:09:57 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2VL9vZx002120;
        Tue, 31 Mar 2015 23:09:57 +0200
Date:   Tue, 31 Mar 2015 23:09:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: c-r4k.c: Fix the 74K D-cache alias erratum
 workaround
Message-ID: <20150331210957.GI28951@linux-mips.org>
References: <alpine.DEB.1.10.1411160041230.2881@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1411160041230.2881@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Nov 16, 2014 at 01:02:29AM +0000, Maciej W. Rozycki wrote:

> Fix the 74K D-cache alias erratum workaround so that it actually works.  
> Our current code sets MIPS_CACHE_VTAG for the D-cache, but that flag 
> only has any effect for the I-cache.  Additionally MIPS_CACHE_PINDEX is 
> set for the D-cache if CP0.Config7.AR is also set for an affected 
> processor, leading to confusing information in the bootstrap log (the 
> flag isn't used beyond that).
> 
> So delete the setting of MIPS_CACHE_VTAG and rely on MIPS_CACHE_ALIASES, 
> set in a common place, removing I-cache coherency issues seen in GDB 
> testing with software breakpoints, gdbserver and ptrace(2), on affected 
> systems.
> 
> While at it add a little piece of explanation of what CP0.Config6.SYND 
> is so that people do not have to chase documentation.
> 
> Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
> ---
> Hi,
> 
>  It looks like I-cache aliasing handling setup needs some TLC too, first 
> of all what's the purpose of checking CP0.Config7.IAR and setting the 
> MIPS_CACHE_ALIASES flag for the I-cache where the flag is nowhere used 
> afterwards?  Anyway that's something for another occasion.  For now, 
> please apply this change.

Applied, finally.  I take it the discussion in
https://patchwork.linux-mips.org/patch/8876/ does not concern the
correctness of your patch.

Backporting this patch to older kernels is getting increasingly more
painful so I only did so for kernels as old as 3.13.  If anybody cares,
send patches :)

Thanks Maciej!

  Ralf
