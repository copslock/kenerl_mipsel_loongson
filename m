Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARJsLZ29686
	for linux-mips-outgoing; Tue, 27 Nov 2001 11:54:21 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARJsHo29681
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 11:54:18 -0800
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 168nN3-00034i-00; Tue, 27 Nov 2001 13:54:17 -0500
Date: Tue, 27 Nov 2001 13:54:17 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Johannes Stezenbach <js@convergence.de>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com
Subject: Re: PATCH: Fix ELF (Re: The Linux binutils 2.11.92.0.12 is released.)
Message-ID: <20011127135417.B11611@nevyn.them.org>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	Johannes Stezenbach <js@convergence.de>, linux-mips@oss.sgi.com,
	binutils@sourceware.cygnus.com
References: <20011126212859.A17557@lucon.org> <20011127180022.A6897@convergence.de> <20011127101622.A30458@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127101622.A30458@lucon.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 10:16:22AM -0800, H . J . Lu wrote:
> I am going to check in this patch to fix it.
> 
> 
> H.J.
> ----
> 2001-11-27  H.J. Lu <hjl@gnu.org>
> 
> 	* elflink.h (elf_bfd_discard_info): Skip if the input bfd isn't
> 	ELF.

Thanks, you're quite correct.  This suggests that linking from ELF to
something else won't discard stabs, which makes sense to me.  We barely
support linking direct to things like SREC as it is, because of the way
the linker code is layed out.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
