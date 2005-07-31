Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jul 2005 19:44:34 +0100 (BST)
Received: from fep17.inet.fi ([IPv6:::ffff:194.251.242.242]:39357 "EHLO
	fep17.inet.fi") by linux-mips.org with ESMTP id <S8225273AbVGaSoT>;
	Sun, 31 Jul 2005 19:44:19 +0100
Received: from [127.0.0.1] ([80.223.109.59]) by fep17.inet.fi with ESMTP
          id <20050731184720.YEYC5344.fep17.inet.fi@[127.0.0.1]>;
          Sun, 31 Jul 2005 21:47:20 +0300
Message-ID: <42ED1CBE.4060901@mbnet.fi>
Date:	Sun, 31 Jul 2005 21:47:26 +0300
From:	Mikael Nousiainen <turja@mbnet.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Markus Dahms <mad@automagically.de>
CC:	linux-mips@linux-mips.org
Subject: Re: New VINO video drivers for Indy
References: <42D4BF49.4040907@mbnet.fi> <20050715110021.GA15740@gaspode.automagically.de> <42D83063.3060505@mbnet.fi> <20050716112745.GA12716@gaspode.automagically.de>
In-Reply-To: <20050716112745.GA12716@gaspode.automagically.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <turja@mbnet.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: turja@mbnet.fi
Precedence: bulk
X-list: linux-mips

Markus Dahms wrote:

>Hello again,
>
>  
>
>>>I only get a bla[nc]k image ...
>>>      
>>>
>>That's strange. There might be some problems with IndyCam initialization 
>>(register values),
>>but usually you should be able to get at least a very dark picture.
>>Removing and reinstalling the module (indycam.ko) reinitializes the
>>camera so you can try that. IndyCam seems to use some very odd logic
>>to decide how bright the picture should be.
>>Try bringing some very bright light sources near the camera ?
>>    
>>
>
>For some reason it's working now. It's not significantly brighter, I
>just checked the camera with kernel 2.4.x before booting 2.6.12.
>If I can reproduce the failure I'll write it.
>The picture has the same "quality" as with the other driver except
>there _are_ fewer horizontal lines (they appear mostly on fast-moving
>pictures).
>  
>
Ok, nice to know that you got it working...

Could you provide a sample image ?

The image is an interlaced image and it's constructed by joining two 
consencutive frames, so that's what
can cause some "distortion" in the image with fast-moving objects.

The horizontal lines I'm talking about don't have anything to do with 
the content of the image,
they just appear and disappear. The black lines always start from the 
left edge of the picture
and it seems that the pixels from the start of the lines get somehow 
moved forwards to the center of the
same line of the image. (eww, this is difficult to explain :)

Mikael
