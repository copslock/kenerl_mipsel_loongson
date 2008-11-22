Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 10:45:13 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:23827 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S23830644AbYKVKpE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Nov 2008 10:45:04 +0000
Received: from [192.168.236.58] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id EAA13611;
	Sat, 22 Nov 2008 04:43:50 -0600
Message-ID: <4927E2A4.5000702@paralogos.com>
Date:	Sat, 22 Nov 2008 04:44:52 -0600
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Chad Reese <kreese@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: Is there no way to shared code with Linux and other OSes?
References: <4927C34F.4000201@caviumnetworks.com> <4927D6E0.4020009@paralogos.com> <Pine.LNX.4.64.0811221109330.29539@anakin>
In-Reply-To: <Pine.LNX.4.64.0811221109330.29539@anakin>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Sat, 22 Nov 2008, Kevin D. Kissell wrote:
>   
>> [This should be good for some useless weekend flaming.]
>>     
>
> Yeah! ;-)
>
>   
>> Chad Reese wrote:
>>     
Don't blame Chad for this quote, it was me!
>> to move away from such arbitrary dogmatism.  The argument given for banning
>> typedefs altogether is that nested typedefs are confusing to programmers.  I
>>     
>
> I thought the main reason was that you can't have forward declarations of
> typedefs, while you can have for structs.
>   
That's a better argument than the one in the HTML version of 
Documentation/CodingStyle.txt that I had bookmarked (which was what I 
cited).  Interestingly, if I look at the *current* Linux 
Documentation/CodingStyle.txt for 2.6.28-rc6, the blanket interdiction 
of typedefs is no longer there!  Things *have* evolved, as I said they'd 
have to, to recognize 5 (a good Illuminati number) cases where typedefs 
are permitted.  Superficially, based on Chad's description (I admit that 
I haven't been reviewing his patches) the Cavium case would seem to fall 
into the first category. Is the MIPS Linux community now some kind of 
ultra-orthodox sub-sect of the Linux cult? ;o)

          Regards,

          Kevin K.
