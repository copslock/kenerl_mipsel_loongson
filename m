Received:  by oss.sgi.com id <S305194AbQDCJPM>;
	Mon, 3 Apr 2000 02:15:12 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:5163 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQDCJPG>;
	Mon, 3 Apr 2000 02:15:06 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA26621; Mon, 3 Apr 2000 02:10:25 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA26949
	for linux-list;
	Mon, 3 Apr 2000 02:01:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA51507
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Apr 2000 02:01:09 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA05300
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Apr 2000 02:01:05 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 964737D9; Mon,  3 Apr 2000 11:01:01 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 584E68FC3; Mon,  3 Apr 2000 10:39:44 +0200 (CEST)
Date:   Mon, 3 Apr 2000 10:39:44 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: mips config.in patch 1 of N - Check for completeness
Message-ID: <20000403103944.A278@paradigm.rfc822.org>
References: <20000402092455.C1368@paradigm.rfc822.org> <Pine.GSO.4.10.10004031028110.22512-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.GSO.4.10.10004031028110.22512-100000@dandelion.sonytel.be>; from Geert Uytterhoeven on Mon, Apr 03, 2000 at 10:29:31AM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Apr 03, 2000 at 10:29:31AM +0200, Geert Uytterhoeven wrote:
> On Sun, 2 Apr 2000, Florian Lohoff wrote:
> > +	#Architectures possibly having pcmcia should include this
> > +        #source drivers/pcmcia/Config.in
> 
> i.e. CONFIG_PCI || CONFIG_ISA

I didnt want to do that because i dont think anyone has seen
a RM200C with PCMCIA ? So i thought architectures explecitely 
having a PCMCIA (Like probably the Handhelds like Aero, Cassiopaia etc)
would enable it with "CONFIG_AERO" or something.

> > +	#Architectures having PC Style Parports - please include
> > +        #source drivers/parport/Config.in
> 
> i.e. CONFIG_ISA
> 
> Note that here are also non-PC style parport drivers (e.g. for Amiga), but for
> MIPS I think the PC-style parports are the only ones that matter.

Are they represented in the above config ? ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
