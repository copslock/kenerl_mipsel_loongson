Received:  by oss.sgi.com id <S305167AbQDQQyN>;
	Mon, 17 Apr 2000 09:54:13 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60760 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQDQQx6>; Mon, 17 Apr 2000 09:53:58 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA09054; Mon, 17 Apr 2000 09:57:57 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA24514
	for linux-list;
	Mon, 17 Apr 2000 09:35:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA82964
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Apr 2000 09:34:56 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09669
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Apr 2000 09:34:54 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port184.duesseldorf.ivm.de [195.247.65.184])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id SAA25123;
	Mon, 17 Apr 2000 18:34:34 +0200
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000417183336.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200004162112.XAA02036@jordan.numerik.math.uni-siegen.de>
Date:   Mon, 17 Apr 2000 18:33:36 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Michael Engel <engel@math.uni-siegen.de>
Subject: RE: Indigo R3000 PROM calls /
Cc:     linux@cthulhu.engr.sgi.com
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 16-Apr-00 Michael Engel wrote:
> I had some time over the weekend and started to hack on Linux for my
> good old R3000 Indigo (oh yeah, I should better try to write drivers
> for the PMAG-F and the FDDI adapter in my DECstations but Indigo 
> hacking seemed to be more fun ;-)). I can load the kernel from sash 
> and it actually starts at kernel_entry (whow) and - no wonder - crashes 
> somewhere in init_arch (because I didn't change anything there ...).
> 
> Now, it would of course be nice to have some kind of debugging output
> early on. Does anyone know if the R3k Indigo has the same ARCS console 
> semantics as the Indy ? I.e. there is a PROMBLOCK struct at address 
> 0xa0001000 (as defined in include/asm-mips/sgiarcs.h) which points to 
> romvec which I can then use to dereference PROM functions ? Or is it 
> something completely different ? 

Well, as you can imagine I have absolutely no idea, but if you have a chance to
disassemble the beginning of the PROM (0xbfc00000) you can easily check if the
Indigo provides callbacks a la MIPS (very much like the DS3100).

If you find something like:

       0:       0bf0008a        j       fc00228
       4:       00000000        nop
       8:       0bf0012a        j       fc004a8
       c:       00000000        nop
      10:       0bf0013f        j       fc004fc
      14:       00000000        nop
      18:       0bf0012c        j       fc004b0
      1c:       00000000        nop

(and I wouldn't be surprised if you did) then you should have a look at
include/asm-mips/mipsprom.h and the startup code in arch/mips/dec/prom.

-- 
Regards,
Harald
