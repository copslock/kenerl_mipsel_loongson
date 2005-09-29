Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2005 16:39:51 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:22798
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133621AbVI2PjV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Sep 2005 16:39:21 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 29 Sep 2005 08:39:19 -0700
Message-ID: <433C0AA6.6080500@avtrex.com>
Date:	Thu, 29 Sep 2005 08:39:18 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Matej Kupljen <matej.kupljen@ultra.si>
CC:	Ulrich Eckhardt <Eckhardt@satorlaser.com>,
	linux-mips@linux-mips.org
Subject: Re: Floating point performance
References: <6EC3F44BE5E6B742BE3EBC3465525944096814@emea-exchange3.emea.dps.local> <1127992600.10179.19.camel@localhost.localdomain>
In-Reply-To: <1127992600.10179.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 15:39:19.0075 (UTC) FILETIME=[F4B51F30:01C5C50B]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Matej Kupljen wrote:
> Hi
> 
> 
>>>I've built soft float toolchain (with crosstool) and then build
>>>MPlayer with it. The performance is very low. I cannot even play the
>>>mp3 file with MPlayer on DBAU1200 with 400MHz CPU!
>>
>>[...]
>>
>>>Any other suggestions?
>>
>>I'm not sure what you are doing, but if you only want to play music, 
>>I'd use Ogg Vorbis instead, which has a decoder that only uses integer 
>>arithmetic for exactly the case of FPU-less machines and the Au1200. 
>>I could also imagine an MP3 decoder written for integer only being 
>>written somewhere, but I don't know anything about it.
> 
> 
> Yes, I can use madplay (libmad) for music only, which uses int
> arithmetics (also special version for MIPS).
> 
> But I also want to play video and currently I am testing this with
> MPlayer (maybe I'll add support for MAE, sometime in the future).
> Then I found out, that MPlayer can use libmad for MP3 and it
> works great know.
> 

We are using libmad and can play 128kbps MP3s on a mips 300MHz 4kc code 
with about 10-15% CPU utilization.

However I think anything but very low resolution low frame rate video is 
out of the question.  You need several orders of magnitude more 
processing power to make it work.  All of the MIPS based video systems 
that I am aware of (TiVo, Sony and Samsung HDTVs etc.) have dedicated 
hardware video decoders.  There are people talking about doing the 
decoding purely in software, but they would be using something with the 
processing power of a 2GHz Pentium4 with special DSP extensions.  As far 
as I know these are just paper designs and are not yet in production.

I guess what I am trying to say is that even if you could make the soft 
float library four times faster, you would still be no where close to 
being able to decode video.

I declare it impossible, but encourage you to prove me wrong.

David Daney.
