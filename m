Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 23:48:42 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:31990 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225479AbUC3Wsl>;
	Tue, 30 Mar 2004 23:48:41 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA26284;
	Tue, 30 Mar 2004 14:48:36 -0800
Message-ID: <4069F942.5090202@mvista.com>
Date: Tue, 30 Mar 2004 14:48:34 -0800
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Lees <bob@diamond.demon.co.uk>
CC: Dan Malek <dan@embeddededge.com>, linux-mips@linux-mips.org
Subject: Re: Frequency (cpu speed) control on AU1100
References: <200403302137.38123.bob@diamond.demon.co.uk> <4069ED03.8060202@embeddededge.com> <200403302338.08735.bob@diamond.demon.co.uk>
In-Reply-To: <200403302338.08735.bob@diamond.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Bob Lees wrote:

>On Tuesday 30 March 2004 22:56, Dan Malek wrote:
>  
>
>>Bob Lees wrote:
>> > ....I suspect I am
>>    
>>
>>>missing something somewhere, but I can't find any references to cpu speed
>>>control for the MIPS processors, specically the au1x range.
>>>      
>>>
>>The Au1xxx has a PLL that multiplies the incoming 12 MHz clock up to the
>>internal frequency.  Just be aware there are lots of peripheral clocks
>>and bus clocks derived from this internal frequency.  There is code
>>in the kernel power management to allow changing the frequency during
>>operation of Linux, but I don't know how well it works today as I have
>>not tested that for quite some time.
>>
>>Thanks.
>>	-- Dan
>>    
>>
>
>Thanks Dan & Pete for the prompt response.  
>
>I have tried the /proc/sys/pm/freq interface and by putting a bogomips calc 
>into power.c, it appears to indicate a change in core frequency.  I think 
>your caution may be well founded as I got input overruns on the serial 
>console when I took the speed down to 84MHz, good character recognition 
>though, so it was an input buffer speed issue.
>
>Also I can see an approx 40-50mA change in current from 84 to 396MHz which 
>indicates something is changing.  Supply is at 5 volts thru a simple switcher 
>down to 3.3 volts on the Aurora board.  This is with nothing else running and 
>an nfs filesystem.  As part of monitoring current I am seeing an anomoly: 
>namely after boot is complete and system is quiesent, at apparently 396MHz, 
>the current is 200mA, now after playing with the freq control the current at 
>396MHz stabalises at around 250mA.  Verrry strange - any thoughts??
>  
>
Is the 250mA after you've done a new power cycle, which doesn't make 
sense, or after you scale down to 84 and back up to 396MHz?

>On another topic, what state is the IRDA driver in?  
>
It works. Check out the IrDA readme on 
linux-mips.org:/pub/linux/mips/people/ppopov/2.4. I've tested two boards 
back to back using the network layer at FIR speeds, and a board to palm 
pilot using SIR. It's all in the readme.

>This is building from the 
>patched 2.4.25 kernel on your site Dan.  And a big thank you for this source 
>of a patched kernel and build tools.
>  
>

Pete
