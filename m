Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id EAA970278 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Oct 1997 04:01:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA19540 for linux-list; Wed, 1 Oct 1997 04:01:08 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA19530 for <linux@cthulhu.engr.sgi.com>; Wed, 1 Oct 1997 04:01:04 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id GAA02065; Wed, 1 Oct 1997 06:59:43 -0400
Message-ID: <34322D1F.8AEDE04@cygnus.detroit.sgi.com>
Date: Wed, 01 Oct 1997 06:59:43 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.03C-SGI [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Ralf Baechle <ralf@cobaltmicro.com>
CC: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: For stability freaks ...
References: <199710010102.SAA22736@dns.cobaltmicro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> Ok, I said I'd touch 2.0.x for MIPS again when hell freezes.  It was
> damn cold weather the last days and hell has froozen ...
> 
> [root@(none) /]# uname -a
> Linux (none) 2.0.30 #389 Tue Sep 30 17:47:39 PDT 1997 mips unknown
> [root@(none) /]# cat /proc/cpuinfo
> cpu                     : MIPS
> cpu model               : Nevada V1.0
> system type             : Cray YMP  [just kidding ...]
> BogoMIPS                : 131.89
> byteorder               : little endian
> unaligned accesses      : 0
> wait instruction        : yes
> microsecond timers      : yes
> extra interrupt vector  : yes
> 
>   Ralf

Thats quite an impressive BogoMips number for a machine that old...

-- 
Eric Kimminau                           System Engineer/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"
