Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HFqdn17752
	for linux-mips-outgoing; Thu, 17 Jan 2002 07:52:39 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HFqZP17748
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 07:52:35 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16RDtt-0007wn-00; Thu, 17 Jan 2002 09:52:21 -0500
Date: Thu, 17 Jan 2002 09:52:21 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Torsten Weber <t.weber@hhi.de>
Cc: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: profiling in glibc for Linux/MIPS
Message-ID: <20020117095221.A30388@nevyn.them.org>
References: <3C46BD4D.DCF1F188@hhi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C46BD4D.DCF1F188@hhi.de>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 17, 2002 at 01:02:22PM +0100, Torsten Weber wrote:
> We use RedHat 7.1 (available at ftp.mips.com) for the MALTA board,
> 
> but programs compiled usign gcc -pg (and using a lib call inside)
> 
> generate a segmentation fault and core dump. I applied the "patch"
> 
> described in the mailing list
> 
> (http://oss.sgi.com/mips/archive/linux-mips.0107,
> 
> Subject: [patch] fix profiling in glibc for Linux/MIPS), but
> 
> the core dumps are still generated. Does anybody know a solution?

You also need a GCC patch.  I posted:
  http://gcc.gnu.org/ml/gcc-patches/2001-10/msg00598.html
which was just approved.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
