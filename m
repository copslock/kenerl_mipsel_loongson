Received:  by oss.sgi.com id <S42197AbQFVKfD>;
	Thu, 22 Jun 2000 03:35:03 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:2627 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42191AbQFVKee>; Thu, 22 Jun 2000 03:34:34 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA06148
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 03:39:44 -0700 (PDT)
	mail_from (mailinglist@ichilton.co.uk)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA97161
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Jun 2000 03:34:03 -0700 (PDT)
	mail_from (mailinglist@ichilton.co.uk)
Received: from mta02-svc.server.ntlworld.com (mta02-svc.ntlworld.com [62.253.162.42]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA04335
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jun 2000 03:33:56 -0700 (PDT)
	mail_from (mailinglist@ichilton.co.uk)
Received: from icserver.ichilton.co.uk ([62.252.240.39])
          by mta02-svc.server.ntlworld.com
          (InterMail vM.4.01.02.27 201-229-119-110) with ESMTP
          id <20000622113337.JSVW10065.mta02-svc.server.ntlworld.com@icserver.ichilton.co.uk>;
          Thu, 22 Jun 2000 11:33:37 +0000
Received: from ian (ian.ichilton.local [192.168.0.8])
	by icserver.ichilton.co.uk (8.10.2/8.10.1) with SMTP id e5MAX6v07846;
	Thu, 22 Jun 2000 11:33:06 +0100
From:   "Ian Chilton" <mailinglist@ichilton.co.uk>
To:     <spock@mgnet.de>,
        "Linux Debian MIPS" <debian-mips@lists.debian.org>,
        "Linux MIPS cthulhu" <linux@cthulhu.engr.sgi.com>,
        "Linux MIPS" <linux-mips@fnet.fr>,
        "MIPS vger" <linux-mips@vger.rutgers.edu>
Subject: RE: Problems with multiple harddisks on my Indigo2
Date:   Thu, 22 Jun 2000 11:33:04 +0100
Message-ID: <NAENLMKGGBDKLPONCDDOIENHCNAA.mailinglist@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4132.2800
In-Reply-To: <Pine.LNX.4.21.0006220022560.5050-100000@fogarty.jakma.org>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

Just to let you guys know...

I just tried the 2x HD thing in IRIX (on my Indy), and no problems!  So, it
IS a Linux/MIPS problem!!

I did:  cp -R /usr /hd2

It was going for about 10 mins, before it ran out of disk space (1GB !). No
errors at all   :)


Bye for Now,

Ian


                     \|||/
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  IRC Nick: GadgetMan                      |
 |  E-Mail  : ian@ichilton.co.uk             |
 \-------------------------------------------/
