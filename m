Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA83728 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 11:35:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA22150
	for linux-list;
	Tue, 2 Feb 1999 11:34:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA31066
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 11:34:44 -0800 (PST)
	mail_from (alambie@csd.sgi.com)
Received: from csd.sgi.com by soyuz.wellington.sgi.com via ESMTP (980427.SGI.8.8.8/940406.SGI)
	 id IAA48356; Wed, 3 Feb 1999 08:34:26 +1300 (NZD)
Message-ID: <36B753D6.641616A4@csd.sgi.com>
Date: Wed, 03 Feb 1999 08:36:54 +1300
From: Alistair Lambie <alambie@rock.csd.sgi.com>
X-Mailer: Mozilla 4.51C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulf Carlsson <ulfc@bun.falkenberg.se>
CC: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: weird HAL2
References: <19990202171745.A1051@bun.falkenberg.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson wrote:
> 
> On Tue, Feb 02, 1999 at 04:23:39PM +0100, Thomas Bogendoerfer wrote:
> > On Tue, Feb 02, 1999 at 05:14:44PM +0100, Ulf Carlsson wrote:
> > > Is it possible to download the BIOS and disassemble it to check how to do it
> > > correctly?
> >
> > should be doable, but I guess disassembling the IRIX driver might be easier.
> > I've hoped someone at SGI could help us out.
> 
> I think we should ask them kindly then:
> 
> Does anyone at SGI know how the HAL2 works?
> 
> We can't get it working correctly, it doesn't come back to normal state after
> the reset. Even if we write 0x0018 to isr, to enable the chip, it still shows
> 0x0000. It's certainly off because we can't write to the indirect registers in
> this state
> 

I don't know anything about the HAL2, but looking in hal2.h it says
0=reset, so from what I can see you write 0x0018 to it and then it
should read 0x0000 when it is reset.  Maybe this part is working ok for
you and the problem is further along?

There are other people who would know this better though!

Cheers, Alistair

> If we don't reset the HAL2, leaving it the way it is when after playing the boot
> sound, we can't write to the indirect registers. The busy bit doesn't go off.
> 
> The only thing which works correctly is reading the version register.
> 
> - Ulf

-- 
Alistair Lambie                                alambie@csd.sgi.com
SGI Global Product Support            SGI Voicemail/VNET: 234-1455
Level 5, Cigna House,                                M/S: INZ-3780
PO Box 24 093,                                  Ph: +64-4-494 6325
40 Mercer St, Wellington,                      Fax: +64-4-494 6321
New Zealand                                 Mobile: +64-21-635 262
