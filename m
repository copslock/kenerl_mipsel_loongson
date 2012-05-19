Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2012 19:59:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45128 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903258Ab2ESR7a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 May 2012 19:59:30 +0200
Date:   Sat, 19 May 2012 18:59:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Matt Turner <mattst88@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: set ST0_MX flag for MDMX
In-Reply-To: <CAEdQ38F835drENTQ0_=62KCt0_xD1B=TW5OE9Gb8=sOqUW=icw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1205101113160.3701@eddie.linux-mips.org>
References: <1336084845-28995-1-git-send-email-mattst88@gmail.com> <alpine.LFD.2.00.1205091747080.3701@eddie.linux-mips.org> <CAEdQ38F835drENTQ0_=62KCt0_xD1B=TW5OE9Gb8=sOqUW=icw@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-archive-position: 33376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 9 May 2012, Matt Turner wrote:

> >  NAK, it's all pretty and nice, but I am afraid you're missing the point
> > with your change.  The bit has its purpose, the MDMX accumulator has to be
> > saved and restored -- just as the DSP or the FPU context -- between task
> > switches and the bit provides for doing that lazily (of course you can do
> > that eagerly instead if you like).
> 
> Okay. It looks like I also need to add save/restoring of the MDMX
> accumulator to arch/mips/power/cpu.c and
> arch/mips/include/asm/switch_to.h:finish_arch_switch()?

 More or less, though I think you want to switch the MDMX state lazily as 
it's tied to the FPU -- MDMX instructions require CP0.Status.CU1 to be set 
to execute; it's implementation dependent whether you'll get a Coprocessor 
Unusable or an MDMX Unusable exception when CP0.Status.CU1 and 
CP0.Status.MX are both zero and an MDMX instruction is executed.  And 
moving the MDMX state every time will be wasting processor's time as 
nothing is going to use it (apart from the app you intend to write, I 
presume ;) ).

 Then there's stuff like ptrace(2), signal frames, perhaps more -- to say 
nothing of the userland side -- for full support.

  Maciej
