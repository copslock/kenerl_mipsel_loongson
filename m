Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 20:16:38 +0200 (CEST)
Received: from gateway09.websitewelcome.com ([69.93.243.4]:33603 "HELO
	gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1493286AbZIXSQb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2009 20:16:31 +0200
Received: (qmail 16014 invoked from network); 24 Sep 2009 18:27:03 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway09.websitewelcome.com with SMTP; 24 Sep 2009 18:27:03 -0000
Received: from 216-239-45-4.google.com ([216.239.45.4]:56071 helo=epiktistes.mtv.corp.google.com)
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1Mqsrj-0001sP-5E; Thu, 24 Sep 2009 13:16:27 -0500
Message-ID: <4ABBB779.1040201@paralogos.com>
Date:	Thu, 24 Sep 2009 11:16:25 -0700
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Randy MacLeod <rwmacleod@gmail.com>, linux-mips@linux-mips.org
Subject: Re: MIPS: [raw_]smp_processor_id uses current_thread_info
References: <21f828e90909231127h70f69047v91b9261226681d53@mail.gmail.com> <20090924155129.GA11576@linux-mips.org>
In-Reply-To: <20090924155129.GA11576@linux-mips.org>
Content-Type: multipart/alternative;
 boundary="------------060409050907000907080309"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060409050907000907080309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> On Wed, Sep 23, 2009 at 02:27:26PM -0400, Randy MacLeod wrote:
>
>   
>> I'd like advice on changing the implementation of smp_processor_id on
>> Cavium specifically and/or MIPS generally.
>>
>> Currently we have: arch/mips/include/asm/smp.h
>> #define raw_smp_processor_id() (current_thread_info()->cpu)
>>
>> A co-worker has an issue where the current thread pointer is corrupted
>> on a Cavium MIPS system running 2.6.14 (but the same code exists in 2.6.31).
>> During the resulting panic() the kernel calls smp_processor_id()
>> which dereferences the corrupt task pointer again - ouch. I've notice that
>> other arches have raw_smp_processor_id() defined to
>>  - a platform specific register read, or
>>  - a percpu variable or
>>  - have a hard_smp_processor_id() defined
>> This last one is presumably for times when you don't trust the kernel
>> data structures to be
>> sane.
>>     
>
> Dereferencing current_thread_info()->cpu is fairly likely to hit in the cache
> so probably a single cycle operation.
Ironically, it's statistically faster than reading a dedicated CP0 
register on those cores that have them, even if that were otherwise a 
good idea (see below), since access to CP0 registers generally doesn't 
pipeline!

>   raw_smp_processor_id() is also a
> very common operation so you really don't want to change it to something
> slower except for a debugging kernel.
>
> If you have a good kernel stack pointer you can compute the thread pointer
> from that:
>
> 	ori     $28, sp, _THREAD_MASK
> 	xori    $28, _THREAD_MASK
>
>   
>> I can create a patch that calls cvmx_get_core_num(); for cavium.
>> Is there a more generic way to get the cpu number on MIPS?
>>     
>
> raw_smp_processor_id() returns the processor ID as counted by Linux.  That
> number does not necessarily match the firmware's numbering.
Nor does it necessarily match the MIPS32R2's hardware CPU number in the 
EBase register.  smp_processor_id() is fundamentally a software concept, 
and it's more a lucky coincidence than an ironclad rule when it tracks 
hardware/firmware numbering.


          Regards,

          Kevin K.

--------------060409050907000907080309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Ralf Baechle wrote:
<blockquote cite="mid:20090924155129.GA11576@linux-mips.org" type="cite">
  <pre wrap="">On Wed, Sep 23, 2009 at 02:27:26PM -0400, Randy MacLeod wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">I'd like advice on changing the implementation of smp_processor_id on
Cavium specifically and/or MIPS generally.

Currently we have: arch/mips/include/asm/smp.h
#define raw_smp_processor_id() (current_thread_info()-&gt;cpu)

A co-worker has an issue where the current thread pointer is corrupted
on a Cavium MIPS system running 2.6.14 (but the same code exists in 2.6.31).
During the resulting panic() the kernel calls smp_processor_id()
which dereferences the corrupt task pointer again - ouch. I've notice that
other arches have raw_smp_processor_id() defined to
 - a platform specific register read, or
 - a percpu variable or
 - have a hard_smp_processor_id() defined
This last one is presumably for times when you don't trust the kernel
data structures to be
sane.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Dereferencing current_thread_info()-&gt;cpu is fairly likely to hit in the cache
so probably a single cycle operation.</pre>
</blockquote>
Ironically, it's statistically faster than reading a dedicated CP0
register on those cores that have them, even if that were otherwise a
good idea (see below), since access to CP0 registers generally doesn't
pipeline!<br>
<br>
<blockquote cite="mid:20090924155129.GA11576@linux-mips.org" type="cite">
  <pre wrap="">  raw_smp_processor_id() is also a
very common operation so you really don't want to change it to something
slower except for a debugging kernel.

If you have a good kernel stack pointer you can compute the thread pointer
from that:

	ori     $28, sp, _THREAD_MASK
	xori    $28, _THREAD_MASK

  </pre>
  <blockquote type="cite">
    <pre wrap="">I can create a patch that calls cvmx_get_core_num(); for cavium.
Is there a more generic way to get the cpu number on MIPS?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
raw_smp_processor_id() returns the processor ID as counted by Linux.  That
number does not necessarily match the firmware's numbering.</pre>
</blockquote>
Nor does it necessarily match the MIPS32R2's hardware CPU number in the
EBase register.&nbsp; smp_processor_id() is fundamentally a software
concept, and it's more a lucky coincidence than an ironclad rule when
it tracks hardware/firmware numbering.<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Regards,<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Kevin K.<br>
</body>
</html>

--------------060409050907000907080309--
