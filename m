Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 22:54:43 +0000 (GMT)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:36561 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225218AbUKXWyi>;
	Wed, 24 Nov 2004 22:54:38 +0000
Received: (qmail 5524 invoked by uid 65534); 24 Nov 2004 22:54:32 -0000
Received: from c209182.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.209.182)
  by mail.gmx.net (mp002) with SMTP; 24 Nov 2004 23:54:32 +0100
X-Authenticated: #947741
Message-ID: <41A512A3.8000203@gmx.net>
Date: Thu, 25 Nov 2004 00:00:51 +0100
From: TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Cross tool chain based on gcc-3.4.x
References: <41A3CE25.7040406@gmx.net> <41A46CE6.7040000@enix.org>
In-Reply-To: <41A46CE6.7040000@enix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Thomas Petazzoni wrote:

> Hello,
>
> TheNop a écrit :
>
>> Is anyone using a cross compiler base on  gcc-3.4.x for a mips big 
>> endian target?
>
>
> Yes. Using buildroot (the tool provided by uclibc guys), I 
> successfully generated tool chains for MIPS Big Endian with both Gcc 
> 3.3.x et Gcc 3.4.x. C and C++ programs, dynamically linked with uclibc 
> work fine. However, with Gcc 3.4.x, my version of the Linux MIPS 
> kernel (a more than one month old CVS checkout, heavily tuned for my 
> platform) doesn't compile.
>
> Thomas

Hi Thomas,

I tried the current cvs version of toolchain provide by www.uclibc.org 
without success.
I will try buildroot tomorrow.
Hopefully I have luck than with crosstools.

Best regards
TheNop
