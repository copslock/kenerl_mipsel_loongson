Received:  by oss.sgi.com id <S42200AbQFWOdh>;
	Fri, 23 Jun 2000 07:33:37 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:48723 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42182AbQFWOdM>; Fri, 23 Jun 2000 07:33:12 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA07615
	for <linux-mips@oss.sgi.com>; Fri, 23 Jun 2000 07:38:15 -0700 (PDT)
	mail_from (dkeen@bellsouth.net)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA89479
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 23 Jun 2000 07:32:20 -0700 (PDT)
	mail_from (dkeen@bellsouth.net)
Received: from mail2.mco.bellsouth.net (mail2.mco.bellsouth.net [205.152.111.14]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA09535
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jun 2000 07:32:19 -0700 (PDT)
	mail_from (dkeen@bellsouth.net)
Received: from bellsouth.net (host-209-214-105-157.bhm.bellsouth.net [209.214.105.157])
	by mail2.mco.bellsouth.net (3.3.5alt/0.75.2) with ESMTP id KAA17437;
	Fri, 23 Jun 2000 10:21:18 -0400 (EDT)
Message-ID: <39537366.5BCF325C@bellsouth.net>
Date:   Fri, 23 Jun 2000 09:25:42 -0500
From:   David Keen <dkeen@bellsouth.net>
X-Mailer: Mozilla 4.7 [en]C-bls40  (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ian Chilton <mailinglist@ichilton.co.uk>
CC:     spock@mgnet.de, Linux Debian MIPS <debian-mips@lists.debian.org>,
        Linux MIPS cthulhu <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>,
        MIPS vger <linux-mips@vger.rutgers.edu>
Subject: Re: Problems with multiple harddisks on my Indigo2
References: <NAENLMKGGBDKLPONCDDOIENHCNAA.mailinglist@ichilton.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Good Morning,
The SCSI reset problem occurred on my Indy after I added a Floptical on
ID 2. I am not running Linux on the box at this time. Have upgraded to
6.2 from 5.3 but haven't tried to reinstall the floptical yet. Set
jumpers to Indy specs, so am unsure why. BTW, would the Indy boot from
the floptical for Linux without doing a net boot?
Sincerely,
Dave Keen 

Ian Chilton wrote:
> 
> Hello,
> 
> Just to let you guys know...
> 
> I just tried the 2x HD thing in IRIX (on my Indy), and no problems!  So, it
> IS a Linux/MIPS problem!!
> 
> I did:  cp -R /usr /hd2
> 
> It was going for about 10 mins, before it ran out of disk space (1GB !). No
> errors at all   :)
> 
> Bye for Now,
> 
> Ian
> 
>                      \|||/
>                      (o o)
>  /----------------ooO-(_)-Ooo----------------\
>  |  Ian Chilton                              |
>  |  IRC Nick: GadgetMan                      |
>  |  E-Mail  : ian@ichilton.co.uk             |
>  \-------------------------------------------/
