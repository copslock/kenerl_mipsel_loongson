Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47Mh8wJ011517
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 15:43:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47Mh8a6011516
	for linux-mips-outgoing; Tue, 7 May 2002 15:43:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47Mh5wJ011513
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 15:43:05 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id PAA40728;
	Tue, 7 May 2002 15:44:27 -0700 (PDT)
Date: Tue, 7 May 2002 15:44:27 -0700
From: Geoffrey Espin <espin@idiom.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Siders, Keith" <keith_siders@toshibatv.com>,
   "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: Debugging of embedded target applications
Message-ID: <20020507154427.D12509@idiom.com>
References: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX> <20020507221512.GA22326@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020507221512.GA22326@nevyn.them.org>; from Daniel Jacobowitz on Tue, May 07, 2002 at 06:15:12PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 07, 2002 at 06:15:12PM -0400, Daniel Jacobowitz wrote:
> it's called "gdbserver", and is included with the GDB distribution.
> I recommend you get GDB 5.2, released last week; the gdbserver included
> in that version is far superior for GNU/Linux targets to any previous
> release.

Does work it for kernel type debugging over *Ethernet*?
I see some docs saying "TCP/IP" connection... but does that
mean a special kind of network driver?  Or a gdbstub/agent
outside the kernel in a special monitor?

Geoff
-- 
Geoffrey Espin
espin@idiom.com
--
