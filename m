Received:  by oss.sgi.com id <S305194AbQDCIuV>;
	Mon, 3 Apr 2000 01:50:21 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:61516 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305164AbQDCIuA>; Mon, 3 Apr 2000 01:50:00 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA07740; Mon, 3 Apr 2000 01:53:44 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA04319
	for linux-list;
	Mon, 3 Apr 2000 01:29:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA09766
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Apr 2000 01:29:35 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be ([193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA03120
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Apr 2000 01:29:34 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA14782;
	Mon, 3 Apr 2000 10:29:32 +0200 (MET DST)
Date:   Mon, 3 Apr 2000 10:29:31 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: mips config.in patch 1 of N - Check for completeness
In-Reply-To: <20000402092455.C1368@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10004031028110.22512-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, 2 Apr 2000, Florian Lohoff wrote:
> +	#Architectures possibly having pcmcia should include this
> +        #source drivers/pcmcia/Config.in

i.e. CONFIG_PCI || CONFIG_ISA

> +	#Architectures having PC Style Parports - please include
> +        #source drivers/parport/Config.in

i.e. CONFIG_ISA

Note that here are also non-PC style parport drivers (e.g. for Amiga), but for
MIPS I think the PC-style parports are the only ones that matter.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
