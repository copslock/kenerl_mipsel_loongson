Received:  by oss.sgi.com id <S305167AbQDDT11>;
	Tue, 4 Apr 2000 12:27:27 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:47131 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQDDT1J>; Tue, 4 Apr 2000 12:27:09 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA09446; Tue, 4 Apr 2000 12:30:55 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA70991
	for linux-list;
	Tue, 4 Apr 2000 12:15:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA82674
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 Apr 2000 12:15:00 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA04544
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 Apr 2000 12:14:40 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 91FED7F9; Tue,  4 Apr 2000 21:14:37 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A81258FC3; Tue,  4 Apr 2000 21:02:57 +0200 (CEST)
Date:   Tue, 4 Apr 2000 21:02:57 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel hang indigo2 current cvs more specific
Message-ID: <20000404210257.A1517@paradigm.rfc822.org>
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
> 
> Perhaps this helps: the bootmem stuff in arch/mips/ddb5074/prom.c works fine.
> The DDB5074 has 64 MB of fixed non-upgradable memory at physical 0x00000000
> virtual 0x80000000.

Do you or anyone else have a clue why i cant find anything like this

    bootmap_size = init_bootmem(start_pfn, mem_size >> PAGE_SHIFT);

    /* Free the entire available memory after the _end symbol.  */
    free_start += bootmap_size;
    free_bootmem(free_start, free_end-free_start);

in the arch/mips/sgi/kernel/ directory ? Could it be that this structure
is new and has never been implemented for the IP22 ?

Yep - Thats it - In 2.3.21 this init_bootmem thing doesnt exists - And though
dec hasnt got it - In 2.3.99pre3 the dec has it - But not the sgi *grrrrr*

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
