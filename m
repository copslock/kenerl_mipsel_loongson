Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1F3Ene05790
	for linux-mips-outgoing; Thu, 14 Feb 2002 19:14:49 -0800
Received: from dea.linux-mips.net (a1as18-p131.stg.tli.de [195.252.193.131])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1F3Ei905786
	for <linux-mips@oss.sgi.com>; Thu, 14 Feb 2002 19:14:44 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1F2BI221209;
	Fri, 15 Feb 2002 03:11:18 +0100
Date: Fri, 15 Feb 2002 03:11:18 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020215031118.B21011@dea.linux-mips.net>
References: <3C6C6ACF.CAD2FFC@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6C6ACF.CAD2FFC@mvista.com>; from jsun@mvista.com on Thu, Feb 14, 2002 at 05:56:31PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Feb 14, 2002 at 05:56:31PM -0800, Jun Sun wrote:

> I have been chasing a FPU register corruption problem on a SMP box.  The
> curruption seems to be caused by FPU emulator code.  Is that code SMP safe? 
> If not, what are the volunerable spots?
> 
> Just thought I'd check before I dive into it ....

In theory the fp emulation code should be MP safe as the full emulation
is only accessing it's context in the fp register set of struct
task_struct.  The 32-bit kernel's fp register switching is entirely broken
(read: close to non-existant).  Lots of brownie points for somebody to
backport that from the 64-bit kernel to the 32-bit kernel and forward
port all the FPU emu bits to the 64-bit kernel ...

> BTW, I think even with the latest fpu emu patch, the classic fpu/signal
> problem is still there.  I will post in a separate email later.

Urgs ...

  Ralf
