Received:  by oss.sgi.com id <S42362AbQFUMry>;
	Wed, 21 Jun 2000 05:47:54 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:27994 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42305AbQFUMrZ>; Wed, 21 Jun 2000 05:47:25 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA02078
	for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 05:52:35 -0700 (PDT)
	mail_from (mailinglist@ichilton.co.uk)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA76098
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Jun 2000 05:46:45 -0700 (PDT)
	mail_from (mailinglist@ichilton.co.uk)
Received: from mta03-svc.ntlworld.com (mta03-svc.ntlworld.com [62.253.162.43]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA03816
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jun 2000 05:46:34 -0700 (PDT)
	mail_from (mailinglist@ichilton.co.uk)
Received: from icserver.ichilton.co.uk ([62.252.236.251])
          by mta03-svc.ntlworld.com
          (InterMail vM.4.01.02.27 201-229-119-110) with ESMTP
          id <20000621124642.WDTS290.mta03-svc.ntlworld.com@icserver.ichilton.co.uk>;
          Wed, 21 Jun 2000 13:46:42 +0100
Received: from ian (ian.ichilton.local [192.168.0.8])
	by icserver.ichilton.co.uk (8.10.2/8.10.1) with SMTP id e5LCh7v30630;
	Wed, 21 Jun 2000 13:43:17 +0100
From:   "Ian Chilton" <mailinglist@ichilton.co.uk>
To:     <spock@mgnet.de>,
        "Linux Debian MIPS" <debian-mips@lists.debian.org>,
        "Linux MIPS cthulhu" <linux@cthulhu.engr.sgi.com>,
        "Linux MIPS" <linux-mips@fnet.fr>,
        "MIPS vger" <linux-mips@vger.rutgers.edu>
Subject: RE: Problems with multiple harddisks on my Indigo2
Date:   Wed, 21 Jun 2000 13:43:07 +0100
Message-ID: <NAENLMKGGBDKLPONCDDOAELFCNAA.mailinglist@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20000621112343.A19912@spock>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4132.2800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> cp: /mnt/redhat/kernel23/linux/arch/sparc/lib/COPYING.LIB: 
> Input/output error
> And dmesg shows:
> attempt to access beyond end of device
> 08:03: rw=0, want=959546428, limit=1888830
[SNIP]


I have an SGI Indy, with 2 internal hard disks, a 4GB and a 1GB

I get the same thing!


> Also I'm getting a message
> sc1,2,0: cmd=0x12 timeout after 2 sec.  Resetting SCSI bus

I started getting this when I added the 2nd HD (1GB).


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail :   ian@ichilton.co.uk            |
 |  IRC Nick:  GadgetMan                     |
 \-------------------------------------------/
