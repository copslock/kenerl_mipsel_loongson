Received:  by oss.sgi.com id <S42225AbQFJCQ2>;
	Fri, 9 Jun 2000 19:16:28 -0700
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:54776 "EHLO
        mta03-svc.ntlworld.com") by oss.sgi.com with ESMTP
	id <S42199AbQFJCQH>; Fri, 9 Jun 2000 19:16:07 -0700
Received: from icserver.ichilton.co.uk ([62.252.236.16])
          by mta03-svc.ntlworld.com
          (InterMail vM.4.01.02.27 201-229-119-110) with ESMTP
          id <20000610021605.IUGS290.mta03-svc.ntlworld.com@icserver.ichilton.co.uk>;
          Sat, 10 Jun 2000 03:16:05 +0100
Received: from ian (ian.ichilton.local [192.168.0.8])
	by icserver.ichilton.co.uk (8.10.2/8.10.1) with SMTP id e5A2FGN06576;
	Sat, 10 Jun 2000 03:15:16 +0100
From:   "Ian Chilton" <mailinglist@ichilton.co.uk>
To:     "Ken Wills" <kenwills@tds.net>
Cc:     "Linux-MIPS Mailing List" <linux-mips@oss.sgi.com>
Subject: RE: Linux on Indy
Date:   Sat, 10 Jun 2000 03:15:22 +0100
Message-ID: <NAENLMKGGBDKLPONCDDOAEDLCMAA.mailinglist@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20000609203044.A774@spanky.yaberk.int>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4132.2800
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> use the linux fdisk to set up your partitions when the install begins.

Oh..drat, so I need to remove that partition again, now I know it works..


> No - you untar the hardhat tarfile to your nfsroot directory on 
> the machine
> that will act as your nfs server. Follow the instructions on setting up
> bootpd etc. Then boot your indy to a prom and do:
> boot bootp():vmlinux ... (rest of installation instructions.)


Right....i'll try tomorrow!



> If you've set up everything correctly, you'll tftp the kernel from your
> server, mount your root fs over nfs, and the redhat installer will start.

Is the kernel in the hardhat distro?


> You should start by setting up bootp/tftp/nfs on the machine that will
> serve the installation image to the indy.

Right...i'll have ago!!  <gulp>

Where do I get bootp/tftp from ?



BTW: is anyone on ICQ/IRC that knows how to do this??


Thanks Again!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
