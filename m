Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2004 21:44:40 +0100 (BST)
Received: from mailout2.echostar.com ([IPv6:::ffff:204.76.128.102]:49926 "EHLO
	mailout2.echostar.com") by linux-mips.org with ESMTP
	id <S8224952AbUDOUoj> convert rfc822-to-8bit; Thu, 15 Apr 2004 21:44:39 +0100
Received: by riv-exchcon.echostar.com with Internet Mail Service (5.5.2653.19)
	id <2LYLZ4DX>; Thu, 15 Apr 2004 14:44:29 -0600
Message-ID: <F71A246055866844B66AFEB10654E7860F1B11@riv-exchb6.echostar.com>
From: "Xu, Jiang" <Jiang.Xu@echostar.com>
To: 'Jan-Benedict Glaw' <jbglaw@lug-owl.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: questions about keyboard
Date: Thu, 15 Apr 2004 14:44:25 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-Path: <Jiang.Xu@echostar.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jiang.Xu@echostar.com
Precedence: bulk
X-list: linux-mips

I really really appreciate your help.  
That is a very stupid bug, I should review my code more carefully before I
sent out for help.  Sorry about that, I guess somehow my brain just messed
up.  

Anyway, I did turn on the CONFIG_PROC_FS.  
I also mount the usb by "mount -t usbdevfs none /proc/bus/usb"; and if I
"cat /proc/filesystems" it does show "usbdevfs".  
However, is there a "inputdevfs" and is there a similar command line such as
"mount -t inputdevfs none /proc/bus/input"?
I don't see anything like "CONFIG_INPUT_DEVICEFS"?
I am using 2.4.18 kernel.

Thanks

John


-----Original Message-----
From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de] 
Sent: Thursday, April 15, 2004 2:22 PM
To: Linux/MIPS Development
Subject: Re: questions about keyboard


On Thu, 2004-04-15 14:08:54 -0600, Xu, Jiang <Jiang.Xu@echostar.com> wrote
in message <F71A246055866844B66AFEB10654E7860F1B10@riv-exchb6.echostar.com>:
> Thanks for the reply, I did some testing and found some interesting 
> things:
> 
> 1.  Everytime I push the key on the keyboard, I can see something out 
> from /dev/input/event0 by "cat /dev/input/event0". However, I don't 
> see a directory named "proc/input", did I miss configure something in 
> the kernel?

Maybe your kernel isn't configured with CONFIG_PROC_FS=y ? Maybe it's not
mounted?

> 2.  read() does work and is a blocking read.  However, if I use 
> select, then it does not work.
> Select() never detects the state change.
> Here is the sample code I am using:
> {
>    int test_fd = -1;

No need to initialize - you're assigning a value before accessing it.

>    fd_set rfds;
>    struct timeval tv;
>   
>    tv.tv_sec = 1;
>    tv.tv_usec = 0;

tv_* need to be set before *every* select () invocation, not only once.

>    test_fd = open("/dev/input/event0", O_RDONLY); 
>    if( test_fd < 0 )
>      exit(0);
>    
>    while( 1 )
>    {	
> 	FD_ZERO(&rfds);
> 	FD_SET(test_fd, &rfds);
>       retval = select( 1, &rfds, NULL, NULL, &tv );

That's wrong. The "1" should be "fd + 1".

>       if( retval )
>          printf("\nDetects something....");

A negative retval would also be != 0 ...

>    }
> }
> 
> What could be wrong?

Most probably it's the hardcoded "1" with the select. That is, select only
looks at all fd's which are smaller than one, so only fd=0 would be testes,
but this one isn't in the set, so...

MfG, JBG

-- 
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
   ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM |
TCPA));
