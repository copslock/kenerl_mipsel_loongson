Received:  by oss.sgi.com id <S553736AbQKOUcK>;
	Wed, 15 Nov 2000 12:32:10 -0800
Received: from serv1.is1.u-net.net ([195.102.240.129]:23759 "EHLO
        serv1.is1.u-net.net") by oss.sgi.com with ESMTP id <S553766AbQKOUcG>;
	Wed, 15 Nov 2000 12:32:06 -0800
Received: from [213.48.88.191] (helo=zurg)
	by serv1.is1.u-net.net with smtp (Exim 3.12 #1)
	id 13w9Dt-0006H9-00; Wed, 15 Nov 2000 20:32:02 +0000
From:   "Ian Chilton" <ian@ichilton.co.uk>
To:     "Brady Brown" <bbrown@ti.com>
Cc:     "Linux-MIPS Mailing List" <linux-mips@oss.sgi.com>
Subject: RE: egcs 1.0.3a build error?
Date:   Wed, 15 Nov 2000 20:33:41 -0000
Message-ID: <NAENLMKGGBDKLPONCDDOAEMGDCAA.ian@ichilton.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3A12F036.40753275@ti.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> Thank you, I tried that and had the same result?? Maybe there are other
> CFLAGS that I need to specify?

Don't think so...it worked for me, but this was CVS GCC, not 1.0.3a. I have
had no such problems with 1.0.3a.

> CFLAGS=-O1

humm...I used CFLAGS="-O1"
donno what difference the quotes make, if any...


> --enable-languages=c c++

I use c,c++

You could also try just --enable-languages=c  then using that to compile one
with c,c++ I have done that in the past too!


> Have you been successful in getting Egcs-1.0.3a-2 to build natively on a
> MIPS little endian system?

No, big endian. Have compiled on an Indy and an I2 loads of times...


Bye for Now,

Ian


                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 \-----------------------------------------------------------------/
