Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2004 21:09:14 +0100 (BST)
Received: from mailout2.echostar.com ([IPv6:::ffff:204.76.128.102]:38408 "EHLO
	mailout2.echostar.com") by linux-mips.org with ESMTP
	id <S8224947AbUDOUJN> convert rfc822-to-8bit; Thu, 15 Apr 2004 21:09:13 +0100
Received: by riv-exchcon.echostar.com with Internet Mail Service (5.5.2653.19)
	id <2LYLZNKH>; Thu, 15 Apr 2004 14:08:58 -0600
Message-ID: <F71A246055866844B66AFEB10654E7860F1B10@riv-exchb6.echostar.com>
From: "Xu, Jiang" <Jiang.Xu@echostar.com>
To: 'Jan-Benedict Glaw' <jbglaw@lug-owl.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: questions about keyboard
Date: Thu, 15 Apr 2004 14:08:54 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-Path: <Jiang.Xu@echostar.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jiang.Xu@echostar.com
Precedence: bulk
X-list: linux-mips

Thanks for the reply, I did some testing and found some interesting things:

1.  Everytime I push the key on the keyboard, I can see something out from
/dev/input/event0 by "cat /dev/input/event0".
However, I don't see a directory named "proc/input", did I miss configure
something in the kernel?
2.  read() does work and is a blocking read.  However, if I use select, then
it does not work.
Select() never detects the state change.
Here is the sample code I am using:
{
   int test_fd = -1;
   fd_set rfds;
   struct timeval tv;
  
   tv.tv_sec = 1;
   tv.tv_usec = 0;
   test_fd = open("/dev/input/event0", O_RDONLY); 
   if( test_fd < 0 )
     exit(0);
   
   while( 1 )
   {	
	FD_ZERO(&rfds);
	FD_SET(test_fd, &rfds);
      retval = select( 1, &rfds, NULL, NULL, &tv );
      if( retval )
         printf("\nDetects something....");
   }
}

What could be wrong?

Thanks

John

-----Original Message-----
From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de] 
Sent: Thursday, April 15, 2004 2:36 AM
To: Linux/MIPS Development
Subject: Re: questions about keyboard


On Wed, 2004-04-14 14:56:20 -0600, Xu, Jiang <Jiang.Xu@echostar.com> wrote
in message <F71A246055866844B66AFEB10654E7860F1B0D@riv-exchb6.echostar.com>:
> 2.  In the application, how can I know which input/event# the usb 
> keyboard connects to?

You don't. You can

	- Hope that your keyboard is the one and only device...
	- Read /proc/bus/input/devices - there should be a "kbd" handler
	  in the "H: " section
	- select() on all event* devices and just only process
	  keypresses generated from "normal" keys.

> 3.  Is there some reference documents about how to read things from 
> input/event# ? I mean such as how to read key event?

I don't think there's really good docu available, but it's really simple.
Just open all devices, select() until there's data available (or just call a
blocking read() on it). Something like this should work, but you'd better
add error checking to the open() call...

#include <linux/input.h>

ssize_t ret;
struct input_event my_input;
int fd;

fd = open ("/dev/input/event0", O_RDONLY);
for (;;) {
	ret = read (fd, &my_input, sizeof (my_input));
	if (ret != sizeof (my_input)
		break;

	if (my_input.type != EV_KEY)
		continue;
	/* my_input.code and my_input.type now contain the key and
	   press/release state; refer to the #defines in linux/input.h
	   for the mapping .code -> ASCII value */
}
close (fd);


-- 
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
   ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM |
TCPA));
