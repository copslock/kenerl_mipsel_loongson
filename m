Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3ODnWG17940
	for linux-mips-outgoing; Tue, 24 Apr 2001 06:49:32 -0700
Received: from enst.enst.fr (enst.enst.fr [137.194.2.16])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3ODnVM17937
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 06:49:31 -0700
Received: from email.enst.fr (muse.enst.fr [137.194.2.33])
	by enst.enst.fr (Postfix) with ESMTP
	id F1E471C8DF; Tue, 24 Apr 2001 15:49:27 +0200 (MET DST)
Received: from donjuan.enst.fr (donjuan.enst.fr [137.194.168.21])
	by email.enst.fr (8.9.3/8.9.3) with ESMTP id PAA26320;
	Tue, 24 Apr 2001 15:49:08 +0200 (MET DST)
Received: from localhost (bellard@localhost)
	by donjuan.enst.fr (8.9.3+Sun/8.9.3) with SMTP id PAA09542;
	Tue, 24 Apr 2001 15:49:19 +0200 (MEST)
Date: Tue, 24 Apr 2001 15:49:19 +0200 (MEST)
From: Fabrice Bellard <bellard@email.enst.fr>
To: Ian Soanes <ians@lineo.com>
Cc: linux-mips@oss.sgi.com, rivers@lexmark.com
Subject: Re: gdb single step ?
In-Reply-To: <3AE57586.13A6968F@lineo.com>
Message-ID: <Pine.GSO.4.02.10104241544480.9515-100000@donjuan.enst.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

I was speaking about gdb support in user mode, not the gdb stub in the
kernel. Does someone use gdb to debug user space programs on linux-mips ?
Maybe someone added the PTRACE_SINGLESTEP command of the ptrace syscall in
recent mips kernel, but I do not have it in my kernel (linux-2.4.0 on sgi
site).

I patched gdb 5.0 so that single step on mips is correctly supported in
user mode. I also modified gdbserver so that it works when you debug mips
code in user mode.

Fabrice.

On Tue, 24 Apr 2001, Ian Soanes wrote:

> Ian Soanes wrote:
> > 
> > Ralf Baechle wrote:
> > >
> > > On Mon, Apr 23, 2001 at 06:31:20PM +0200, Fabrice Bellard wrote:
> > >
> > > > Did someone make a patch so that gdb can do single step on mips-linux ? If
> > > > not, do you prefer a patch to gdb or a patch in the kernel to support the
> > > > PTRACE_SINGLESTEP command ?
> > >
> > > Last I used GDB single stepping has been working fine for me, so I wonder
> > > what is broken?
> > >
> 
> <snip>
> 
> > 
> > 2/ Previously I've had some luck single stepping kernel and module code
> > with the kernel gdbstub (arch/mips/kernel/gdb-stub.c), so I ported the
> > relevant single stepping code into gdbserver. The results were much
> > better. The only thing that seems to be wrong now is stepping over
> > function calls isn't working quite right. I can step into functions OK
> > though.
> > 
> 
> <snip>
> 
> Hi,
> 
> Sorry, I made a mistake (forgetting to clear a breakpoint) when I ported
> the stub single step code into gdbserver. As far as I can tell, single
> stepping works fine now.
> 
> BTW, should I be worried about MIPS16 instructions? (single step
> breakpoints are always placed on a 4 byte increment) ...or is that a
> silly question?
> 
> Best regards,
> Ian
> 
