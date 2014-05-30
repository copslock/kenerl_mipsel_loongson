Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 21:18:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34309 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822998AbaE3TSNYZpWf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 May 2014 21:18:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4UJIBAD011877;
        Fri, 30 May 2014 21:18:11 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4UJI8jI011876;
        Fri, 30 May 2014 21:18:08 +0200
Date:   Fri, 30 May 2014 21:18:08 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Implement random_get_entropy with CP0 Random
Message-ID: <20140530191808.GO5157@linux-mips.org>
References: <alpine.LFD.2.11.1404062102130.15266@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1404062102130.15266@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40394
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

On Sun, Apr 06, 2014 at 09:31:29PM +0100, Maciej W. Rozycki wrote:

(Cc list chopped down to just the MIPS folks.)

> linux-mips-cycles.patch
> Index: linux-20140404-4maxp64/arch/mips/include/asm/timex.h
> ===================================================================
> --- linux-20140404-4maxp64.orig/arch/mips/include/asm/timex.h
> +++ linux-20140404-4maxp64/arch/mips/include/asm/timex.h
> @@ -4,15 +4,18 @@
>   * for more details.
>   *
>   * Copyright (C) 1998, 1999, 2003 by Ralf Baechle
> + * Copyright (C) 2014 by Maciej W. Rozycki
>   */
>  #ifndef _ASM_TIMEX_H
>  #define _ASM_TIMEX_H
>  
>  #ifdef __KERNEL__
>  
> +#include <linux/compiler.h>
> +
> +#include <asm/cpu.h>
>  #include <asm/cpu-features.h>
>  #include <asm/mipsregs.h>
> -#include <asm/cpu-type.h>

And this line broke the build big time - lots of files are using either
boot_cpu_type() or current_cpu_type() and are implicitly getting the
definition via <asm/timex.h>.

So for the moment I've added the unnecessary inclusion of asm/cpu-type.h
back.

  Ralf
