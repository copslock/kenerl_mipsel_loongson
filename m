Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 23:05:36 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2452 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492237Ab0BOWFc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 23:05:32 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b79c52d0000>; Mon, 15 Feb 2010 14:05:38 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 14:05:23 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 14:05:23 -0800
Message-ID: <4B79C522.4040405@caviumnetworks.com>
Date:   Mon, 15 Feb 2010 14:05:22 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Eric Dumazet <eric.dumazet@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 4/4] Staging: Octeon:  Free transmit SKBs in a timely
 manner.
References: <4B79AAA6.60005@caviumnetworks.com>  <1266264799-3510-4-git-send-email-ddaney@caviumnetworks.com>    <1266265673.2859.5.camel@edumazet-laptop>       <4B79B15F.7030506@caviumnetworks.com> <1266268271.2859.22.camel@edumazet-laptop>
In-Reply-To: <1266268271.2859.22.camel@edumazet-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Feb 2010 22:05:23.0251 (UTC) FILETIME=[F891E030:01CAAE8A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/15/2010 01:11 PM, Eric Dumazet wrote:
> Le lundi 15 février 2010 à 12:41 -0800, David Daney a écrit :
>> On 02/15/2010 12:27 PM, Eric Dumazet wrote:
>>> Le lundi 15 février 2010 à 12:13 -0800, David Daney a écrit :
>>>> If we wait for the once-per-second cleanup to free transmit SKBs,
>>>> sockets with small transmit buffer sizes might spend most of their
>>>> time blocked waiting for the cleanup.
>>>>
>>>> Normally we do a cleanup for each transmitted packet.  We add a
>>>> watchdog type timer so that we also schedule a timeout for 150uS after
>>>> a packet is transmitted.  The watchdog is reset for each transmitted
>>>> packet, so for high packet rates, it never expires.  At these high
>>>> rates, the cleanups are done for each packet so the extra watchdog
>>>> initiated cleanups are not needed.
>>>
>>> s/needed/fired/
>>>
>>
>> or perhaps s/are not needed/are neither needed nor fired/
>>
>>> Hmm, but re-arming a timer for each transmited packet must have a cost ?
>>>
>>
>> The cost is fairly low (less than 10 processor clock cycles).  We didn't
>> add this for amusement, people actually do things like only send UDP
>> packets from userspace.  Since we can fill the transmit queue faster
>> than it is emptied, the socket transmit buffer is quickly consumed.  If
>> we don't free the SKBs in short order, the transmitting process get to
>> take a long sleep (until our previous once per second clean up task was
>> run).
>
> I understand this, but traditionaly, NIC drivers dont use a timer, but a
> 'TX complete' interrupt, that usually fires a few us after packet
> submission on Gigabit speed.
>

Indeed.  Lacking this type of interrupt, the watchdog seemed the best 
short term solution.

I am investigating the possibility of feeding TX complete notifications 
back through the RX path where it is possible to generate interrupts. 
The drawback to this is that it takes a lot more CPU cycles as well as 
added cache pressure.

> A fast program could try to send X small udp packets in less than 150
> us, X being greater than the size of your TX ring.

My TX queue (it is not a ring) size can be made arbitrarily large 
(currently 1000).  64bytes * 1000 packets * 10 bits/packet / 10e9 
bits/sec  == 640uS.  My watchdog will fire after less than 1/4 of the 
ring capacity is freed.

>
> So your patch makes the window smaller, but it still is there (at
> physical layer, we'll see a burst of packets, a ~100us delay, then a
> second burst)
>

With this patch, there will be no burstiness using default socket buffer 
sizes and packets of arbitrary size on a standard 1gig port.

On the 10gig ports there is the possibility for burstiness as you aptly 
explain.  However, in practice it would be difficult to arrange things 
to achieve sufficiently high packet rates, so we can live with it like this.

David Daney
