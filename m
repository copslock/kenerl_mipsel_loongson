Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 23:13:40 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27009668AbbDGVNiudXPR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 23:13:38 +0200
Date:   Tue, 7 Apr 2015 22:13:38 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 47/48] MIPS: Respect the ISA level in FCSR handling
In-Reply-To: <20150407125434.GA27914@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504072209520.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504032248160.21028@eddie.linux-mips.org> <20150407125434.GA27914@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46821
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

On Tue, 7 Apr 2015, Ralf Baechle wrote:

> > Index: linux/arch/mips/include/asm/fpu.h
> > ===================================================================
> > --- linux.orig/arch/mips/include/asm/fpu.h	2015-04-02 20:18:47.499480000 +0100
> > +++ linux/arch/mips/include/asm/fpu.h	2015-04-02 20:27:59.745241000 +0100
> > @@ -14,6 +14,7 @@
> >  #include <linux/thread_info.h>
> >  #include <linux/bitops.h>
> >  
> > +#include <asm/current.h>
> >  #include <asm/mipsregs.h>
> >  #include <asm/cpu.h>
> >  #include <asm/cpu-features.h>
> 
> This is adding a 2nd inclusion of <asm/current.h>.  Will fix that.

 Thanks!  I resisted the temptation to include changes to sort inclusions 
with this series or it would risk becoming an ever going effort.  Though 
it would have avoided an oversight like this.

  Maciej
