Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA17095 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 16:14:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA13540 for linux-list; Wed, 14 Jan 1998 16:11:22 -0800
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA13525 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 16:11:21 -0800
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id TAA14666; Wed, 14 Jan 1998 19:11:19 -0500
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cygnus.detroit.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA20883; Wed, 14 Jan 1998 19:11:17 -0500
Message-ID: <34BD5425.42EBC033@detroit.sgi.com>
Date: Wed, 14 Jan 1998 19:11:17 -0500
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.04C-SGI [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: William Ellis <bellis@cerf.net>
CC: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: Re: boot problem
References: <34BD4F3E.7F86@cerf.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

William Ellis wrote:
> 
> I'm working with a Challenge S, R5000 (Allegedly the same
> hardware as an Indy without a graphics card)
> 
> Initially booting via tftp with various errors, I am
> now trying to just get the sash boot -f to work.
> I have tried several of the applicable precompiled kernels
> at ftp.linux.sgi.com/pub/test all with similar errors:
> 
> Standalone Shell SGI Version 6.2 ARCS   Mar  9, 1996 (32 Bit)
> sash: boot -f /vmlinux root=/dev/sda1
> 1278928+236160 entry: 0x8800250c
> newport_probe: read back wrong value ;-(
> 
> What is the newport_probe?  The only non-stock thing about
> the machine is it has a fddi card in it, (which I do not
> need to get going for linux).  Could this error be an effect
> of the fddi card being present, or that there is no graphics
> card present?  Or am I missing something else all together?
> Thanks in Advance, Bill

A MAJOR difference in the ChallengeS is that it has differential SCSI
controllers as well as the Indy SingleEnded controller.


-- 
---------1---------2---------3---------4---------5---------6---------7---------8
Eric Kimminau                           RTA/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"
	
         "I am the great supportfolio, do you have http?"
