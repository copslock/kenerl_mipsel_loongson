Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA97111 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Oct 1998 07:34:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA16376
	for linux-list;
	Thu, 8 Oct 1998 07:33:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sguk.reading.sgi.com (sguk.reading.sgi.com [144.253.64.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id HAA20060
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 8 Oct 1998 07:33:47 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171]) by sguk.reading.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF+cray) via ESMTP id PAA21461; Thu, 8 Oct 1998 15:33:46 +0100
Received: from localhost (localhost [127.0.0.1]) by wintermute.reading.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id PAA16500; Thu, 8 Oct 1998 15:33:41 +0100 (BST)
Date: Thu, 8 Oct 1998 15:33:41 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
Reply-To: Leon Verrall <leon@reading.sgi.com>
To: Ulf Carlsson <grim@zigzegv.ml.org>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: R4600PC upgrade
In-Reply-To: <Pine.LNX.3.96.981008115329.995B-100000@calypso.saturn>
Message-ID: <Pine.SGI.3.96.981008112654.12420A-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 8 Oct 1998, Ulf Carlsson wrote:

> I received a R4600PC today (thanks Lukas), and I happily went to my Indy
> and plugged it in instead of my R4000SC. It failed on the diagnostics test
> though. 
> 
> Exception: <vector=Normal>
> Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> Cause register: 0x4000<CE=0,IP7,EXC=INT>
> Exception PC: 0xbfc0b598
> Interrupt exception
> CPU Parity Error Interrupt
> Local I/O interrupt register 1: 0x80 <VR/GIO2>
> CPU parity error register: 0x80b<B0,B1,B3,SYSAD_PAR>
> CPU parity error: address: 0x1fc0b598
> NESTED EXCEPTION #1 at EPC: 9fc3df00; first exception at PC: bfc0b598

We have an Indy in the lab that does this occasionally. It's a bit old and
crappy. On that machine it's a problem with the processor seating or
connections. Often happens after a power cycle.

The cure is usually, take the top off the Indy and give the processor board
a good push down and generally push everything else around it home...

Leon

-- 
Leon Verrall - 01189 257734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
