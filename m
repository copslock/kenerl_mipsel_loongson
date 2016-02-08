Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 22:36:13 +0100 (CET)
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:59215 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012212AbcBHVgLRTY8h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 22:36:11 +0100
Received: from resomta-ch2-09v.sys.comcast.net ([69.252.207.105])
        by resqmta-ch2-07v.sys.comcast.net with comcast
        id Fxbe1s0062GyhjZ01xc4KK; Mon, 08 Feb 2016 21:36:04 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-09v.sys.comcast.net with comcast
        id Fxc21s0040w5D3801xc2jZ; Mon, 08 Feb 2016 21:36:04 +0000
Subject: Re: [PATCH] MIPS: Always page align TASK_SIZE
To:     Harvey Hunt <harvey.hunt@imgtec.com>,
        David Daney <ddaney@caviumnetworks.com>
References: <1454954723-24887-1-git-send-email-harvey.hunt@imgtec.com>
 <56B8DA56.9020108@caviumnetworks.com> <56B8DB2D.3070604@imgtec.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <56B90A3E.7000507@gentoo.org>
Date:   Mon, 8 Feb 2016 16:35:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <56B8DB2D.3070604@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1454967364;
        bh=3xnlm43UOhMj6aLFvAmRBdzDYouYj701kefCAQgOwTw=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=Baddutx0BVpWkaMDWNWHoXmflLJi64TiYK4Eaq4jqU3vClv0cZMOmP1qpFmXJ4biX
         aDnxrQqqpMf1/2TKceBV/ActAR3wpb95ICqbdzSCMMq6PY//vGxWoqpAX/+/xMDQx5
         0fxMT7FcA/ZjD8K7lVGsIo7gCiwiw9BVj6Q8lZgVQWXvSaxsSTHDx9lprxUKlQLgJK
         hPMA4kkOcyaRbKYsSP25j3S4sii7q2tAMbLcf1XQUNZLJyVPg/exgv0Bsm6SCyKKaI
         4TozmiIPny2WGUmccINCehhxwwt1iIwMXGKYIG9CLz9eOajF0biA8SX1JL+R+18XpY
         JTBbsw/EkteDQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 02/08/2016 13:15, Harvey Hunt wrote:
> Hi David,
> 
> On 02/08/2016 10:11 AM, David Daney wrote:
>> On 02/08/2016 10:05 AM, Harvey Hunt wrote:
>>> STACK_TOP_MAX is aligned on a 32k boundary. When __bprm_mm_init()
>>> creates an
>>> initial stack for a process, it does so using STACK_TOP_MAX as the end
>>> of the
>>> vma. A process's arguments and environment information are placed on
>>> the stack
>>> and then the stack is relocated and aligned on a page boundary. When
>>> using a 32
>>> bit kernel with 64k pages, the relocated stack has the process's args
>>> erroneously stored in the middle of the stack. This means that processes
>>> receive no arguments or environment variables, preventing them from
>>> running
>>> correctly.
>>>
>>> Fix this by aligning TASK_SIZE on a page boundary.
>>>
>>> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
>>> Cc: David Daney <david.daney@cavium.com>
>>> Cc: Paul Burton <paul.burton@imgtec.com>
>>> Cc: James Hogan <james.hogan@imgtec.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>   arch/mips/include/asm/processor.h | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/processor.h
>>> b/arch/mips/include/asm/processor.h
>>> index 3f832c3..b618b40 100644
>>> --- a/arch/mips/include/asm/processor.h
>>> +++ b/arch/mips/include/asm/processor.h
>>> @@ -39,13 +39,13 @@ extern unsigned int vced_count, vcei_count;
>>>   #ifdef CONFIG_32BIT
>>>   #ifdef CONFIG_KVM_GUEST
>>>   /* User space process size is limited to 1GB in KVM Guest Mode */
>>> -#define TASK_SIZE    0x3fff8000UL
>>> +#define TASK_SIZE    (0x40000000UL - PAGE_SIZE)
>>>   #else
>>>   /*
>>>    * User space process size: 2GB. This is hardcoded into a few places,
>>>    * so don't change it unless you know what you are doing.
>>>    */
>>> -#define TASK_SIZE    0x7fff8000UL
>>> +#define TASK_SIZE    (0x7fff8000UL & PAGE_SIZE)
>>
>> Can you check your math here.  This doesn't seem correct.
> 
> Thanks for spotting that - it should have been:
> 
> (0x7fff8000UL & PAGE_MASK)
> 
> I'll do a v2 now.
> 

FYI, TASK_SIZE was recently changed to 0x80000000UL in commit 7f8ca9cb1ed3 on
the linux-mips.org tree.


>>
>>>   #endif
>>>
>>>   #define STACK_TOP_MAX    TASK_SIZE
>>> @@ -62,7 +62,7 @@ extern unsigned int vced_count, vcei_count;
>>>    * support 16TB; the architectural reserve for future expansion is
>>>    * 8192EB ...
>>>    */
>>> -#define TASK_SIZE32    0x7fff8000UL
>>> +#define TASK_SIZE32    (0x7fff8000UL & PAGE_SIZE)
>>
>> Same here.
> 
> As above.
> 
>>
>>>   #define TASK_SIZE64    0x10000000000UL
>>>   #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 :
>>> TASK_SIZE64)
>>>   #define STACK_TOP_MAX    TASK_SIZE64
>>>
>>
> 
> Thanks,
> 
> Harvey
> 
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
