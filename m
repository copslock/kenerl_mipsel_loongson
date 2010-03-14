Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2010 00:42:10 +0100 (CET)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:54187 "EHLO
        tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492528Ab0CNXmC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Mar 2010 00:42:02 +0100
Received: from relay21.aps.necel.com ([10.29.19.50])
        by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o2ENfpXA000829;
        Mon, 15 Mar 2010 08:41:56 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.32] [10.29.19.32]) by relay21.aps.necel.com with ESMTP; Mon, 15 Mar 2010 08:41:55 +0900
Received: from [10.114.181.193] ([10.114.181.193] [10.114.181.193]) by mbox02.aps.necel.com with ESMTP; Mon, 15 Mar 2010 08:41:55 +0900
Message-ID: <4B9D744A.5080301@necel.com>
Date:   Mon, 15 Mar 2010 08:42:02 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:     wuzhangjin@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, Greg KH <gregkh@suse.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Loongson-2F: Flush the branch target history such
 as BTB and RAS
References: <cover.1268153722.git.wuzhangjin@gmail.com>         <d513f16856e499e82f0b4e428c97fe06afb5a426.1268153722.git.wuzhangjin@gmail.com>         <4B98632E.70806@necel.com>  <20100311095944.GC18065@linux-mips.org> <1268452341.21443.3.camel@falcon>
In-Reply-To: <1268452341.21443.3.camel@falcon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> On Thu, 2010-03-11 at 10:59 +0100, Ralf Baechle wrote:
>> On Thu, Mar 11, 2010 at 12:27:42PM +0900, Shinya Kuribayashi wrote:
>>
>>> Are you sure that RAS represents "Row Address Strobe", not "Return
>>> Address Stack?"
> 
> This should be Return Address Stack.
> 
> Will resend this patch later.

Thanks for the head's up.
-- 
Shinya Kuribayashi
NEC Electronics
