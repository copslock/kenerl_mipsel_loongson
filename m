Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 19:04:30 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:15634
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224907AbUJKSE0>;
	Mon, 11 Oct 2004 19:04:26 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9BI4Ku30704;
	Mon, 11 Oct 2004 11:04:20 -0700
Message-ID: <416ACB15.3050201@embeddedalley.com>
Date: Mon, 11 Oct 2004 11:04:05 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Popov <ppopov@embeddedalley.com>
CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: PATCH
References: <1097452888.4627.25.camel@localhost.localdomain>	<Pine.LNX.4.58L.0410110126120.4217@blysk.ds.pg.gda.pl>	<4169D818.5020802@embeddedalley.com> <20041011.225341.59463723.anemo@mba.ocn.ne.jp> <416AB5DF.70209@embeddedalley.com>
In-Reply-To: <416AB5DF.70209@embeddedalley.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
> Atsushi Nemoto wrote:
> 
>>>>>>> On Sun, 10 Oct 2004 17:47:20 -0700, Pete Popov 
>>>>>>> <ppopov@embeddedalley.com> said:
>>
>>
>>
>> ppopov> Clearly a buglet, carried over from 2.4. That section of the
>> ppopov> code wouldn't even be compiled, since CONFIG_MIPS64 is not
>> ppopov> defined. I'll remove that and send a new patch. Anything else
>> ppopov> you see that's suspicious :)?
>>
>> Hi.  I wonder why following change is needed.
>>
>>
>>> --- include/asm-mips/page.h    20 Aug 2004 12:02:18 -0000    1.44
>>> +++ include/asm-mips/page.h    19 Sep 2004 22:51:29 -0000
>>> @@ -32,7 +32,7 @@
>>> #ifdef CONFIG_PAGE_SIZE_64KB
>>> #define PAGE_SHIFT    16
>>> #endif
>>> -#define PAGE_SIZE    (1UL << PAGE_SHIFT)
>>> +#define PAGE_SIZE    (1L << PAGE_SHIFT)
>>> #define PAGE_MASK    (~(PAGE_SIZE-1))
>>>
>>> #ifdef __KERNEL__
> 
> 
> It was related to some compiler problem I mentioned to Ralf sometime 
> ago. Perhaps it's not needed anymore, I'll take a look.

Turns out the problem is with the #define PAGE_MASK, when (1UL << 
PAGE_SHIFT) is used for PAGE_SIZE. The correct fix is already in the PPC 
tree and it doesn't use PAGE_SIZE to define PAGE_MASK. From the PPC tree:

/*
  * Subtle: this is an int (not an unsigned long) and so it
  * gets extended to 64 bits the way [we] want (i.e. with 1s).  -- paulus
  */
#define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))

I updated the patch and put a new version in my directory (v1.3).  The 
diff is:

-#define PAGE_MASK      (~(PAGE_SIZE-1))
+#define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))

I'll work on the remap_pfn_range after those bits get to kernel.org. 
That will clean up the patch nicely.

Pete
