Received:  by oss.sgi.com id <S42277AbQFLQeH>;
	Mon, 12 Jun 2000 09:34:07 -0700
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:62181 "EHLO
        mta05-svc.ntlworld.com") by oss.sgi.com with ESMTP
	id <S42276AbQFLQds>; Mon, 12 Jun 2000 09:33:48 -0700
Received: from icserver.ichilton.co.uk ([62.252.240.129])
          by mta02-svc.server.ntlworld.com
          (InterMail vM.4.01.02.27 201-229-119-110) with ESMTP
          id <20000612133940.SEYQ10065.mta02-svc.server.ntlworld.com@icserver.ichilton.co.uk>;
          Mon, 12 Jun 2000 13:39:40 +0000
Received: from ian (ian.ichilton.local [192.168.0.8])
	by icserver.ichilton.co.uk (8.10.2/8.10.1) with SMTP id e5CCbJN26330;
	Mon, 12 Jun 2000 13:37:19 +0100
From:   "Ian Chilton" <mailinglist@ichilton.co.uk>
To:     "Alexis Cousein" <al@brussels.sgi.com>
Cc:     "Linux-MIPS Mailing List" <linux-mips@oss.sgi.com>,
        <info-iris-hardware@ARL.MIL>
Subject: RE: Can't find |
Date:   Mon, 12 Jun 2000 13:37:19 +0100
Message-ID: <NAENLMKGGBDKLPONCDDOCEHLCMAA.mailinglist@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <39440AA3.51CEDFA3@brussels.sgi.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4132.2800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> That's *usually* easy. You usu need another model specified in
> /usr/lib/X11/xkb/X0-config.keyboard -- you have a 102 key keyboard and
> the Indy thinks you have a 101 kkey keyboard or vice-versa.

> Note that a file somewhere in the .desktop home directory of users can
> override this file, so make sure that default file is the only one on
> the system!

In the desktopenv file, it has:
SGI_KB_LAYOUT="gb"

Will this matter?


> Trouble is, it's been so long I've had to answer this that it's no
> longer in deja.com archives

I have tried what you suggested, and it doesn't make any difference...I can
only get a |.

Anyone know exactly what the command is to go in this file?


I did find however, that while IRIX is booting, and that console window
comes up, I can do CTRL-ALT, and they key left of 1 and get a |, but this
doesn't work once it's booted. In a terminal window, I just get '15q' when I
press this.


Any ideas?


Thanks!


Bye for Now,

Ian


                     \|||/
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
