Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 05:11:30 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:59602 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224839AbUJGELZ>; Thu, 7 Oct 2004 05:11:25 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i97476GG025011;
	Thu, 7 Oct 2004 09:37:06 +0530
Message-ID: <4164C099.5000503@procsys.com>
Date: Thu, 07 Oct 2004 09:35:45 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "T. P. Saravanan" <sara@procsys.com>
CC: David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Unknown ABI problem
References: <4160E489.6010503@procsys.com> <41617816.2000608@avtrex.com> <4162634E.3050600@procsys.com> <4163710D.8020009@procsys.com>
In-Reply-To: <4163710D.8020009@procsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

T. P. Saravanan wrote:

> T. P. Saravanan wrote:
>
>> David Daney wrote:
>>
>>>> What should I do to fix the build?
>>>>   
>>>
>>>
>>>
>>> get the most recent machine-gmon.h from glibc CVS.
>>>
>>> You will probably find a problem linking libc at a later step.  But the
>>> newer machine-gmon.h will fix this problem.
>>>  
>>>
>> OK. That worked.  Thanks a lot.
>>
> Oops!  I will take that back. I suspect it is not working.
>
> When you said CVS I assumed the one in http://linux-mips/cvsweb/libc.  
> On closer
> look it looks very old.  From discussions in another thread I gather 
> CVS means 
> http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/?cvsroot=glibc. 
> (Correct me
> if this is wrong.) If I take the machine-gmon.h from here - It still 
> has the
> same problem :-(
>
Correction Again:  It works.  I got the machine-gmon.h and builds all 
mixed up.  I did
a fresh compile and it went past this point.

[Sorry for all the confusion.  I will post more carefully in future.]

-Sa.
