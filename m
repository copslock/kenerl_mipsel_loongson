Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 10:42:44 +0100 (CET)
Received: from gateway15.websitewelcome.com ([69.93.82.23]:42812 "HELO
	gateway15.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492091AbZKLJmh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2009 10:42:37 +0100
Received: (qmail 25296 invoked from network); 12 Nov 2009 09:56:21 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway15.websitewelcome.com with SMTP; 12 Nov 2009 09:56:21 -0000
Received: from c-24-23-195-109.hsd1.ca.comcast.net ([24.23.195.109]:44866 helo=odysseus.paralogos.com)
	by gator750.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1N8WCF-0001ya-QL; Thu, 12 Nov 2009 03:42:31 -0600
Message-ID: <4AFBD7D5.2090304@paralogos.com>
Date:	Thu, 12 Nov 2009 10:39:33 +0100
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Thunderbird/3.0b4
MIME-Version: 1.0
To:	Mikael Starvik <mikael.starvik@axis.com>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Jesper Nilsson <Jesper.Nilsson@axis.com>
Subject: Re: SMTC lookup in smtc_distribute_timer
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E7EA@xmail3.se.axis.com> <4AF9C2EA.3090205@paralogos.com> <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E886@xmail3.se.axis.com> <4AFB0F30.7090209@paralogos.com> <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586EA36@xmail3.se.axis.com>
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586EA36@xmail3.se.axis.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

OK, thanks.  Ralf, can we consider this one queued?  It does seem to 
have been captured correctly by Patchwork.

             Regards,

             Kevin K.

On 11/12/2009 09:26 AM, Mikael Starvik wrote:
> Ok. Yes, it works in our case. Tests have run overnight without any problems.
>
> Regards
> /Mikael
>
> -----Original Message-----
> From: Kevin D. Kissell [mailto:kevink@paralogos.com]
> Sent: den 11 november 2009 20:23
> To: Mikael Starvik
> Cc: linux-mips@linux-mips.org; Jesper Nilsson
> Subject: Re: SMTC lookup in smtc_distribute_timer
>
> Rather than just assume all is well, I really would appreciate it
> of you could send a positive acknowledgement that it solves
> the problem without causing the universe to implode, so that
> Ralf can queue up the patch for the repository.
>
>         Regards,
>
>         Kevin K.
>
> Mikael Starvik wrote:
>    
>> Yes, I thought of that variant after I sent the email yesterday.
>> I'll change our local implementation. If you don't hear anything
>> it works as expected in our case (it was pretty easy for us to
>> repeat).
>>
>> /Mikael
>>
>> -----Original Message-----
>> From: Kevin D. Kissell [mailto:kevink@paralogos.com]
>> Sent: den 10 november 2009 20:46
>> To: Mikael Starvik
>> Cc: linux-mips@linux-mips.org; Jesper Nilsson
>> Subject: Re: SMTC lookup in smtc_distribute_timer
>>
>> Your failure scenario looks plausible. Mea culpa.  However, I think that
>> a more elegant and slightly smaller (depending on just how good
>> the optimizer is) fix would be:
>>
>> diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
>> index 98bd7de..b102e4f 100644
>> --- a/arch/mips/kernel/cevt-smtc.c
>> +++ b/arch/mips/kernel/cevt-smtc.c
>> @@ -173,11 +173,12 @@ void smtc_distribute_timer(int vpe)
>>          unsigned int mtflags;
>>          int cpu;
>>          struct clock_event_device *cd;
>> -       unsigned long nextstamp = 0L;
>> +       unsigned long nextstamp;
>>          unsigned long reference;
>>
>>
>>   repeat:
>> +       nextstamp = 0L;
>>          for_each_online_cpu(cpu) {
>>              /*
>>               * Find virtual CPUs within the current VPE who have
>>
>>
>>
>> I don't have access to SMTC-capable hardware just now, but
>> I guess the way to test this would be to have a test program
>> or kernel test stub program two events separated by the smallest
>> possible increment, so that the second will have passed by the
>> time interrupt services for the first.
>>
>>            Regards,
>>
>>            Kevin K.
>>
>> Mikael Starvik wrote:
>>
>>      
>>> Ok, my guess is something like this:
>>>
>>> 1. At the end of smtc_distribute_timer, nextstamp is valid and has already
>>> passed so we goto repeat.
>>> 2. Nothing updates nextstamp (only updated if the timeout is in the future
>>> And we just decided it is in the past)
>>> 3. At the end nextstamp still has the same value so it is still valid and
>>> in the past.
>>> 4. This repeats until read_c0_count has a value which causes nextstamp to
>>> be in the future.
>>>
>>> One possible patch that seams to solve it for me below. This is probably
>>> not the correct solution so I'll need help from the SMTC experts to review
>>> it and come up with the correct solution.
>>>
>>> Best Regards
>>> /Mikael
>>>
>>> Index: cevt-smtc.c
>>> ===================================================================
>>> RCS file: /usr/local/cvs/linux/os/linux-2.6/arch/mips/kernel/cevt-smtc.c,v
>>> retrieving revision 1.2
>>> diff -u -r1.2 cevt-smtc.c
>>> --- cevt-smtc.c	2 Sep 2009 10:07:51 -0000	1.2
>>> +++ cevt-smtc.c	10 Nov 2009 11:40:31 -0000
>>> @@ -223,8 +223,10 @@
>>>   		write_c0_compare(nextstamp);
>>>   		ehb();
>>>   		if ((nextstamp - (unsigned long)read_c0_count())
>>> -			>  (unsigned long)LONG_MAX)
>>> +			>  (unsigned long)LONG_MAX) {
>>> +				nextstamp = 0L;
>>>   				goto repeat;
>>> +			}
>>>   	}
>>>   }
>>>
>>>
>>>
>>>
>>>        
>>
>>      
>    
