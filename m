Received:  by oss.sgi.com id <S305167AbQDDU5i>;
	Tue, 4 Apr 2000 13:57:38 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:19066 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305166AbQDDU5a>;
	Tue, 4 Apr 2000 13:57:30 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA25369; Tue, 4 Apr 2000 13:52:48 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA21767
	for linux-list;
	Tue, 4 Apr 2000 13:46:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA35601
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 Apr 2000 13:45:57 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA00963
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 Apr 2000 13:45:55 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 893477D9; Tue,  4 Apr 2000 22:45:55 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 78DC48FC3; Tue,  4 Apr 2000 22:34:15 +0200 (CEST)
Date:   Tue, 4 Apr 2000 22:34:15 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel hang indigo2 current cvs more specific
Message-ID: <20000404223415.D1517@paradigm.rfc822.org>
References: <20000404102252.B276@paradigm.rfc822.org> <Pine.GSO.4.10.10004041057310.24463-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.GSO.4.10.10004041057310.24463-100000@dandelion.sonytel.be>; from Geert Uytterhoeven on Tue, Apr 04, 2000 at 10:59:43AM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 04, 2000 at 10:59:43AM +0200, Geert Uytterhoeven wrote:
> > My suspicion is that the memory map(s) are not correct and initializing
> > existing memory causes this fault.
> 
> Perhaps this helps: the bootmem stuff in arch/mips/ddb5074/prom.c works fine.
> The DDB5074 has 64 MB of fixed non-upgradable memory at physical 0x00000000
> virtual 0x80000000.

IIRC the Virtual/Physical mapping is on the Mips cpus 1:1 on bootup right ?
So what would one pass to init_bootmem and co ?

At the moment i see start 0x8800 and size 0xff85 

Then - A bit later - the bitmap gets allocated (Free all - allocate/reserve
back - Changed that - Not the fault) ~0x1ff4 bytes ~2 Pages - I tried
to increase this (bootmap_size*4) but still in the mm/bootmem.c
the machine crashes in the memset as it trys to memset to 0
from 88002000 and ~4MB ... The most interesting thing is that even
if i increase the bootmap_size (*4) the memset begins at the same address - 
It seems that it doesnt care on allocation.

I had a look at the end of mm/bootmem.c:__alloc_bootmem_core
and saw that it trys to memset from 0x88002000.

So currently i think i lost the overview and something very obvious goes
on ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
