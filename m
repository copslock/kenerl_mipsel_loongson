Received:  by oss.sgi.com id <S42307AbQFTKGZ>;
	Tue, 20 Jun 2000 03:06:25 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:64071 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42229AbQFTKGJ>; Tue, 20 Jun 2000 03:06:09 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA09138
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 03:11:17 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA74617 for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 03:05:38 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA95228
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 03:03:28 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA03553
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 03:03:23 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA21773;
	Tue, 20 Jun 2000 12:02:41 +0200 (MET DST)
Date:   Tue, 20 Jun 2000 12:02:41 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Dominic Sweetman <dom@algor.co.uk>
cc:     Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, nigel@algor.co.uk
Subject: Re: R5000 support (specifically two-way set-associative cache...)
In-Reply-To: <200006200947.KAA08574@mudchute.algor.co.uk>
Message-ID: <Pine.GSO.4.10.10006201201550.8592-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 20 Jun 2000, Dominic Sweetman wrote:
> Jun Sun (jsun@mvista.com) writes:
> > 3. I understand Geert has a port to DDB5074 (with Vr5000 CPU).  Is this
> > port completed (including all interrupts, PCI related stuff).  Is this
> > port reliable?
> 
> A note on this and Geert's response: early Vrc5074 system controller
> chips had lots of bugs, with some particularly nasty ones hitting PCI
> transfers with external initiators (like the ethernet chip).  Anyone
> pioneering Linux on it should check carefully with NEC about the
> status of their particular revision.

Since the same boards are fine running Aperios, I assume we don't have the
early ones.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
