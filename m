Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA63395 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 12:23:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA96006
	for linux-list;
	Tue, 2 Feb 1999 12:22:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA56768
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 12:22:45 -0800 (PST)
	mail_from (alambie@csd.sgi.com)
Received: from csd.sgi.com by soyuz.wellington.sgi.com via ESMTP (980427.SGI.8.8.8/940406.SGI)
	 id JAA26415; Wed, 3 Feb 1999 09:22:29 +1300 (NZD)
Message-ID: <36B75F20.5BA05C1C@csd.sgi.com>
Date: Wed, 03 Feb 1999 09:25:04 +1300
From: Alistair Lambie <alambie@rock.csd.sgi.com>
X-Mailer: Mozilla 4.51C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulf Carlsson <ulfc@bun.falkenberg.se>
CC: Alistair Lambie <alambie@rock.csd.sgi.com>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: weird HAL2
References: <19990202171745.A1051@bun.falkenberg.se> <36B753D6.641616A4@csd.sgi.com> <19990202205328.A1996@bun.falkenberg.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson wrote:
> 
> > I don't know anything about the HAL2, but looking in hal2.h it says
> > 0=reset, so from what I can see you write 0x0018 to it and then it
> > should read 0x0000 when it is reset.
> 

write 0x0
wait 50us
write 0x18

write to indirect data reg
write to indirect addr reg

spin until idirect status reg transaction status reg clears

.....


> The spec says:
> 
> Bit 3, Global reset R/W:
> Assertion of hardware reset i.e. RESET_N, set this to zero. Software brings the
> HAL2 out of reset by setting this bit and may reset the HAL2 by clearing it.
> Please note: this bit must be set before any other internal register access
> occurs.
> RESET = 0;
> ACTIVE = 1;
> 
> Bit 4, Codec reset R/W:
> Value reflected to CODEC_RESET_N pin. To reset external codecs and other
> external devices.
> RESET = 0; ACTIVE = 1;
> 
> This is exactly what I'm trying to do by first writing 0x0000 to isr, waiting
> some us, and then writing 0x0018. Then the card should be active and isr should
> IMHO contain 0x0018.
> 
> > Maybe this part is working ok for you and the problem is further along?
> 
> Nope.
> 
> - Ulf

-- 
Alistair Lambie                                alambie@csd.sgi.com
SGI Global Product Support            SGI Voicemail/VNET: 234-1455
Level 5, Cigna House,                                M/S: INZ-3780
PO Box 24 093,                                  Ph: +64-4-494 6325
40 Mercer St, Wellington,                      Fax: +64-4-494 6321
New Zealand                                 Mobile: +64-21-635 262
