Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2004 21:31:32 +0100 (BST)
Received: from mailout2.echostar.com ([IPv6:::ffff:204.76.128.102]:28679 "EHLO
	mailout2.echostar.com") by linux-mips.org with ESMTP
	id <S8225747AbUDNUbb> convert rfc822-to-8bit; Wed, 14 Apr 2004 21:31:31 +0100
Received: by riv-exchcon.echostar.com with Internet Mail Service (5.5.2653.19)
	id <2LYLS50M>; Wed, 14 Apr 2004 14:31:24 -0600
Message-ID: <F71A246055866844B66AFEB10654E7860F1B0C@riv-exchb6.echostar.com>
From: "Xu, Jiang" <Jiang.Xu@echostar.com>
To: linux-mips@linux-mips.org
Subject: RE: questions about keyboard
Date: Wed, 14 Apr 2004 14:31:18 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-Path: <Jiang.Xu@echostar.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jiang.Xu@echostar.com
Precedence: bulk
X-list: linux-mips

Well, this is the problem.
For some reasons, none of the /dev/tty /dev/tty0... /dev/console is
connected to the keyboard, I have tried listening all of them.  Did I
configured something wrong? But kernel seems to be getting the key event
from the keyboard.
Another question is if it should connect to one of those device nodes, is
there anyway I can hack the kernel to see where the key event sent to?

Thanks

John


-----Original Message-----
From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de] 
Sent: Wednesday, April 14, 2004 2:26 PM
To: linux-mips@linux-mips.org
Subject: Re: questions about keyboard


On Wed, 2004-04-14 14:18:18 -0600, Xu, Jiang <Jiang.Xu@echostar.com> wrote
in message <F71A246055866844B66AFEB10654E7860F1B0B@riv-exchb6.echostar.com>:
> However, what I don't get is how can I get the key event from the 
> kernel?  I tried to listen to all the ttyN, but none of them connect to
the keyboard.
> I wonder how I can write a user space application that can get the key
> event?  Could somebody help me out?  Because it is an embedded device,
there
> is no X.

Well, one of /dev/tty, /dev/tty0 or /dev/console should work. If you'd likt
to use the new'n'fancy style, use /dev/input/eventX .

MfG, JBG

-- 
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
   ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM |
TCPA));
