Received:  by oss.sgi.com id <S305162AbQBOLhW>;
	Tue, 15 Feb 2000 03:37:22 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:58189 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBOLg4>; Tue, 15 Feb 2000 03:36:56 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA04843; Tue, 15 Feb 2000 03:39:47 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA81431
	for linux-list;
	Tue, 15 Feb 2000 03:21:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA30084
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 15 Feb 2000 03:20:58 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA03956
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Feb 2000 03:20:58 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA04439;
	Tue, 15 Feb 2000 03:20:56 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA14616;
	Tue, 15 Feb 2000 03:20:54 -0800 (PST)
Message-ID: <00f001bf77a7$01e6cd10$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Cc:     <linux@cthulhu.engr.sgi.com>
Subject: Re: ioremap() broken?
Date:   Tue, 15 Feb 2000 12:22:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>> > 1. Is it really necessary to add anything to the addr in the readb() et al.
>> >    macros? ioremap() already takes care of that.
>> 
>> There is something of an "embarassment of riches" in the kernel
>> code in terms of mechanism for getting at I/O resources.  I don't
>> think it was ever intended that people use readb() on addresses
>> that had already been massaged with ioremap().  ioremap() is
>> used where the driver *expects* an memory-mapped I/O model,
>> and is applied to pointers that will be used to directly reference
>> the device.  readb/writeb et. al. are for drivers that think that expect
>> a more peek/poke like model.  I don't think it was ever intended that
>> someone apply both at once!
>
>Yes it is! Please read Documentation/IO-mapping.txt. To access PCI memory
>space, you have to use ioremap() and readb() and friends. If PCI drivers have
>to work across differen architectures, this has to be fixed.

OK, having looked at the documentation, I've seen the Holy Word of 
Linus in the topic, even if it seems to be honored mainly in the breach 
in real world drivers. It also seems to be somewhat confusing
in its treatment of ISA versus PCI, and insufficient to handle some
possible system configurations.  More on this later.
.
But for Geert's problem, the fix is simple - get rid of the offset added 
in the readb() macro and its friends.   Linus' definitions are a bit vague.
The "addresses" returned by ioremap() need not, according to his
description, be valid addresses at all, but must simply be tokens that
are unique within the system and usable by readb() et. al.  All VM
manipulation *could* be handled in the readb() code, but that would
in general be inefficient.  It seems clear enough that ioremap() should 
encapsulate all address transformation and VM resource management, 
and that readb() should encapsulate the mechanics of the data transfer.

It is a coincidence that ioremap() is so simple on most current MIPS 
platforms.  On some systems, and on MIPS systems with more than 
512M of combined memory and mapped I/O, it would be necessary
to invoke VM functions to create (and possibly wire) a kernel address
mapping, and on such systems ioremap() would have some real work
to do.

The readb/writeb/etc. macros thus are not expected to fix any mappings,
but rather to provide wrappers that would conceal the use of special
I/O access instructions, non-fatal bus error resolution, etc., depending
on the platform and the architecture.  On current MIPS systems, it maps 
directly to a load/store.

            Kevin K.
