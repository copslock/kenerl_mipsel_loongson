Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2002 19:38:20 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:762 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1123899AbSIXRiT>;
	Tue, 24 Sep 2002 19:38:19 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8OHb3q17138;
	Tue, 24 Sep 2002 10:37:03 -0700
Date: Tue, 24 Sep 2002 10:37:03 -0700
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: FCSR Management
Message-ID: <20020924103703.P14312@mvista.com>
References: <008801c2639f$385b1b80$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <008801c2639f$385b1b80$10eca8c0@grendel>; from kevink@mips.com on Tue, Sep 24, 2002 at 09:51:18AM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Sep 24, 2002 at 09:51:18AM +0200, Kevin D. Kissell wrote:
> In looking at some anomalous behavior on another software
> platform, I checked the current MIPS/Linux kernel sources
> and I wonder if we don't have yet another FP context problem
> lurking under the surface.
> 
> On most, if not all, MIPS CPUs with integrated FPUs,
> the act of writing a value to the FP CSR (Control and
> Status Register, fcr31) which has the "E" bit, or any matching
> pair of Enable/Cause bits for the V/Z/O/U/I IEEE exceptions
> set will trigger a floating point exception.  In the case of
> the Unimplemented Operation exception (the "E" bit),
> the emulator is invoked and all of the Cause bits are cleared
> in the context before user execution is resumed.  In the
> case of other FP exceptions, the default behavior is to
> dump core, so the user never executes again.  But *if*
> the user has registered a handler for SIGFPE, and one
> of the IEEE exceptions occurs, I don't see where the
> associated Cause bit is being cleared, and I would think
> that the consequence would be that the process would
> get into an endless loop of trapping, posting the signal,
> restoring the FCSR from the context with the bits set,
> and trapping again, whether or not the PC is modified
> to avoid re-executing the faulting instruction.
> 
> Am I missing something, or is this a problem?
>

FPE exceptions, actually almost all exceptions, are cleared before their
handlers are invoked.  See kernel/entry.S and look for BUILD_HANDLER().

Those macro defines are really mind-twisting and usually don't show up on
grep radar...

Jun
