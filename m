Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 01:47:36 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:19469
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8225255AbUJKArc>;
	Mon, 11 Oct 2004 01:47:32 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9B0lSu18986;
	Sun, 10 Oct 2004 17:47:29 -0700
Message-ID: <4169D818.5020802@embeddedalley.com>
Date: Sun, 10 Oct 2004 17:47:20 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
References: <1097452888.4627.25.camel@localhost.localdomain> <Pine.LNX.4.58L.0410110126120.4217@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0410110126120.4217@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 10 Oct 2004, Pete Popov wrote:
> 
> 
>>diff -u -r1.13 addrspace.h
>>--- include/asm-mips/addrspace.h	30 Nov 2003 01:52:25 -0000	1.13
>>+++ include/asm-mips/addrspace.h	19 Sep 2004 22:51:28 -0000
>>@@ -80,7 +80,11 @@
>> #define XKSSEG			0x4000000000000000
>> #define XKPHYS			0x8000000000000000
>> #define XKSEG			0xc000000000000000
>>+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
>>+#define CKSEG0			0x80000000
>>+#else
>> #define CKSEG0			0xffffffff80000000
>>+#endif
>> #define CKSEG1			0xffffffffa0000000
>> #define CKSSEG			0xffffffffc0000000
>> #define CKSEG3			0xffffffffe0000000
> 
> 
>  This looks suspicious, please explain.

Clearly a buglet, carried over from 2.4. That section of the code 
wouldn't even be compiled, since CONFIG_MIPS64 is not defined. I'll 
remove that and send a new patch. Anything else you see that's 
suspicious :)?

Pete
