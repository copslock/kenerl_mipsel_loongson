Received:  by oss.sgi.com id <S305249AbQCaTEp>;
	Fri, 31 Mar 2000 11:04:45 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:19275 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305239AbQCaTEh>;
	Fri, 31 Mar 2000 11:04:37 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA03246; Fri, 31 Mar 2000 10:59:55 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA24861
	for linux-list;
	Fri, 31 Mar 2000 10:38:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA12710
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 10:38:47 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA07276
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 10:38:46 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5C2D87D9; Fri, 31 Mar 2000 20:38:46 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 249AA8FC3; Fri, 31 Mar 2000 20:29:01 +0200 (CEST)
Date:   Fri, 31 Mar 2000 20:29:00 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Richard <richardh@penguin.nl>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel for indigo2
Message-ID: <20000331202859.A20863@paradigm.rfc822.org>
References: <20000331194525.A20241@paradigm.rfc822.org> <38E4ECA1.2362D2B@penguin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <38E4ECA1.2362D2B@penguin.nl>; from Richard on Fri, Mar 31, 2000 at 08:21:21PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 31, 2000 at 08:21:21PM +0200, Richard wrote:
> Florian Lohoff wrote:
> 
> > Hi,
> > i recently (a couple of days ago) got an Indigo2 Impact and i thought
> > of beginning to bootstrap debian-mips (I already have >900 Package for
> > debian-mipsel) but i cant even boot a kernel. The standard (and old)
> > kernel on oss.sgi.com simple halt the machine after tftp boot - When
> > building a kernel from the current CVS the machine
> > crashes with a UTLB Miss as mentioned in the MIPS-FAQ as the
> > -N binutils bugs although there is no -N in the makefile.
> >
> > Does anyone have a working kernel for the Indigo2 ?
> 
> I had this very same problem with the CVS tree on my indy r5k. If anyone knows
> what the problem is, or when it will be fixed, i'd love to now, because
> development is on a halt here right now.

As you have a R5000 machine it cant be that CPU dependent as
i have a R4400 250Mhz machine.

The development is a little on hold here too as the Current Kernel CVS
doesnt run on ANY of my platforms - On Decstation it boots but i cant
login :( and on Indigo2 it simply crashes :( On decstation i am currently
running 2.3.21 which crashes for me twice a day or something while compiling.

System: IP22
Processor: 250Mhz R4400, with FPU
ICache: 16k
DCache: 16k
2ndLevel: 2Mbyte
Memory: 128Mb
GFX: Solid Impact

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
