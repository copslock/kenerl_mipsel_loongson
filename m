Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 05:32:20 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:17364 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224990AbUJGEcI>; Thu, 7 Oct 2004 05:32:08 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i974S4GG025673;
	Thu, 7 Oct 2004 09:58:04 +0530
Message-ID: <4164C584.60801@procsys.com>
Date: Thu, 07 Oct 2004 09:56:44 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Assembler errors in rtld.c
References: <41626E7D.2070405@procsys.com> <20041005.191608.59649656.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20041005.191608.59649656.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:

>>>>>>On Tue, 05 Oct 2004 15:20:53 +0530, "T. P. Saravanan" <sara@procsys.com> said:
>>>>>>            
>>>>>>
>sara> glibc-2.2.3 build on mips linux breaks with following assembler errors:
>...
>sara> /tmp/ccNhjRu0.s: Assembler messages:
>sara> /tmp/ccNhjRu0.s:48: Warning: missing .end
>sara> /tmp/ccNhjRu0.s:80: Warning: No .frame pseudo-op used in PIC code
>sara> /tmp/ccNhjRu0.s:88: Warning: .end directive without a preceding .ent 
>
>This is now fixed in libc CVS.
>
>http://sources.redhat.com/ml/libc-alpha/2004-04/msg00078.html
>
>Also, you might have to pass -fno-unit-at-a-time to gcc 3.4.  (at
>least glibc 2.3.2 requires it).
>
>  
>
I merged the patch int the URL you gave.  It worked.  Thanks.

(But now I am getting a linker error.  I will post it seperately.)

-Sa.
