Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 10:08:51 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:54449 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224948AbUJEJIr>; Tue, 5 Oct 2004 10:08:47 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i9594cGG016563;
	Tue, 5 Oct 2004 14:34:39 +0530
Message-ID: <4162634E.3050600@procsys.com>
Date: Tue, 05 Oct 2004 14:33:10 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Daney <ddaney@avtrex.com>
CC: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Unknown ABI problem
References: <4160E489.6010503@procsys.com> <41617816.2000608@avtrex.com>
In-Reply-To: <41617816.2000608@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:

>>What should I do to fix the build?
>>    
>>
>
>get the most recent machine-gmon.h from glibc CVS.
>
>You will probably find a problem linking libc at a later step.  But the
>newer machine-gmon.h will fix this problem.
>  
>
OK. That worked.  Thanks a lot.

(But now there are some assembler errors in rtld.c.  It seems like an 
unrelated
problem - so I will post that seperately.)

>I have sucessfully build with gcc-3.3.1, still working on 3.4.2
>  
>
Ah! Nice to know that. 
Do you by any chance have the diffs (against 
ftp://ftp.gnu.org/glibc/glibc-2.3.3...). 
If so, can you send it to me?

>David Daney.
>  
>
Thanks again,
Saravanan.
