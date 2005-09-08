Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 13:22:50 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:48922 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225072AbVIHMWf>; Thu, 8 Sep 2005 13:22:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j88CTYLW013694;
	Thu, 8 Sep 2005 13:29:34 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j88CTX1j013693;
	Thu, 8 Sep 2005 13:29:33 +0100
Date:	Thu, 8 Sep 2005 13:29:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Matej Kupljen <matej.kupljen@ultra.si>
Cc:	David Daney <ddaney@avtrex.com>, crossgcc@sources.redhat.com,
	linux-mips@linux-mips.org
Subject: Re: MIPS SF toolchain
Message-ID: <20050908122933.GC3608@linux-mips.org>
References: <1126098584.12696.19.camel@localhost.localdomain> <431F0850.8090804@avtrex.com> <1126168866.25388.11.camel@orionlinux.starfleet.com> <1126179199.25389.20.camel@orionlinux.starfleet.com> <1126182122.25393.27.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126182122.25393.27.camel@orionlinux.starfleet.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 08, 2005 at 02:22:02PM +0200, Matej Kupljen wrote:

> > and
> > -------------------------------------------------------------
> > 0002ff70 <__sigsetjmp_aux>:
> >    2ff70:       3c1c0017        lui     gp,0x17
> >    2ff74:       279cce40        addiu   gp,gp,-12736
> 
> This code is written in sysdeps/mips/__longjmp.c in 
> inline assembly.
> 
> > How to solve this?
> 
> Because I am using sf, there is no need to store those
> registers, or is it?
> Can I just #ifdef this code if compiled for sf?

Why not just letting the kernel fp emulator do the job?  On the average
fpu-less system fp performance doesn't matter, so the impact of the
kernel fp emulator is much less than the pain of avoiding it.

  Ralf
