Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2004 07:24:40 +0100 (BST)
Received: from bay1-f120.bay1.hotmail.com ([IPv6:::ffff:65.54.245.120]:9491
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225533AbUEOGYj>; Sat, 15 May 2004 07:24:39 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 14 May 2004 23:24:30 -0700
Received: from 165.247.221.201 by by1fd.bay1.hotmail.msn.com with HTTP;
	Sat, 15 May 2004 06:24:30 GMT
X-Originating-IP: [165.247.221.201]
X-Originating-Email: [michaelanburaj@hotmail.com]
X-Sender: michaelanburaj@hotmail.com
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board -problems :(
Date: Fri, 14 May 2004 23:24:30 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F1209xwPbLz9y300017c46@hotmail.com>
X-OriginalArrivalTime: 15 May 2004 06:24:30.0720 (UTC) FILETIME=[47EEC000:01C43A45]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I have requirement in my project where I have to specify an object file 
contained in a library file in my linker script.

Something like this:

MySection 0x1000 :
{
      myobj.o of mylib.a (.bss, COMMON)
}

In ADS scatter map its enough to specify just the object files name. And the 
linker would pull it from the linked-in libraries. I tried the same with GCC 
(with it,s linker script), something like this,

ZeroISection 0x1000 :
{
      myobj.o (.bss, COMMON)
}

Does not work. Even thought the linker was supplied with mylib.a, which 
contains myobj.o; it still gives errors “myobj.o not found”.


Please help me with this.

Thanks a lot,
-Mike.
