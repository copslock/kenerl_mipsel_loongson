Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA46104 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Apr 1999 13:51:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA28932
	for linux-list;
	Thu, 8 Apr 1999 13:50:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA96285;
	Thu, 8 Apr 1999 13:50:37 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA05536; Thu, 8 Apr 1999 13:50:36 -0700
Date: Thu, 8 Apr 1999 13:50:36 -0700
Message-Id: <199904082050.NAA05536@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indy ISDN questions
In-Reply-To: <19990408223436.A2491@alpha.franken.de>
References: <19990408223436.A2491@alpha.franken.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer writes:
 > Ok, after Ulf got the sound working the remaining not supported hardware 
 > is VINO and ISDN. Since I'm involved in ISDN programing at work and I already
 > worked with the Linux ISDN code, I hacked together the necessary code to
 > access ISAC and HSCX. The detection looks pretty good now, but I don't
 > get interrupts from any of the two chips.
 > 
 > The IRIX header files only talk about ISDN on the IP24, but not on the IP22.
 > But I've found both of the Siemens chip on the Indy board (Fullhouse == IP22).
 > So what's up with ISDN on the Indy ? How do I get the interrupts ?

      The Indy ("Guinness") is an IP24, although it shares the "IP22" kernel with the
real IP22, Indigo2 ("Fullhouse").  Only the IP24 has ISDN.  I will look into
where the interrupts are delivered later, but it will be via one of the several
interrupt multiplexors.
