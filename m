Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 19:53:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59448 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859943AbaG3RxLO-Z18 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 19:53:11 +0200
Date:   Wed, 30 Jul 2014 18:53:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: prevent user from setting FCSR cause bits
In-Reply-To: <20140730173446.GB27790@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1407301838210.6486@eddie.linux-mips.org>
References: <1406035281-693-1-git-send-email-paul.burton@imgtec.com> <20140730173446.GB27790@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41820
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

On Wed, 30 Jul 2014, Ralf Baechle wrote:

> > If one or more matching FCSR cause & enable bits are set in saved thread
> > context then when that context is restored the kernel will take an FP
> > exception. This is of course undesirable and considered an oops, leading
> > to the kernel writing a backtrace to the console and potentially
> > rebooting depending upon the configuration. Thus the kernel avoids this
> > situation by clearing the cause bits of the FCSR register when handling
> > FP exceptions and after emulating FP instructions.
> > 
> > However the kernel does not prevent userland from setting arbitrary FCSR
> > cause & enable bits via ptrace, using either the PTRACE_POKEUSR or
> > PTRACE_SETFPREGS requests. This means userland can trivially cause the
> > kernel to oops on any system with an FPU. Prevent this from happening
> > by clearing the cause bits when writing to the saved FCSR context via
> > ptrace.
> > 
> > This problem appears to exist at least back to the beginning of the git
> > era in the PTRACE_POKEUSR case.
> 
> Good catch - but I think something like UML on a more proper fix.  How
> until then I'm going to apply this.

 I'm not sure what you mean by UML, but this is definitely a valid action, 
you need to be able to do anything from GDB that a program can do itself, 
and a program can raise FP exceptions to itself by fiddling with CP1.FCSR; 
this is even required by the ISO C language standard (see the pieces in 
<fenv.h>).  So I think the kernel should be prepared to handle such 
exceptions on context switches; and also emulate them if no FP hardware is 
used.

 I suspect a similar condition exists when a program writes to the saved 
image of CP1.FCSR in a signal handler and then restores that context.  I 
don't know offhand if this is supported by any standard though; 
intuitively it should.

  Maciej
