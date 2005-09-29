Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2005 12:31:48 +0100 (BST)
Received: from mail.timesys.com ([65.117.135.102]:43490 "EHLO
	exchange.timesys.com") by ftp.linux-mips.org with ESMTP
	id S8133635AbVI2Lb2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Sep 2005 12:31:28 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 29 Sep 2005 07:29:14 -0400
Message-ID: <433BD08E.1020402@timesys.com>
Date:	Thu, 29 Sep 2005 07:31:26 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Floating point performance
References: <6EC3F44BE5E6B742BE3EBC3465525944096814@emea-exchange3.emea.dps.local>
In-Reply-To: <6EC3F44BE5E6B742BE3EBC3465525944096814@emea-exchange3.emea.dps.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 11:29:14.0406 (UTC) FILETIME=[053A5460:01C5C4E9]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:

>(Sorry if this mail is garbled, I'm forced to use a sub-par client)
>
>Matej Kupljen wrote:
>  
>
>>I've built soft float toolchain (with crosstool) and then build
>>MPlayer with it. The performance is very low. I cannot even play the
>>mp3 file with MPlayer on DBAU1200 with 400MHz CPU!
>>    
>>
>[...]
>  
>
>>Any other suggestions?
>>    
>>
>
>I'm not sure what you are doing, but if you only want to play music, I'd use Ogg Vorbis instead, which has a decoder that only uses integer arithmetic for exactly the case of FPU-less machines and the Au1200. I could also imagine an MP3 decoder written for integer only being written somewhere, but I don't know anything about it.
>  
>
mpg123 had a version of the libs for OS-9 that used integer ops only. It 
was in contributions and not the mainline and I don't know how difficult 
it would be to get it running on Linux. It's a dead project now anyway.

Greg Weeks
