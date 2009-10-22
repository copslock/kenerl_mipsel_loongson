Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 18:03:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16583 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493291AbZJVQDv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 18:03:51 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae082630000>; Thu, 22 Oct 2009 09:03:47 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 09:03:06 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 09:03:06 -0700
Message-ID: <4AE08239.7030302@caviumnetworks.com>
Date:	Thu, 22 Oct 2009 09:03:05 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"wilbur.chan" <wilbur512@gmail.com>
CC:	"Kevin D. Kissell" <kevink@paralogos.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: Got trap No.23 when booting mips32 ?
References: <e997b7420910210740l4a8fefai27c81152a6c288ef@mail.gmail.com>	 <4ADF32D1.6030801@ru.mvista.com>	 <e997b7420910211704w67517b3bud6f4757a35945ba@mail.gmail.com>	 <4ADFAC5E.5020506@paralogos.com> <e997b7420910220755m3e78c397ia5f183c580fb170b@mail.gmail.com>
In-Reply-To: <e997b7420910220755m3e78c397ia5f183c580fb170b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2009 16:03:06.0160 (UTC) FILETIME=[24560300:01CA5331]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

wilbur.chan wrote:
> 2009/10/22 Kevin D. Kissell <kevink@paralogos.com>:
>> wilbur.chan wrote:
>>> Kernal didn't resgister IRQ 23 when booting. Hmm....the only '23'
>>> number I can find in kernel is in traps.c.
>>>
>>> Why a 23 IRQ was triggered?
>>>
>>>
>> The usual reason would be a failure to correctly initialize an interrupt
>> controller, or the Status.IM mask field.  The kernel complains precisely
>> *because* IRQ 23 wasn't registered, but an interrupt was nevertheless
>> delivered that was decoded as being that IRQ.
>>
>>         Regards,
>>
>>         Kevin K.
>>
> 
> 
> Thanks for your suggestion.
> 
> And I found that , as a matter of  fact , kernel has registered No.23 as a trap.
> 
> In trap_init :
> 
> /*
> 1419          * Only some CPUs have the watch exceptions.
> 1420          */
> 1421         if (cpu_has_watch)
> 1422                 set_except_vector(23, handle_watch);
> 
> 
> So, if a No.23 "signal" happened , kernel should  invoke handle_watch instead.
> 
> 
> But why here kernel complained ? and why kernel entered the IRQ branch
> (do_IRQ) rather than trap branch?
> 

You still don't understand.  You are not getting the watch exception. 
The '23' you see is not at all related to the exception code in the 
C0_cause register.

David Daney
