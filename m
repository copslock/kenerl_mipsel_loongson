Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA06046
	for <pstadt@stud.fh-heilbronn.de>; Thu, 23 Sep 1999 01:22:05 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA07369; Wed, 22 Sep 1999 16:18:59 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA05521
	for linux-list;
	Wed, 22 Sep 1999 16:11:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA98101
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Sep 1999 16:11:52 -0700 (PDT)
	mail_from (alambie@csd.sgi.com)
Received: from csd.sgi.com by soyuz.wellington.sgi.com via ESMTP (980427.SGI.8.8.8/940406.SGI)
	 id LAA34872; Thu, 23 Sep 1999 11:11:41 +1200 (NZT)
Message-ID: <37E96210.64A50BBF@csd.sgi.com>
Date: Thu, 23 Sep 1999 11:11:12 +1200
From: Alistair Lambie <alambie@relay.csd.sgi.com>
X-Mailer: Mozilla 4.6C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Rory Hunter <roryh@dcs.ed.ac.uk>
CC: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: oddness
References: <37E95D52.AC2CE967@dcs.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Rory Hunter wrote:
> 
> hi,
> 
> I noticed yesteday that it appears that a partition has been set aside
> by the previous owners of my O2 for /proc... assuming that 'df' isn't
> lying to me, can anyone think of a reason why an 800Mb partition would
> be set aside for /proc?
> 

No, this is not really a partition.  See the man page for proc(4).  It
provides an image of each active process on the system.  It does not
consume any disk resources.

Cheers, Alistair 

-- 
Alistair Lambie                                alambie@csd.sgi.com
SGI Global Product Support            SGI Voicemail/VNET: 234-1455
Level 5, Cigna House,                                M/S: INZ-3780
PO Box 24 093,                                  Ph: +64-4-494 6325
40 Mercer St, Wellington,                      Fax: +64-4-494 6321
New Zealand                                 Mobile: +64-21-635 262
