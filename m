Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 00:11:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48616 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816071AbaFWWL3zn5hE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 00:11:29 +0200
Date:   Mon, 23 Jun 2014 23:11:29 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     John Crispin <blogic@openwrt.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Implement random_get_entropy with CP0 Random
In-Reply-To: <20140530191808.GO5157@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1406232311050.23403@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1404062102130.15266@eddie.linux-mips.org> <20140530191808.GO5157@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 30 May 2014, Ralf Baechle wrote:

> > linux-mips-cycles.patch
> > Index: linux-20140404-4maxp64/arch/mips/include/asm/timex.h
> > ===================================================================
> > --- linux-20140404-4maxp64.orig/arch/mips/include/asm/timex.h
> > +++ linux-20140404-4maxp64/arch/mips/include/asm/timex.h
> > @@ -4,15 +4,18 @@
> >   * for more details.
> >   *
> >   * Copyright (C) 1998, 1999, 2003 by Ralf Baechle
> > + * Copyright (C) 2014 by Maciej W. Rozycki
> >   */
> >  #ifndef _ASM_TIMEX_H
> >  #define _ASM_TIMEX_H
> >  
> >  #ifdef __KERNEL__
> >  
> > +#include <linux/compiler.h>
> > +
> > +#include <asm/cpu.h>
> >  #include <asm/cpu-features.h>
> >  #include <asm/mipsregs.h>
> > -#include <asm/cpu-type.h>
> 
> And this line broke the build big time - lots of files are using either
> boot_cpu_type() or current_cpu_type() and are implicitly getting the
> definition via <asm/timex.h>.
> 
> So for the moment I've added the unnecessary inclusion of asm/cpu-type.h
> back.

 Thanks for fixing this up for me.

  Maciej
