Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PKLGs28141
	for linux-mips-outgoing; Mon, 25 Feb 2002 12:21:16 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PKLB928134;
	Mon, 25 Feb 2002 12:21:11 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA24373;
	Mon, 25 Feb 2002 11:21:03 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA14534;
	Mon, 25 Feb 2002 11:21:03 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g1PJKUA05311;
	Mon, 25 Feb 2002 20:20:30 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id UAA27344;
	Mon, 25 Feb 2002 20:21:00 +0100 (MET)
Message-Id: <200202251921.UAA27344@copsun18.mips.com>
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
To: ralf@oss.sgi.com (Ralf Baechle)
Date: Mon, 25 Feb 2002 20:21:00 +0100 (MET)
Cc: js@convergence.de (Johannes Stezenbach), hartvige@mips.com (Hartvig Ekner),
   linux-mips@oss.sgi.com
In-Reply-To: <20020225193928.A4385@dea.linux-mips.net> from "Ralf Baechle" at Feb 25, 2002 07:39:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Ralf Baechle writes:
> 
> On Mon, Feb 25, 2002 at 07:31:41PM +0100, Johannes Stezenbach wrote:
> > BTW: Who is "we"? Do you mean global data optimization is broken
> > in gcc/binutils or just that no one at SGI is using it?
> 
> It's an ECOFF specific optimization that just has been forward ported into
> the ELF world.  And what does this have to do with SGI anyway?

I still don't get it. Why would one not use GP optimization with non-shared
non-PIC code? It certainly is used throughout in the non-Linux MIPS world,
and on the limited testing I did today it also worked fine. Is there 
something which is known not to work, or some conflict somewhere which
prevents the general use of GP?

/Hartvig
