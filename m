Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2CNAfl26711
	for linux-mips-outgoing; Tue, 12 Mar 2002 15:10:41 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2CNAc926708
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 15:10:39 -0800
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 16kuTk-0002MD-00; Tue, 12 Mar 2002 17:10:44 -0500
Date: Tue, 12 Mar 2002 17:10:44 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Lanny DeVaney <ldevaney@redhat.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: gdbserver
Message-ID: <20020312171044.A8889@nevyn.them.org>
References: <3C8E5560.2090907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8E5560.2090907@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Mar 12, 2002 at 01:22:08PM -0600, Lanny DeVaney wrote:
> I've looked back through the archives and find some references to 
> problems configuring and/or building gdbserver for mips-linux.
> 
> I'm attempting to build gdb/gdbserver with --target=mips-linux as well, 
> using gdb-5.1.1.  Have the earlier issues (they looked to be 1-2 years 
> old) been resolved or am I still looking at a "manual build" process? 
> I'm getting lots of errors with the build, although the configure seems 
> to go OK.  x86 host, linux-mips target.
> 
> Thanks for any help you can provide,

As Johannes said, use the current CVS snapshot.  MIPS/Linux support for
gdbserver was only contributed about a month ago.  I'd appreciate bug
reports if it does not work for you, especially as I only tested
little-endian.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
