Received:  by oss.sgi.com id <S42293AbQEXRoF>;
	Wed, 24 May 2000 10:44:05 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:1148 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42277AbQEXRni>; Wed, 24 May 2000 10:43:38 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA08165; Wed, 24 May 2000 10:48:17 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA10206
	for linux-list;
	Wed, 24 May 2000 10:29:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA79231
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 10:29:51 -0700 (PDT)
	mail_from (watkinse@attens.com)
Received: from staff.cerf.net (staff.cerf.net [198.137.140.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA02620
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 10:29:47 -0700 (PDT)
	mail_from (watkinse@attens.com)
Received: from sdhqdt0132 (dhcp684.hq.sd.cerf.net [192.215.14.84])
	by staff.cerf.net (8.10.1/8.9.3) with SMTP id e4OHTT517453;
	Wed, 24 May 2000 17:29:29 GMT
From:   "Eric Watkins" <watkinse@attens.com>
To:     "Keith M Wesolowski" <wesolows@chem.unr.edu>,
        <linux@cthulhu.engr.sgi.com>
Subject: RE: New mini-distribution/indigo2 monitor support
Date:   Wed, 24 May 2000 10:29:26 -0700
Message-ID: <003001bfc5a5$9be16960$540ed7c0@hq.sd.cerf.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <20000519154511.B21086@chem.unr.edu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-Filtered-By: VBFilter 1.0
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello,

I noticed in your instructions that you suggest removing the framebuffer
from the video card so the distribution will boot?

QUOTE:
"Note: If your system has an XZ framebuffer in it, you must remove it prior
to booting and use a serial console instead. The XZ framebuffer will likely
prevent your system from booting Linux even if you are not using it. "

Are you suggesting that I remove the vid card?

I'm trying to get my indigo2 to boot linux. Can you go into more detail on
how to remove the framebuffer?


For the rest of the list.. When will I be able to use these monitors? The
monitor is almost the best part of the whole system. I've got PCs that will
run rings around the indigo2 that don't have 21 inch monitors. It's not good
to tell people 'Oh ya linux boots on that but then I have to use this dumb
terminal to do anything.' At this point people start to laugh.

When can I see X in all of it's glory on an indigo2?

Thanks!

> -----Original Message-----
> From: owner-linux@cthulhu.engr.sgi.com
> [mailto:owner-linux@cthulhu.engr.sgi.com]On Behalf Of Keith M Wesolowski
> Sent: Friday, May 19, 2000 3:45 PM
> To: linux@cthulhu.engr.sgi.com
> Subject: New mini-distribution
>
>
> Hi all,
>
> I got bored last week and put together a new mini-distribution for
> SGIs. I know it works on Indigo2 at least. It's a lot smaller and has
> some more up to date components than Hard Hat. Perhaps it would be a
> good starting point for someone to use, or maybe it will be of no use
> to anyone but me. :) Those interested can read a quick HOWTO at
> http://foobazco.org/~wesolows/Install-HOWTO.html; the necessary files
> are at ftp://ftp.foobazco.org/pub/people/wesolows/mips-linux/.
>
> Quick rundown:
>
> Kernel 2.2.14 from CVS
> glibc 2.0.6 with patches
> egcs 1.1.2 with patches
> binutils 000425 with patches
> bash 2.04
> vim 5.6
> barebones initscripts
> miscellaneous useful software
> NFS-based installation
>
> Plans:
>
> Not much. I will probably try to get gcc 2.96 and glibc 2.2 working
> with it, those being the least up to date parts of it all. I don't
> really think this is going anywhere; Debian will hopefully be finished
> soon.
>
> --
> Keith M Wesolowski			wesolows@chem.unr.edu
> University of Nevada			http://www.chem.unr.edu
> Chemistry Department Systems and Network Administrator
>
