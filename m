Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FLtInC002410
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 14:55:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FLtIt7002409
	for linux-mips-outgoing; Wed, 15 May 2002 14:55:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FLtCnC002406
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 14:55:12 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Wed, 15 May 2002 14:55:11 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id OAA24404; Wed, 15 May 2002 14:55:40 -0700 (PDT)
Received: from broadcom.com (kwalker@dt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.8.8/8.8.8/MS01) with ESMTP id OAA19106;
 Wed, 15 May 2002 14:55:39 -0700 (PDT)
Message-ID: <3CE2D95B.E1E43662@broadcom.com>
Date: Wed, 15 May 2002 14:55:39 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Matthew Dharm" <mdharm@momenco.com>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com>
 <20020515214818.GA1991@nevyn.them.org>
X-WSS-ID: 10FC06B5660008-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Since traditionally the mips kernel could only manage RAM reachable by
Kseg you were limited to 512MB, right?  But now the High Memory stuff is
stable enough that you can reach any RAM that's physically addressable
in 32-bits.  And after that, there's the 64bit-physical-address
extension which allows you to reach physical pages that need > 32-bits
to address.

Kip

Daniel Jacobowitz wrote:
> 
> On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
> > So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
> > That kinda blows the 32-bit MIPS port option right out of the water...
> 
> Not unless you count bits differently than I do... 32-bit is 4 GiB.  Is
> there any reason MIPS has special problems in this area?
> 
> >
> > What does it take to do a 64-bit port?  The first problem I see is the
> > boot loader -- do I have to be in 64-bit mode when the kernel starts,
> > or can I start in 32-bit mode and then transfer to 64-bit mode?
> >
> > I looked in the arch/mips64/ directory, but I don't see much for
> > specific boards there, but there are references to the Malta
> > boards....
> >
> > Matt
> >
> > --
> > Matthew D. Dharm                            Senior Software Designer
> > Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> > (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> > Momentum Works For You                      www.momenco.com
> >
> >
> 
> --
> Daniel Jacobowitz                           Carnegie Mellon University
> MontaVista Software                         Debian GNU/Linux Developer
