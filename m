Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 09:27:06 +0100 (CET)
Received: from krynn.se.axis.com ([193.13.178.10]:59485 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492064AbZKLI07 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2009 09:26:59 +0100
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id nAC8QqZj032408;
	Thu, 12 Nov 2009 09:26:52 +0100
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 12 Nov 2009 09:26:52 +0100
From:	Mikael Starvik <mikael.starvik@axis.com>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Jesper Nilsson <Jesper.Nilsson@axis.com>
Date:	Thu, 12 Nov 2009 09:26:51 +0100
Subject: RE: SMTC lookup in smtc_distribute_timer
Thread-Topic: SMTC lookup in smtc_distribute_timer
Thread-Index: AcpjCE1O/6Yw4RAHRzOXKCL5K3yIvAAaX3vA
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586EA36@xmail3.se.axis.com>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E7EA@xmail3.se.axis.com>
 <4AF9C2EA.3090205@paralogos.com>
 <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E886@xmail3.se.axis.com>
 <4AFB0F30.7090209@paralogos.com>
In-Reply-To: <4AFB0F30.7090209@paralogos.com>
Accept-Language: sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage:	sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <mikael.starvik@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
X-list: linux-mips

Ok. Yes, it works in our case. Tests have run overnight without any problems.

Regards
/Mikael

-----Original Message-----
From: Kevin D. Kissell [mailto:kevink@paralogos.com] 
Sent: den 11 november 2009 20:23
To: Mikael Starvik
Cc: linux-mips@linux-mips.org; Jesper Nilsson
Subject: Re: SMTC lookup in smtc_distribute_timer

Rather than just assume all is well, I really would appreciate it
of you could send a positive acknowledgement that it solves
the problem without causing the universe to implode, so that
Ralf can queue up the patch for the repository.

       Regards,

       Kevin K.

Mikael Starvik wrote:
> Yes, I thought of that variant after I sent the email yesterday.
> I'll change our local implementation. If you don't hear anything
> it works as expected in our case (it was pretty easy for us to
> repeat).
>
> /Mikael 
>
> -----Original Message-----
> From: Kevin D. Kissell [mailto:kevink@paralogos.com] 
> Sent: den 10 november 2009 20:46
> To: Mikael Starvik
> Cc: linux-mips@linux-mips.org; Jesper Nilsson
> Subject: Re: SMTC lookup in smtc_distribute_timer
>
> Your failure scenario looks plausible. Mea culpa.  However, I think that
> a more elegant and slightly smaller (depending on just how good
> the optimizer is) fix would be:
>
> diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
> index 98bd7de..b102e4f 100644
> --- a/arch/mips/kernel/cevt-smtc.c
> +++ b/arch/mips/kernel/cevt-smtc.c
> @@ -173,11 +173,12 @@ void smtc_distribute_timer(int vpe)
>         unsigned int mtflags;
>         int cpu;
>         struct clock_event_device *cd;
> -       unsigned long nextstamp = 0L;
> +       unsigned long nextstamp;
>         unsigned long reference;
>  
>  
>  repeat:
> +       nextstamp = 0L;
>         for_each_online_cpu(cpu) {
>             /*
>              * Find virtual CPUs within the current VPE who have
>
>
>
> I don't have access to SMTC-capable hardware just now, but
> I guess the way to test this would be to have a test program
> or kernel test stub program two events separated by the smallest
> possible increment, so that the second will have passed by the
> time interrupt services for the first.
>
>           Regards,
>
>           Kevin K.
>
> Mikael Starvik wrote:
>   
>> Ok, my guess is something like this:
>>
>> 1. At the end of smtc_distribute_timer, nextstamp is valid and has already 
>> passed so we goto repeat. 
>> 2. Nothing updates nextstamp (only updated if the timeout is in the future 
>> And we just decided it is in the past)
>> 3. At the end nextstamp still has the same value so it is still valid and
>> in the past.
>> 4. This repeats until read_c0_count has a value which causes nextstamp to
>> be in the future.
>>
>> One possible patch that seams to solve it for me below. This is probably 
>> not the correct solution so I'll need help from the SMTC experts to review
>> it and come up with the correct solution.
>>
>> Best Regards
>> /Mikael
>>
>> Index: cevt-smtc.c
>> ===================================================================
>> RCS file: /usr/local/cvs/linux/os/linux-2.6/arch/mips/kernel/cevt-smtc.c,v
>> retrieving revision 1.2
>> diff -u -r1.2 cevt-smtc.c
>> --- cevt-smtc.c	2 Sep 2009 10:07:51 -0000	1.2
>> +++ cevt-smtc.c	10 Nov 2009 11:40:31 -0000
>> @@ -223,8 +223,10 @@
>>  		write_c0_compare(nextstamp);
>>  		ehb();
>>  		if ((nextstamp - (unsigned long)read_c0_count())
>> -			> (unsigned long)LONG_MAX)
>> +			> (unsigned long)LONG_MAX) {
>> +				nextstamp = 0L;  
>>  				goto repeat;
>> +			}
>>  	}
>>  }
>>
>>
>>   
>>     
>
>   
