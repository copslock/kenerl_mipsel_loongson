Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA1135934 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Mar 1998 12:50:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id MAA3879383 for linux-list; Thu, 12 Mar 1998 12:49:38 -0800 (PST)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id MAA3829189 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Mar 1998 12:49:36 -0800 (PST)
Received: from detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id PAA23785; Thu, 12 Mar 1998 15:49:18 -0500
Message-ID: <35084947.20EF836A@detroit.sgi.com>
Date: Thu, 12 Mar 1998 15:44:55 -0500
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: "Tony C. Wu" <tonywu@life.nthu.edu.tw>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Getting Started ..... NOT
References: <Pine.GSO.3.96.980313030936.24023A-100000@sparc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Tony C. Wu wrote:

> 2.1.72_NOSL: put me in repair fs mode, but i can't change anything.
>              It said it couldn't read superblock on /dev/sdb

Re-read the HOWTO wehere it tells you how to remount / read-write
 
Ive gotten this far as well. I then could ifconfig my ethernet interface
and add the necessary routing information to talk to the network, but I
couldn't ever actually get it to talk. I could ping myself but nothing
else. I assumed this was because I didn't have things like inetd, rc
scripts to start things, etc...

My next step was to then pull down all of the mips RPMS to the 1st disk
running linux, and I was going to then try to mount the first disk after
booting Linux off of the second disk - then installing all of the RPM's
- but I haven't gotten there yet.

It would be REALLY nice, if someone could take their installed system,
tar/cpio the whole ball of wax and put it up for download.

Eric.


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
