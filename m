Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2012 19:20:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34910 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901170Ab2EIRUm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2012 19:20:42 +0200
Date:   Wed, 9 May 2012 18:20:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Matt Turner <mattst88@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: set ST0_MX flag for MDMX
In-Reply-To: <1336084845-28995-1-git-send-email-mattst88@gmail.com>
Message-ID: <alpine.LFD.2.00.1205091747080.3701@eddie.linux-mips.org>
References: <1336084845-28995-1-git-send-email-mattst88@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Matt,

> As the comment in commit 3301edcb says, DSP and MDMX share the same
> config flag bit.
> 
> Without this set, MDMX instructions cause Illegal instruction errors.

 NAK, it's all pretty and nice, but I am afraid you're missing the point 
with your change.  The bit has its purpose, the MDMX accumulator has to be 
saved and restored -- just as the DSP or the FPU context -- between task 
switches and the bit provides for doing that lazily (of course you can do 
that eagerly instead if you like).

> Is MDMX implemented by anything other than some Broadcom CPUs? Is it
> totally replaced by DSP?

 You can have both ASEs on a single processor and they serve different 
purposes as far as I can tell.  I think NEC had an implementation as well, 
but it could have been an older revision than Broadcom's.

> I had a terrible time finding any documentation on it (which is annoying
> because Volume IV-b covering MDMX is referenced by all the MIPS64 documents.)
> but finally found a copy here: www.enlight.ru/docs/cpu/risc/mips/MDMXspec.pdf

 That's the old spec, back from SGI days, using the COP2 opcode space.  
It may not have been implemented and is certainly obsolete.  COP2 is 
available for user-defined coprocessors in the current architecture 
definition and MDMX instructions use different encodings (peek at 
libopcodes for details).

> If it's dead, it's too bad because it's a pretty cool ISA.

 I don't think MaDMaX is dead, it's still referred to from the 
architecture spec as of revision 3.12 and I am fairly sure you'll be able 
to implement it in your processor if you get the right architecture 
licences.

  Maciej
