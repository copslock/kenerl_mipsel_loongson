Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 19:36:11 +0000 (GMT)
Received: from p508B7076.dip.t-dialin.net ([IPv6:::ffff:80.139.112.118]:12490
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225541AbSLTTgL>; Fri, 20 Dec 2002 19:36:11 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBKJa1605163;
	Fri, 20 Dec 2002 20:36:01 +0100
Date: Fri, 20 Dec 2002 20:36:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Pichai Raghavan <ragh_avan@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: applications compiled with mips16 ISA
Message-ID: <20021220203601.A31626@linux-mips.org>
References: <20021220142459.1029.qmail@webmail8.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021220142459.1029.qmail@webmail8.rediffmail.com>; from ragh_avan@rediffmail.com on Fri, Dec 20, 2002 at 02:24:59PM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 20, 2002 at 02:24:59PM -0000, Pichai  Raghavan wrote:

> Has anyone put MIPS16 based applications on Linux 2.4.2 kernel? We 
> want to use this to get more flash storage but unaware of the 
> issues behind this. For ex: how will the loader work; will shared 
> libraries compiled with MIPS16 work with MIPS32 applications. Can 
> anyone thow light on this topic or point to us to some relevant 
> documentation?

Linux running on MIPS16 CPUs has been used to verify CPU designs.  So
all the fundamental problems have been solved.  However there's no
application or library support, so you'd be pretty much alone.  The
general assumption is that MIPS16 systems in general are too small to
be sensibly used with Linux so there is no support for MIPS16 ASE.
Since MIPS16 is just an extension on top of another instructions set
such as MIPS32 there is nothing that prevents you from using just
that instruction set only, you'd loose the benefits of MIPS16 that
way.

  Ralf
