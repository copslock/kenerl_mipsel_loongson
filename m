Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 05:19:42 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:9601 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224843AbUJFETf>; Wed, 6 Oct 2004 05:19:35 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i964FUGG001625;
	Wed, 6 Oct 2004 09:45:31 +0530
Message-ID: <4163710D.8020009@procsys.com>
Date: Wed, 06 Oct 2004 09:44:05 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Daney <ddaney@avtrex.com>
CC: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Unknown ABI problem
References: <4160E489.6010503@procsys.com> <41617816.2000608@avtrex.com> <4162634E.3050600@procsys.com>
In-Reply-To: <4162634E.3050600@procsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

T. P. Saravanan wrote:

> David Daney wrote:
>
>>> What should I do to fix the build?
>>>   
>>
>>
>> get the most recent machine-gmon.h from glibc CVS.
>>
>> You will probably find a problem linking libc at a later step.  But the
>> newer machine-gmon.h will fix this problem.
>>  
>>
> OK. That worked.  Thanks a lot.
>
Oops!  I will take that back. I suspect it is not working.

When you said CVS I assumed the one in http://linux-mips/cvsweb/libc.  
On closer
look it looks very old.  From discussions in another thread I gather CVS 
means http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/?cvsroot=glibc. 
(Correct me
if this is wrong.) If I take the machine-gmon.h from here - It still has 
the
same problem :-(

-Saravanan.
