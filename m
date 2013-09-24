Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2013 10:48:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42716 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817548Ab3IXIsqzs2GR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Sep 2013 10:48:46 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8O8mkQP021917;
        Tue, 24 Sep 2013 10:48:46 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8O8mjDU021916;
        Tue, 24 Sep 2013 10:48:45 +0200
Date:   Tue, 24 Sep 2013 10:48:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Tell R4k SC and MC variations apart
Message-ID: <20130924084845.GA21257@linux-mips.org>
References: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37933
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

On Sun, Sep 22, 2013 at 11:30:59PM +0100, Maciej W. Rozycki wrote:

> There is no reliable way to tell R4000/R4400 SC and MC variations apart, 
> however simple heuristic should give good results.  Only the MC version 
> supports coherent caching so we can rely on such a mode having been set 
> for KSEG0 by the power-on firmware to reliably indicate an MC processor. 
> SC processors reportedly hang on coherent cached memory accesses and Linux 
> is linked to a cached load address so the firmware has to use the correct 
> caching mode to download the kernel image in a cached mode successfully.
> 
> OTOH if the firmware chooses to use either the non-coherent cached or the 
> uncached mode for KSEG0 on an MC processor, then the SC variant will be 
> reported, just as we currently do, so no regression here.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> Ralf,
> 
>  I believe we discussed this once long ago and you had some concerns about 
> such an approach although I don't recall exactly what they were.  I 
> maintain that this heuristic is reasonable, has no drawbacks and has a 
> potential to make some optimisations or errata workarounds easier.  Also 
> we can collect data about systems affected to see what their firmware does 
> -- R4000SC/R4400SC DECstations definitely get CP0.Config.K0 right.

I'm fairly sure it gets k0 right - otherwise it'd likely not work at all!

My reservations may have been about userland reading /proc/cpuinfo and
looking at the CPU type.  Some software may know how to handle the
PC/SC variants but not the MC versions.  But this seems to be a fairly
weak concern - and I trust you checked gcc's parsing of /proc/cpuinfo.

  Ralf
