Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA176168; Wed, 20 Aug 1997 20:18:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA19995 for linux-list; Wed, 20 Aug 1997 20:17:21 -0700
Received: from motown.detroit.sgi.com (motown.detroit.sgi.com [169.238.128.3]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA19932 for <linux@cthulhu.engr.sgi.com>; Wed, 20 Aug 1997 20:17:11 -0700
Received: from detroit.sgi.com by motown.detroit.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id XAA22228; Wed, 20 Aug 1997 23:16:43 -0400
Message-ID: <33FBB2AD.4CA539DD@detroit.sgi.com>
Date: Wed, 20 Aug 1997 23:14:53 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Oliver Frommel <oliver@aec.at>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: "unable to handle kernel paging request" at boot
References: <Pine.LNX.3.91.970821030958.11978A-100000@web.aec.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Oliver Frommel wrote:
> 
> hi,
> 
> after i was finally able to free and Indy from useless tasks like DNS, mail, www
> :) i have now problems booting the machine.
> after/at start of the Ethernet driver i get the following message:
> 
> eth0 SGI Seeq ....
> Unable to handle kernel paging request at 00000008, epc: 880d8a64
> 
> what's going wrong ?
> 
> oliver

Ill put $100.00 US that you have an R4000 or R4400 Indy NOT an R4600.

The only system we have been able to boot is an R4600 with the kernel we
pulled down off ftp.

-- 
Eric Kimminau                             System Engineer
eak@detroit.sgi.com                       Silicon Graphics, Inc
Vox:(810) 848-4455                        39001 West 12mile Road
Fax:(810)848-5600                         Farmington, MI 48331-2903
            "I speak my mind and no one else's."
    http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

-----END PGP PUBLIC KEY BLOCK-----
http://bs.mit.edu:11371/pks/lookup?op=vindex&search=Eric+A.+Kimminau&fingerprint=on
