Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g481lmwJ017703
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 18:47:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g481lmXU017702
	for linux-mips-outgoing; Tue, 7 May 2002 18:47:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g481lewJ017694
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 18:47:40 -0700
Received: from nevyn.them.org (NEVYN.RES.CMU.EDU [128.2.145.6]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA01115
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 18:48:25 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 175GU6-0007s8-00; Tue, 07 May 2002 21:43:14 -0400
Date: Tue, 7 May 2002 21:43:14 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Geoffrey Espin <espin@idiom.com>
Cc: "Siders, Keith" <keith_siders@toshibatv.com>,
   "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: Debugging of embedded target applications
Message-ID: <20020508014314.GA30243@nevyn.them.org>
References: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX> <20020507221512.GA22326@nevyn.them.org> <20020507154427.D12509@idiom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020507154427.D12509@idiom.com>
User-Agent: Mutt/1.5.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 07, 2002 at 03:44:27PM -0700, Geoffrey Espin wrote:
> On Tue, May 07, 2002 at 06:15:12PM -0400, Daniel Jacobowitz wrote:
> > it's called "gdbserver", and is included with the GDB distribution.
> > I recommend you get GDB 5.2, released last week; the gdbserver included
> > in that version is far superior for GNU/Linux targets to any previous
> > release.
> 
> Does work it for kernel type debugging over *Ethernet*?
> I see some docs saying "TCP/IP" connection... but does that
> mean a special kind of network driver?  Or a gdbstub/agent
> outside the kernel in a special monitor?

What do you mean by kernel type debugging?  It's not a kernel stub.  It
can debug user programs over TCP/IP or a serial line.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
