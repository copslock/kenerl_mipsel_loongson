Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA94094 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Feb 1999 11:41:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA01621
	for linux-list;
	Thu, 11 Feb 1999 11:40:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA95820
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 11 Feb 1999 11:40:24 -0800 (PST)
	mail_from (alambie@csd.sgi.com)
Received: from csd.sgi.com by soyuz.wellington.sgi.com via ESMTP (980427.SGI.8.8.8/940406.SGI)
	 id IAA50137; Fri, 12 Feb 1999 08:40:15 +1300 (NZD)
Message-ID: <36C332C9.DB6BCD82@csd.sgi.com>
Date: Fri, 12 Feb 1999 08:43:05 +1300
From: Alistair Lambie <alambie@rock.csd.sgi.com>
X-Mailer: Mozilla 4.51C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Shaver <shaver@netscape.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: serial console cable specs
References: <36C31EC1.61242174@netscape.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote:
> 
> I have it set to 9600 N81, and I set console to d2, and I can see the
> system menu when the machine boots.  But I can't type anything at it.
> This is making it quite difficult to do anything with my machine, so I'm
> going to go get another cable.
> 

I have found some terminals (assuming that is what you are using) that
require either DSR or CTS before they will transmit anything even with
flow control off.

Cheers, Alistair

-- 
Alistair Lambie                                alambie@csd.sgi.com
SGI Global Product Support            SGI Voicemail/VNET: 234-1455
Level 5, Cigna House,                                M/S: INZ-3780
PO Box 24 093,                                  Ph: +64-4-494 6325
40 Mercer St, Wellington,                      Fax: +64-4-494 6321
New Zealand                                 Mobile: +64-21-635 262
