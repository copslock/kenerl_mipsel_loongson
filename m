Received:  by oss.sgi.com id <S305196AbQDDJQI>;
	Tue, 4 Apr 2000 02:16:08 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:18004 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305176AbQDDJP7>; Tue, 4 Apr 2000 02:15:59 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id CAA01993; Tue, 4 Apr 2000 02:19:43 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id CAA60621; Tue, 4 Apr 2000 02:15:57 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA64159
	for linux-list;
	Tue, 4 Apr 2000 02:00:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA88598
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 Apr 2000 02:00:00 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA07714
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 Apr 2000 01:59:52 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA06999;
	Tue, 4 Apr 2000 10:59:44 +0200 (MET DST)
Date:   Tue, 4 Apr 2000 10:59:43 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel hang indigo2 current cvs more specific
In-Reply-To: <20000404102252.B276@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10004041057310.24463-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, 4 Apr 2000, Florian Lohoff wrote:
> On Tue, Apr 04, 2000 at 01:54:30AM +0200, Florian Lohoff wrote:
> > i debugged a bit arround and found that the current CVS kernel
> > hang at "alloc_page.c" (For SGI_IP22)
> > 
> >         lmem_map = (struct page *) alloc_bootmem_node(nid, map_size);
> > 
> > I had a small look into the function alloc_bootmem_node/core but didnt
> > understand a word.
> 
> Reduced it even more - At the end of alloc_bootmem_core the memset is
> the fault - It seems to overwrite something and/or does not return.
> 
> My suspicion is that the memory map(s) are not correct and initializing
> existing memory causes this fault.

Perhaps this helps: the bootmem stuff in arch/mips/ddb5074/prom.c works fine.
The DDB5074 has 64 MB of fixed non-upgradable memory at physical 0x00000000
virtual 0x80000000.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
