Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OEdFD20719
	for linux-mips-outgoing; Tue, 24 Apr 2001 07:39:15 -0700
Received: from interlock2.lexmark.com (interlock2.lexmark.com [192.146.101.10])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3OEdEM20716
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 07:39:14 -0700
Received: by interlock2.lexmark.com id KAA00987
  (InterLock SMTP Gateway 4.2 for linux-mips@oss.sgi.com);
  Tue, 24 Apr 2001 10:38:46 -0400
Message-Id: <200104241438.KAA00987@interlock2.lexmark.com>
Received: by interlock2.lexmark.com (Protected-side Proxy Mail Agent-2);
  Tue, 24 Apr 2001 10:38:46 -0400
Received: by interlock2.lexmark.com (Protected-side Proxy Mail Agent-1);
  Tue, 24 Apr 2001 10:38:46 -0400
Date: Tue, 24 Apr 2001 10:38:45 -0400
From: Martin Rivers <rivers@lexmark.com>
Organization: Lexmark International, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
Mime-Version: 1.0
To: Ian Soanes <ians@lineo.com>
Cc: Fabrice Bellard <bellard@email.enst.fr>, linux-mips@oss.sgi.com
Subject: Re: gdb single step ?
References: <Pine.GSO.4.02.10104241544480.9515-100000@donjuan.enst.fr> <3AE588AA.5874E870@lineo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ian,

I'm confused.  The gdbserver stuff I gave you was all directed at user mode
stuff too.  I don't do any kernel debug with gdbserver.

martin

> 
> Fabrice Bellard wrote:
> >
> > Hi!
> >
> > I was speaking about gdb support in user mode, not the gdb stub in the
> > kernel. Does someone use gdb to debug user space programs on linux-mips ?
> > Maybe someone added the PTRACE_SINGLESTEP command of the ptrace syscall in
> > recent mips kernel, but I do not have it in my kernel (linux-2.4.0 on sgi
> > site).
> >
> > I patched gdb 5.0 so that single step on mips is correctly supported in
> > user mode. I also modified gdbserver so that it works when you debug mips
> > code in user mode.
> >
> 
> <snip>
> 
> Hi Fabrice,
> 
> I know you meant user mode... it's just that I had some success adapting
> the kernel stub code for use in Martin's gdbserver for debugging user
> mode code. I guess now we have 2 gdbservers :-)
> 
> Best regards,
> Ian
