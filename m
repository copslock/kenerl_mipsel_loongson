Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18MVDn12057
	for linux-mips-outgoing; Fri, 8 Feb 2002 14:31:13 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18MV9A12054
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 14:31:09 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16ZJXv-0000kG-00; Fri, 08 Feb 2002 17:31:07 -0500
Date: Fri, 8 Feb 2002 17:31:07 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: gdb disassemble bug
Message-ID: <20020208173107.A2758@nevyn.them.org>
References: <20020208215851.GA18416@paradigm.rfc822.org> <20020208171051.A1829@nevyn.them.org> <20020208221849.GA18922@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208221849.GA18922@paradigm.rfc822.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 08, 2002 at 11:18:49PM +0100, Florian Lohoff wrote:
> On Fri, Feb 08, 2002 at 05:10:51PM -0500, Daniel Jacobowitz wrote:
> > On Fri, Feb 08, 2002 at 10:58:51PM +0100, Florian Lohoff wrote:
> > > 0x88166b58 <probe_scache+188>:	mtc0	zero,gp
> > > 0x88166b5c <probe_scache+192>:	nop
> > > 0x88166b60 <probe_scache+196>:	mtc0	zero,sp
> > > 0x88166b64 <probe_scache+200>:	nop
> > > 
> > > mtc0/mfc0 do not address cpu registers but CP0 registers. The decoding
> > > as "gp" or "sp" is not correct. These are "TagLo" and "TagHi".
> > 
> >   - what version of GDB?
> >   - does objdump do the same thing?
> 
> reset:~# gdb --version
> GNU gdb 5.1
> Copyright 2001 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "mips-linux".
> reset:~# dpkg -l gdb
> Desired=Unknown/Install/Remove/Purge/Hold
> | Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
> |/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
> ||/ Name           Version        Description
> +++-==============-==============-============================================
> ii  gdb            5.1-1          The GNU Debugger

OK.  You may want to try a CVS snapshot; I'm 99% certain that this was
fixed after gdb 5.1 branched.


-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
