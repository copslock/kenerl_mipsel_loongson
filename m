Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 00:11:56 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:38136 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28597184AbYHNXLr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2008 00:11:47 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m7ENBeMd009516;
	Fri, 15 Aug 2008 01:11:40 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m7ENBMSR009512;
	Fri, 15 Aug 2008 00:11:31 +0100
Date:	Fri, 15 Aug 2008 00:11:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Brian Foster <brian.foster@innova-card.com>
cc:	linux-mips@linux-mips.org,
	Martin Gebert <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
Subject: Re: Debugging the MIPS processor using GDB (and FS2 EJTAG probe
 breakpoint issues)
In-Reply-To: <200808141342.20496.brian.foster@innova-card.com>
Message-ID: <Pine.LNX.4.55.0808142336050.7213@cliff.in.clinika.pl>
References: <18944199.post@talk.nabble.com> <Pine.LNX.4.55.0808131441160.390@cliff.in.clinika.pl>
 <200808131707.30570.brian.foster@innova-card.com>
 <200808141342.20496.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 14 Aug 2008, Brian Foster wrote:

>  Just in case someone recognizes these symptoms (or has
>  any ideas) ....
> 
>   I tried hardware breakpoints from ‘gdb’ and got:
> 
>      h1. gdb     hb xxx_open
>      h2. gdb says:
>            warning: Cannot query hardware breakpoint/watchpoint resources.
>            warning: Available functionality may be limited.

 This warning is issued because FS2's MDIlib does not implement the
MDIHwBpQuery() call, which tells the MDI client what hardware breakpoint
capabilities the given implementation of MDIlib provides.  They generally
correspond to what the debug port provides, but there is room for some
abstraction to be provided by MDIlib, for example a given library
implementation may emulate ways to specify address ranges different to
what hardware implements.

 Therefore GDB cannot determine whether the intended breakpoint type will
or will not fail at the time MDISetBp() is called to actually insert the
breakpoint into the target, which only happens when execution is resumed.  
There is a heuristic implemented in GDB that tries to figure out what the
MDIlib supports by trial and error, but in the end the target may not 
really support what GDB requests and you'll get a failure when you try to 
start execution.  The message therefore serves as a precautionary warning.

 They really ought to implement this call -- I suppose if customers like
you keep pushing, they may eventually decide it is worth the effort.

 Anyway, the warning is normal and happened for all releases of FS2
software I have ever used.

>      h3. target  cat /dev/xxx
>      h4. Nothing happens!  (The breakpoint does not detonate.)

 You should be able to see a hardware breakpoint set by GDB from their
System Navigator console as soon as execution is resumed.  I don't
remember the exact command to use -- it's in their reference manual.

 I suggest you verify this way the breakpoint is indeed set in the target
and then whether it is really at an address that guarantees it to trigger.  
A good way of determining whether hardware breakpoints work is to set one
at the reset vector i.e.  0xffffffffbfc00000 (remove "f" digits as
appropriate for your platform), resume execution and hit the NMI or soft
reset button.

>  I presume I can cook up some ‘gdb’ macros to can (simplify)
>  those horrible ‘monitor bkpt ...’ commands, but I shouldn't
>  have to do that, should I?  ;-\ 

 You won't get proper handling from GDB side (condition checking, 
breakpoint commands, etc.) if you set breakpoints behind GDB's back 
anyway -- all you will get are unrecognised traps.  And resumption under 
these circumstances is rather cumbersome as you have to perform all the 
actions GDB normally does itself manually.

>   Any ideas?  (And yes, I'm attempting to pursue this with
>  FS²/MIPS, but .... .)

 Well, it's their product and they should be able to sort out your 
problem.  It's not a problem with Linux nor GDB even, so it's quite 
unlikely anybody on this list is able to provide you with any advice 
beyond what has been written already, so I suggest we stop bothering 
people with the noise.

  Maciej
