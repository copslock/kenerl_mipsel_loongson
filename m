Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g482O5wJ018714
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 19:24:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g482O5AP018713
	for linux-mips-outgoing; Tue, 7 May 2002 19:24:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g482O1wJ018710
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 19:24:01 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id TAA85580;
	Tue, 7 May 2002 19:25:23 -0700 (PDT)
Date: Tue, 7 May 2002 19:25:23 -0700
From: Geoffrey Espin <espin@idiom.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Siders, Keith" <keith_siders@toshibatv.com>,
   "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: Debugging of embedded target applications
Message-ID: <20020507192523.A73748@idiom.com>
References: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX> <20020507221512.GA22326@nevyn.them.org> <20020507154427.D12509@idiom.com> <20020508014314.GA30243@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020508014314.GA30243@nevyn.them.org>; from Daniel Jacobowitz on Tue, May 07, 2002 at 09:43:14PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 07, 2002 at 09:43:14PM -0400, Daniel Jacobowitz wrote:
> > Does work it for kernel type debugging over *Ethernet*?
> > I see some docs saying "TCP/IP" connection... but does that
> > mean a special kind of network driver?  Or a gdbstub/agent
> > outside the kernel in a special monitor?
> What do you mean by kernel type debugging?  It's not a kernel stub.  It
> can debug user programs over TCP/IP or a serial line.

In traditional embedded RTOS land, "system-level debugging".
In the olden days one had to have BDM/JTAG hardware assist
to step thru truly arbitary bits of code, like interrupt handlers,
scheduler.

The original question was about using using a hardware debugger.
Clearly using gdb/gdbserver is for apps only, AFAIK.  Does one
bother with a h/w debugger for apps?  Using kgdb with some kind
of remote debug-agent would be a "system level debugger", a s/w
solution to a traditional hardware only debug aid.  At this time
kind of pointless, as its painful to setup and JTAG debuggers
are so cheap (for mainline CPUs).

Geoff
-- 
Geoffrey Espin
espin@idiom.com
--
