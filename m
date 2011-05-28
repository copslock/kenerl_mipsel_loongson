Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2011 18:28:07 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36720 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491043Ab1E1Q2E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 May 2011 18:28:04 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4SGS87w007212;
        Sat, 28 May 2011 17:28:08 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4SGS7UF007210;
        Sat, 28 May 2011 17:28:07 +0100
Date:   Sat, 28 May 2011 17:28:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: MIPS panic in 2.6.39 (bisected to 7eaceaccab5f)
Message-ID: <20110528162807.GB7150@linux-mips.org>
References: <4DDB5673.5060206@landley.net>
 <20110524143937.GB30117@linux-mips.org>
 <4DDCB1EB.4020707@landley.net>
 <20110527075512.GE30117@linux-mips.org>
 <20110527140011.GF30117@linux-mips.org>
 <4DE0D303.8000106@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE0D303.8000106@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 28, 2011 at 05:48:35AM -0500, Rob Landley wrote:

> Your missing hunk at the top of this file is:
> 
> @@ -29,6 +29,7 @@
>  #include <asm/system.h>
>  #include <asm/cacheflush.h>
>  #include <asm/traps.h>
> +#include <asm/smp-ops.h>
> 
>  #include <asm/gcmpregs.h>
>  #include <asm/mips-boards/prom.h>
> 
> And then the patch works!  Yay!  Thank you.

Thanks Rob!  I fixed that and the patch is now in the MIPS git.

  Ralf
