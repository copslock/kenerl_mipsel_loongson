Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2011 11:15:55 +0100 (CET)
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:44310 "HELO
        oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1490992Ab1A1KPu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jan 2011 11:15:50 +0100
Received: (qmail 22775 invoked by uid 0); 28 Jan 2011 10:15:46 -0000
Received: from unknown (HELO box585.bluehost.com) (66.147.242.185)
  by oproxy1.bluehost.com.bluehost.com with SMTP; 28 Jan 2011 10:15:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=coly.li;
        h=Received:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Identified-User;
        b=EjQul+hhk9FsQdsoBpjtwSn5boF6GhRRmHf0P3cgK5OtNAxYRqUSOVOGpxUiv41xASt3AKVFzqDxI5fCe2iBSao1H0QBEzOXdY5GCnRl8J7+c9DIl1ovN94xMy9NYrCU;
Received: from [114.251.86.0] (helo=[10.32.22.146])
        by box585.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <i@coly.li>)
        id 1PilMn-0006s9-Lv; Fri, 28 Jan 2011 03:15:45 -0700
Message-ID: <4D429D65.3020000@coly.li>
Date:   Fri, 28 Jan 2011 18:41:41 +0800
From:   Coly Li <i@coly.li>
Reply-To: i@coly.li
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; zh-CN; rv:1.9.2.13) Gecko/20101206 SUSE/3.1.7 Thunderbird/3.1.7
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Coly Li <bosong.ly@taobao.com>, linux-kernel@vger.kernel.org,
        Wang Cong <xiyou.wangcong@gmail.com>,
        Yong Zhang <yong.zhang0@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/7] MIPS: add unlikely() to BUG_ON()
References: <1296130356-29896-1-git-send-email-bosong.ly@taobao.com> <1296130356-29896-2-git-send-email-bosong.ly@taobao.com> <4D41B06F.8070804@caviumnetworks.com>
In-Reply-To: <4D41B06F.8070804@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Identified-User: {1390:box585.bluehost.com:colyli:coly.li} {sentby:smtp auth 114.251.86.0 authed with i@coly.li}
Return-Path: <i@coly.li>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: i@coly.li
Precedence: bulk
X-list: linux-mips

On 2011年01月28日 01:50, David Daney Wrote:
> Please Cc: linux-mips@linux-mips.org for MIPS patches.
>
> On 01/27/2011 04:12 AM, Coly Li wrote:
>> Current BUG_ON() in arch/mips/include/asm/bug.h does not use unlikely(),
>> in order to get better branch predict result, source code should call
>> BUG_ON() with unlikely() explicitly. This is not a suggested method to
>> use BUG_ON().
>>
>> This patch adds unlikely() inside BUG_ON implementation on MIPS code,
>> callers can use BUG_ON without explicit unlikely() now.
>>
>> I have no usable MIPS hardware to build and test the fix, any test result
>> of this patch is welcome.
>>
>> Signed-off-by: Coly Li<bosong.ly@taobao.com>
>> Cc: David Daney<ddaney@caviumnetworks.com>
>> Cc: Wang Cong<xiyou.wangcong@gmail.com>
>> Cc: Yong Zhang<yong.zhang0@gmail.com>
>> ---
>> arch/mips/include/asm/bug.h | 2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
>> index 540c98a..6771c07 100644
>> --- a/arch/mips/include/asm/bug.h
>> +++ b/arch/mips/include/asm/bug.h
>> @@ -30,7 +30,7 @@ static inline void __BUG_ON(unsigned long condition)
>> : : "r" (condition), "i" (BRK_BUG));
>> }
>>
>> -#define BUG_ON(C) __BUG_ON((unsigned long)(C))
>> +#define BUG_ON(C) __BUG_ON((unsigned long)unlikely(C))
>>
>
> NAK.
>
> __BUG_ON() expands to a single instruction. Frobbing about with unlikely() will have no effect on the generated code and
> is thus gratuitous code churn.
>

Since unlikely() in arch implemented BUG_ON() is gratuitous, using unlikely() in kernel code like BUG_ON(unlikely(...)) 
for arch implemented BUG_ON is unwelcome neither.

The NAK makes sense, thanks for your reply.

Coly

-- 
Coly Li
