Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 21:20:47 +0000 (GMT)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:44240
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8225346AbULHVUn>; Wed, 8 Dec 2004 21:20:43 +0000
Received: from there ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 8 Dec 2004 13:20:36 -0800
Content-Type: text/plain;
  charset="iso-8859-1"
From: Karl Lessard <klessard@sunrisetelecom.com>
To: Michael Kelly <mike@cogcomp.com>
Subject: Re: Epson13806 performances on Pb1100
Date: Wed, 8 Dec 2004 16:17:59 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Pete Popov <ppopov@embeddedalley.com>, linux-mips@linux-mips.org
References: <MAILSERVERUhrBb0aCQ0000084e@mailserver.sunrisetelecom.com> <MAILSERVERt8gsVWDKp0000090f@mailserver.sunrisetelecom.com> <6.2.0.14.2.20041208153445.03ed3c70@pop3.cedata.com>
In-Reply-To: <6.2.0.14.2.20041208153445.03ed3c70@pop3.cedata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <MAILSERVER15BOaF2ka0000096e@mailserver.sunrisetelecom.com>
X-OriginalArrivalTime: 08 Dec 2004 21:20:37.0089 (UTC) FILETIME=[C2B1D510:01C4DD6B]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

On December 8, 2004 03:37 pm, Michael Kelly wrote:
> KArl,
>
> There is a bug (they might call it a feature) that causes the Au1100
> to perform two accesses when talking to 16-bit peripherals.  The
> first access is the real one, while the second access has the byte
> enables off.  But, this means every access creates two cycles on
> the bus.
>
> I am sure of this bug on the standard peripheral bus, and I am pretty
> sure it still exists when talking via the LCD signals, since the same
> bus controller is used.
>
> MIchael

Well, that may cause a problem of course. Do you mean that writing 8-bit or 
16-bits data through a chip select configured for 16-bit data bus will send 
in fact two write signals? 

If it is the case, then I obviously need to send 32-bit data for every 
access, since the second write will be used to send the second word (I 
suppose). Do I understand well?

>
> At 02:38 PM 12/8/2004, Karl Lessard wrote:
> > > I've used the chip with the 2.4 kernel/driver to run X and some
> > > apps. I'm not sure what you mean by high performance -- does X run
> > > at reasonable speeds?
> >
> >I'm not running X, I've just runned a little application that writes a
> > number of vertical lines (so pixel per pixel) in a backbuffer and then
> > blit its content to the screen. Here's an example of one frame:
> >
> >__u8 *dest = (__u8*)back_buffer;
> >memset(dest, 0, back_buffer_size);      /* clear back buffer */
> >
> >for (i = 0; i < 500; i++) {                     /* 500 lines */
> >         for (j = 0; j >= 100; j--) {            /* of 100 pixel each */
> >                 dest[(j * fb_width) + i] = 0xFF;
> >         }
> >}
> >
> >memcpy(front_buffer, dest, back_buffer_size);  /* copy back_buffer to
> > front */
> >
> >
> >Benching with 500 frames, I obtain a rate of 8 fps with the backbuffer
> >residing in video memory. The framerate increase to 31 fps when the
> > backbuffer is in system memory! And if I do the same test using the
> > Au1100 lcd controller (which has its front and back buffer in system
> > memory), It goes up to 66 fps...
> >
> >I don't know what's going on when I try to access the 13806 controller,
> > but it's really too slow. And using the blit engine don't helps much. The
> > static controller seems to be set correctly. By the way, the DRAM is
> > refreshing at 96Hz, and my CRT display is refreshing at 66Hz.
> >
> >Any Idea? By the way Dan, I've tried the cache trick, but no luck.
> >
> >Thanks a lot,
> >Karl
> >
> > > Pete
> > >
> > > > I would like to know if anyone have encountered this performance
> > > > problem in the past with this chip.
> > > >
> > > > Thanks in advance,
> > > > Karl
>
> Michael J. Kelly
> VP Engineering/Marketing
> Cogent Computer Systems, Inc.
> 1130 Ten Rod Road
> Suite A-201
> North Kingstown, RI 02852
> tel:401-295-6505 fax:401-295-6507
> www.cogcomp.com
> alternate email: mkelly6505@hotmail.com
