Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 21:41:14 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1385 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492190Ab0BOUlK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2010 21:41:10 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b79b16e0000>; Mon, 15 Feb 2010 12:41:18 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 12:41:08 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 15 Feb 2010 12:41:08 -0800
Message-ID: <4B79B15F.7030506@caviumnetworks.com>
Date:   Mon, 15 Feb 2010 12:41:03 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Eric Dumazet <eric.dumazet@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 4/4] Staging: Octeon:  Free transmit SKBs in a timely
 manner.
References: <4B79AAA6.60005@caviumnetworks.com>  <1266264799-3510-4-git-send-email-ddaney@caviumnetworks.com> <1266265673.2859.5.camel@edumazet-laptop>
In-Reply-To: <1266265673.2859.5.camel@edumazet-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Feb 2010 20:41:08.0265 (UTC) FILETIME=[33903990:01CAAE7F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/15/2010 12:27 PM, Eric Dumazet wrote:
> Le lundi 15 février 2010 à 12:13 -0800, David Daney a écrit :
>> If we wait for the once-per-second cleanup to free transmit SKBs,
>> sockets with small transmit buffer sizes might spend most of their
>> time blocked waiting for the cleanup.
>>
>> Normally we do a cleanup for each transmitted packet.  We add a
>> watchdog type timer so that we also schedule a timeout for 150uS after
>> a packet is transmitted.  The watchdog is reset for each transmitted
>> packet, so for high packet rates, it never expires.  At these high
>> rates, the cleanups are done for each packet so the extra watchdog
>> initiated cleanups are not needed.
>
> s/needed/fired/
>

or perhaps s/are not needed/are neither needed nor fired/

> Hmm, but re-arming a timer for each transmited packet must have a cost ?
>

The cost is fairly low (less than 10 processor clock cycles).  We didn't 
add this for amusement, people actually do things like only send UDP 
packets from userspace.  Since we can fill the transmit queue faster 
than it is emptied, the socket transmit buffer is quickly consumed.  If 
we don't free the SKBs in short order, the transmitting process get to 
take a long sleep (until our previous once per second clean up task was 
run).

>>
>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>
> Is there any particular reason periodic is spelled preiodic ?

Ha!  No good reason.  I will correct the spelling.

Thanks,
David Daney


>
>> ---
>>   }
>>
>> -static void cvm_oct_tx_clean_worker(struct work_struct *work)
>> +static void cvm_oct_preiodic_worker(struct work_struct *work)
>>   {
>
>
>
>> -			INIT_DELAYED_WORK(&priv->tx_clean_work,
>> -					  cvm_oct_tx_clean_worker);
>> -
>> +			INIT_DELAYED_WORK(&priv->port_periodic_work,
>> +					  cvm_oct_preiodic_worker);
>
>
>
>
