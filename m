Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1Gprp14438
	for linux-mips-outgoing; Thu, 1 Nov 2001 08:51:53 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1Gpo014435
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 08:51:51 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E871E125C9; Thu,  1 Nov 2001 08:51:49 -0800 (PST)
Date: Thu, 1 Nov 2001 08:51:49 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Colin Burgess <cburgess@qnx.com>
Cc: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com, gcc@gcc.gnu.org
Subject: Re: Mozilla on MIPS
Message-ID: <20011101085149.A19298@lucon.org>
References: <200111011554.KAA196739151@node109.ott.qnx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111011554.KAA196739151@node109.ott.qnx.com>; from cburgess@qnx.com on Thu, Nov 01, 2001 at 10:54:42AM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 01, 2001 at 10:54:42AM -0500, Colin Burgess wrote:
> Hi H.J,
> 
> We're hitting the problem with getting Mozilla to run on MIPS (GOT overflow).
> I read the thread on binutils about it, and the gp_overflow manpage of the
> IRIX linker which has the multigot option.
> 
> Do you know of anyone that has successfully linked Mozilla on MIPS with the
> GNU ld?  Is anyone looking into implementing multigot functionality?

I think some platforms use 32bit GOT by default or something like that such
that Mozilla is not a problem. I don't know if it is a good idea for Linux.
As for the -multigot option for ld, I have an impression from the man page
that it is a linker feature and you don't need to modify the compiler. If
it is true, we should investigate the possibility. Unfortunately, I don't
know how -multigot works on mips.


H.J.
