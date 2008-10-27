Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 11:05:48 +0000 (GMT)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:48114 "EHLO
	tyo201.gate.nec.co.jp") by ftp.linux-mips.org with ESMTP
	id S22491578AbYJ0LFj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 11:05:39 +0000
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m9RB5UrJ013801;
	Mon, 27 Oct 2008 20:05:30 +0900 (JST)
Received: from realmbox11.aps.necel.com ([10.29.19.32] [10.29.19.32]) by relay31.aps.necel.com with ESMTP; Mon, 27 Oct 2008 20:05:30 +0900
Received: from [10.114.181.65] ([10.114.181.65] [10.114.181.65]) by mbox02.aps.necel.com with ESMTP; Mon, 27 Oct 2008 20:05:30 +0900
Message-Id: <4905A07A.4040802@necel.com>
Date:	Mon, 27 Oct 2008 20:05:30 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 00/10] Restructure EMMA2RH port
References: <4900A510.3000101@ruby.dti.ne.jp> <20081027104749.GA9554@linux-mips.org>
In-Reply-To: <20081027104749.GA9554@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> And I hope more of the code for the reference platforms to be submitted
> in the future!

Yeah, worth talking with my colleagues.

>> There are a lot of things to do.  For the first step, I'd like to
>> introduce arch/mips/emma/ and include/asm/emma/ directories so that all
>> EMMA related sourches/headers can be easily shared across various EMMA
>> products/ports.
>>
>> Here's the first attempt to try to change things as mentioned above.
>> Some possible improvements and cleanups are also included.  Patches will
>> follow, please review.  Any comments are highly appreciated.
> 
> Full series applied.

I forgot to modify the <asm/emma2rh.h> references from arch/mips/pci/
{ops,pci,fixup}-emma2rh.c sources.  I'll send delta patch soon, please
fold it to previous one.

Anyway, thanks a lot!

-- 
Shinya Kuribayashi
NEC Electronics
