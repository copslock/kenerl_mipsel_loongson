Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48D71wJ028779
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 06:07:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48D71Oo028778
	for linux-mips-outgoing; Wed, 8 May 2002 06:07:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48D6rwJ028775
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 06:06:53 -0700
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03124
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 06:08:09 -0700 (PDT)
	mail_from (keith_siders@toshibatv.com)
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <26NPQHHT>; Wed, 8 May 2002 08:06:47 -0500
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA379AA4@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Cc: "'Daniel Jacobowitz'" <dan@debian.org>, Geoffrey Espin <espin@idiom.com>
Subject: RE: Debugging of embedded target applications
Date: Wed, 8 May 2002 08:05:43 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for the lively discussion and input. It's now clear to me that I'll
be tracking (not tracing) the kernel with the h/w debugger through its kgdb
shell. We're still working on some drivers, so control over the kernel is a
must. I'll have to set up the server to autoload when a connection on a
particular port is attempted from another gdb shell, and shut down on
disconnection.

Keith

-> -----Original Message-----
-> From: Daniel Jacobowitz [mailto:dan@debian.org]
-> Sent: Tuesday, May 07, 2002 9:33 PM
-> To: Geoffrey Espin
-> Cc: Siders, Keith; Linux-Mips (E-mail)
-> Subject: Re: Debugging of embedded target applications
-> 
-> 
-> On Tue, May 07, 2002 at 07:25:23PM -0700, Geoffrey Espin wrote:
-> > On Tue, May 07, 2002 at 09:43:14PM -0400, Daniel Jacobowitz wrote:
-> > > > Does work it for kernel type debugging over *Ethernet*?
-> > > > I see some docs saying "TCP/IP" connection... but does that
-> > > > mean a special kind of network driver?  Or a gdbstub/agent
-> > > > outside the kernel in a special monitor?
-> > > What do you mean by kernel type debugging?  It's not a 
-> kernel stub.  It
-> > > can debug user programs over TCP/IP or a serial line.
-> > 
-> > In traditional embedded RTOS land, "system-level debugging".
-> > In the olden days one had to have BDM/JTAG hardware assist
-> > to step thru truly arbitary bits of code, like interrupt handlers,
-> > scheduler.
-> > 
-> > The original question was about using using a hardware debugger.
-> > Clearly using gdb/gdbserver is for apps only, AFAIK.  Does one
-> > bother with a h/w debugger for apps?  Using kgdb with some kind
-> 
-> Actually, yes, you can.  I believe at least the Abatron BDI can do
-> this.  Could be wrong, though.
-> 
-> > of remote debug-agent would be a "system level debugger", a s/w
-> > solution to a traditional hardware only debug aid.  At this time
-> > kind of pointless, as its painful to setup and JTAG debuggers
-> > are so cheap (for mainline CPUs).
-> 
-> Depends on your platform.
-> 
-> -- 
-> Daniel Jacobowitz                           Carnegie Mellon 
-> University
-> MontaVista Software                         Debian GNU/Linux 
-> Developer
-> 
