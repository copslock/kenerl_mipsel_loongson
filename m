Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 22:52:12 +0100 (BST)
Received: from fep17.inet.fi ([IPv6:::ffff:194.251.242.242]:54715 "EHLO
	fep17.inet.fi") by linux-mips.org with ESMTP id <S8226750AbVGOVvz>;
	Fri, 15 Jul 2005 22:51:55 +0100
Received: from [127.0.0.1] ([80.223.109.59]) by fep17.inet.fi with ESMTP
          id <20050715215315.NCXZ26687.fep17.inet.fi@[127.0.0.1]>
          for <linux-mips@linux-mips.org>; Sat, 16 Jul 2005 00:53:15 +0300
Message-ID: <42D83063.3060505@mbnet.fi>
Date:	Sat, 16 Jul 2005 00:53:39 +0300
From:	Mikael Nousiainen <turja@mbnet.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: New VINO video drivers for Indy
References: <42D4BF49.4040907@mbnet.fi> <20050715110021.GA15740@gaspode.automagically.de>
In-Reply-To: <20050715110021.GA15740@gaspode.automagically.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <turja@mbnet.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: turja@mbnet.fi
Precedence: bulk
X-list: linux-mips

Markus Dahms wrote:

>Hello Mikael,
>
>  
>
>>I've released new drivers for SGI Indy's VINO video input (for 2.6 kernels).
>>    
>>
>
>That's what I've already waited for. Slowly 2.6.x should get usable for
>SGI machines :).
>
>  
>
>>Please test the driver and report the results so that bugs
>>(yes, I can promise there are lots of them :) can be squashed.
>>    
>>
>
>I only get a bla[nc]k image using the patched camsource or xawtv from
>from Debian Sarge with my IndyCam[1] :(. With the old driver for
>2.4.x I got some more results (striped, but at least an image...).
>I hope you could give me some hints where to start debugging...
>  
>
That's strange. There might be some problems with IndyCam initialization 
(register values),
but usually you should be able to get at least a very dark picture. 
Removing and reinstalling the
module (indycam.ko) reinitializes the camera so you can try that.
IndyCam seems to use some very odd logic to decide how bright the 
picture should be.
Try bringing some very bright light sources near the camera ?

I'm pretty sure the image capture works as it should as I've been doing 
a lot of testing
with IndyCam. Are you sure that the camera is a working one ?

Also note that xawtv isn't really a very usable application to test the 
driver as it doesn't
update listings for video standards and image controls when you change 
the input channel.

>| SGI VINO driver version 0.0.1
>| VINO with chip ID 11, revision 0 found
>| Philips SAA7191 driver version 0.0.1
>| SAA7191 initialized
>| SGI IndyCam driver version 0.0.1
>| IndyCam v1.0 detected
>| IndyCam initialized
>
>What I noticed, too:
>
>* you should really include a directory in your package, I (most people?)
>  did 'cd src/; tar zxvf vino-0.0.1.tar.gz' and screwed up my source
>  directory a bit.
>  
>
Yes, I noticed it was missing and the next release will include one. 
I'll be away (travelling) for
the next 2 weeks so it won't come out sooner than that.

>* (not so important) I cross-compile all kernel-related stuff. Although
>  'make -C $MIPSKERNELDIR SUBDIRS=`pwd`' is not as difficult, there
>  COULD be support for cross-compiling in the Makefile.
>
>  
>
I'm really not an expert with makefiles, but I'll see what I can do...

>Markus
>
>[1] yes, I opened the cover ;). channel was correct, too.
>
>  
>
That's good. :)

>>
>>
>>    
>>
>
>
>
>  
>
