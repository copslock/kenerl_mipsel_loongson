Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 16:22:20 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:43543
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225304AbVIHPWA>;
	Thu, 8 Sep 2005 16:22:00 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Sep 2005 08:29:05 -0700
Message-ID: <432058C1.80106@avtrex.com>
Date:	Thu, 08 Sep 2005 08:29:05 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Matej Kupljen <matej.kupljen@ultra.si>
CC:	crossgcc@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: MIPS SF toolchain
References: <1126098584.12696.19.camel@localhost.localdomain>	 <431F0850.8090804@avtrex.com>	 <1126168866.25388.11.camel@orionlinux.starfleet.com>	 <1126179199.25389.20.camel@orionlinux.starfleet.com> <1126182122.25393.27.camel@orionlinux.starfleet.com>
In-Reply-To: <1126182122.25393.27.camel@orionlinux.starfleet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2005 15:29:05.0691 (UTC) FILETIME=[0C6D66B0:01C5B48A]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Matej Kupljen wrote:
> Hi
> 
> I think I found the problem.
> 
> 
>>-------------------------------------------------------------
>>0002fe80 <__longjmp>:
>>   2fe80:       c4940038        lwc1    $f20,56(a0)
>>   2fe84:       c495003c        lwc1    $f21,60(a0)
> 
> ....
> 
> This code is written in  sysdeps/mips/setjmp_aux.c in 
> inline assembly.
> 
> 
>>and
>>-------------------------------------------------------------
>>0002ff70 <__sigsetjmp_aux>:
>>   2ff70:       3c1c0017        lui     gp,0x17
>>   2ff74:       279cce40        addiu   gp,gp,-12736
> 
> 
> This code is written in sysdeps/mips/__longjmp.c in 
> inline assembly.
> 
> 
>>How to solve this?
> 
> 
> Because I am using sf, there is no need to store those
> registers, or is it?
> Can I just #ifdef this code if compiled for sf?
> 

I do have some patches for glibc to get rid of these in a soft float 
build.  However as Ralf Baechle said in the other message, the kernel FP 
emulator works and is not that large of an overhead.

The reason I did the glibc patch was that some IDT processor/linux 
kernel combination I was using was broken WRT the FP emulator.  I 
suppose if you had a lot of code doing setjump (like C++ code with 
exeception handling that uses setjump/longjump as would be obtained with 
uClibc) than this would be bad.  But since you are using glibc, the 
tools will be using DWARF exception handling and it is not really an issue.

David Daney.
