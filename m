Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 17:33:59 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:54033
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224907AbUJKQdx>;
	Mon, 11 Oct 2004 17:33:53 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9BGXlu29840;
	Mon, 11 Oct 2004 09:33:47 -0700
Message-ID: <416AB5DF.70209@embeddedalley.com>
Date: Mon, 11 Oct 2004 09:33:35 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC: macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: PATCH
References: <1097452888.4627.25.camel@localhost.localdomain>	<Pine.LNX.4.58L.0410110126120.4217@blysk.ds.pg.gda.pl>	<4169D818.5020802@embeddedalley.com> <20041011.225341.59463723.anemo@mba.ocn.ne.jp>
In-Reply-To: <20041011.225341.59463723.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
>>>>>>On Sun, 10 Oct 2004 17:47:20 -0700, Pete Popov <ppopov@embeddedalley.com> said:
> 
> 
> ppopov> Clearly a buglet, carried over from 2.4. That section of the
> ppopov> code wouldn't even be compiled, since CONFIG_MIPS64 is not
> ppopov> defined. I'll remove that and send a new patch. Anything else
> ppopov> you see that's suspicious :)?
> 
> Hi.  I wonder why following change is needed.
> 
> 
>>--- include/asm-mips/page.h	20 Aug 2004 12:02:18 -0000	1.44
>>+++ include/asm-mips/page.h	19 Sep 2004 22:51:29 -0000
>>@@ -32,7 +32,7 @@
>> #ifdef CONFIG_PAGE_SIZE_64KB
>> #define PAGE_SHIFT	16
>> #endif
>>-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
>>+#define PAGE_SIZE	(1L << PAGE_SHIFT)
>> #define PAGE_MASK	(~(PAGE_SIZE-1))
>>
>> #ifdef __KERNEL__

It was related to some compiler problem I mentioned to Ralf sometime 
ago. Perhaps it's not needed anymore, I'll take a look.

Pete
