Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQLVNA24491
	for linux-mips-outgoing; Mon, 26 Nov 2001 13:31:23 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQLVKo24484
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 13:31:20 -0800
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 168SPd-0002DU-00; Mon, 26 Nov 2001 15:31:33 -0500
Date: Mon, 26 Nov 2001 15:31:33 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andre.Messerschmidt@infineon.com
Cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: Cross Compiler again
Message-ID: <20011126153132.A8406@nevyn.them.org>
References: <86048F07C015D311864100902760F1DD01B5E41A@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E41A@dlfw003a.dus.infineon.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 05:27:38PM +0100, Andre.Messerschmidt@infineon.com wrote:
> 
> > -G 0.
> Thanks that helped for the relocation error.
> init/main.o(.text.init+0x7d8): relocation truncated to fit: R_MIPS_GPREL16
> execute_command
> 
> But I still get a lot of undefined references.
> arch/mips/kernel/kernel.o(.debug+0x32e14): undefined reference to `L_E660'
> arch/mips/kernel/kernel.o(.debug+0x60e7c): undefined reference to `L_E549'
> arch/mips/kernel/kernel.o(.debug+0x8d097): undefined reference to `L_E8015'
> arch/mips/kernel/kernel.o(.debug+0x8d0b9): undefined reference to `L_E8015'
> arch/mips/kernel/kernel.o(.debug+0x8d168): undefined reference to `L_E8015'
> arch/mips/kernel/kernel.o(.debug+0x8d18a): undefined reference to `L_E8015'
> ...
> 
> I believe there is still something wrong with my glibc, but I need to check
> that.

I don't know what compiler you're using, but it isn't working right :)
I suspect you're running afoul of the change in debugging format
between binutils 2.10 and 2.11.2.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
