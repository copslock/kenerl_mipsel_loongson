Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3ODHpm16450
	for linux-mips-outgoing; Tue, 24 Apr 2001 06:17:51 -0700
Received: from interlock2.lexmark.com (interlock2.lexmark.com [192.146.101.10])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3ODHoM16446
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 06:17:50 -0700
Received: by interlock2.lexmark.com id JAA07302
  (InterLock SMTP Gateway 4.2 for linux-mips@oss.sgi.com);
  Tue, 24 Apr 2001 09:17:02 -0400
Message-Id: <200104241317.JAA07302@interlock2.lexmark.com>
Received: by interlock2.lexmark.com (Protected-side Proxy Mail Agent-2);
  Tue, 24 Apr 2001 09:17:02 -0400
Received: by interlock2.lexmark.com (Protected-side Proxy Mail Agent-1);
  Tue, 24 Apr 2001 09:17:02 -0400
Date: Tue, 24 Apr 2001 09:17:01 -0400
From: Martin Rivers <rivers@lexmark.com>
Organization: Lexmark International, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
Mime-Version: 1.0
To: Ian Soanes <ians@lineo.com>
Cc: Fabrice Bellard <bellard@email.enst.fr>, linux-mips@oss.sgi.com
Subject: Re: gdb single step ?
References: <3AE44D0A.9080003@jungo.com> <Pine.GSO.4.02.10104231829020.19846-100000@chimene.enst.fr> <20010423170425.F4623@bacchus.dhis.org> <3AE541B0.410FDF8A@lineo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ian,

Hmmm, this was the most problematic portion of the code.  I remember that I
fought the kernel support in what it wanted to report as the epc (pc).  The
module of interest (at least for 2.4 linux) is arch/mips/kernel/traps.c and the
function do_bp().  In an earlier version of the kernel (if I remember right), it
would call a routine to "fix up" the pc.  This lead to the pc being backed up by
4 bytes which confused gdb.  Anyway, you want to make sure that the kernel is
reporting the pc of the bpt instruction with your version of linux.

Also, in regards to your subsequent email, you are correct in reporting that
mips16 is not supported (at least by my code).  We never use it as we support
various models of the cpu that don't support that instruction set.

martin

> 
> Ralf Baechle wrote:
> >
> > On Mon, Apr 23, 2001 at 06:31:20PM +0200, Fabrice Bellard wrote:
> >
> > > Did someone make a patch so that gdb can do single step on mips-linux ? If
> > > not, do you prefer a patch to gdb or a patch in the kernel to support the
> > > PTRACE_SINGLESTEP command ?
> >
> > Last I used GDB single stepping has been working fine for me, so I wonder
> > what is broken?
> >
> 
> Hi Fabrice,
> 
> This may not be totally relevant, but I'm currently trying to get
> gdbserver working on a RC32334 IDT board. I've been having some issues
> with single stepping, but am making a bit of progress.
> 
> 1/ I started with a mips gdbserver port kindly supplied by Martin
> Rivers. It mostly works well but had some problems single stepping
> through conditional branches (the problem may have been due to a
> different target than Martin was using, or me... I am kind of new to
> this :)
> 
> 2/ Previously I've had some luck single stepping kernel and module code
> with the kernel gdbstub (arch/mips/kernel/gdb-stub.c), so I ported the
> relevant single stepping code into gdbserver. The results were much
> better. The only thing that seems to be wrong now is stepping over
> function calls isn't working quite right. I can step into functions OK
> though.
> 
> If you're interested I'll let you know how I get on over the next few
> days. If not, I won't be offended :)
> 
> Best regards,
> Ian
