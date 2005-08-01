Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 19:40:00 +0100 (BST)
Received: from fep18.inet.fi ([IPv6:::ffff:194.251.242.243]:60307 "EHLO
	fep18.inet.fi") by linux-mips.org with ESMTP id <S8225976AbVHASjg>;
	Mon, 1 Aug 2005 19:39:36 +0100
Received: from [127.0.0.1] ([80.223.109.59]) by fep18.inet.fi with ESMTP
          id <20050801184239.QBRN14797.fep18.inet.fi@[127.0.0.1]>;
          Mon, 1 Aug 2005 21:42:39 +0300
Message-ID: <42EE6D23.4010800@mbnet.fi>
Date:	Mon, 01 Aug 2005 21:42:43 +0300
From:	Mikael Nousiainen <turja@mbnet.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Markus Dahms <mad@automagically.de>
CC:	linux-mips@linux-mips.org
Subject: Re: New VINO video drivers for Indy
References: <42D4BF49.4040907@mbnet.fi> <20050715110021.GA15740@gaspode.automagically.de> <42D83063.3060505@mbnet.fi> <20050716112745.GA12716@gaspode.automagically.de> <42ED1CBE.4060901@mbnet.fi> <20050801084441.GA5227@gaspode.automagically.de>
In-Reply-To: <20050801084441.GA5227@gaspode.automagically.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <turja@mbnet.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: turja@mbnet.fi
Precedence: bulk
X-list: linux-mips

Markus Dahms wrote:

>Mikael Nousiainen wrote:
>
>  
>
>>Could you provide a sample image ?
>>    
>>
>
>http://automagically.de/images/p_indycam_01.jpg
>http://automagically.de/images/p_indycam_02.jpg
>  
>
Everything seems to be ok with these...

>And (it was hard enough to capture) one with some lines on it:
>
>http://automagically.de/images/p_indycam_03.jpg
>  
>
The image is fuzzy because the camera has moved just after the first 
field for the image
has been captured, before capturing the second field (every other line).

The two black lines in the center of the image are the real problem as I 
have no
idea what causes them to appear. As you can easily check, the "missing 
content" is found
from the beginning of the same line.

>These pictures where taken with daylight, some of the colors are a bit
>strange[1] (I'll try it artificial light in the evening).
>
>Markus
>
>[1] the cyan looking highlighter on the first picture should really be
>    green ;).
>
>  
>
Yep, I've noticed same kind of behaviour with my indycam as it does not 
reproduce
blue colors correctly (blue is very weak always).
I've also heard that the camera is designed to be used in fluorescent 
light so
problems with colors seem to be a nice "feature" of the camera... :)

Thanks for the samples.

>
>
>  
>
