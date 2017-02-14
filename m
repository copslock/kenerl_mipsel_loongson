Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 20:46:50 +0100 (CET)
Received: from resqmta-ch2-08v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:40]:53864
        "EHLO resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993866AbdBNTqmsqbGk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 20:46:42 +0100
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-08v.sys.comcast.net with SMTP
        id dj3McHoCxy4bMdj3hcZcuC; Tue, 14 Feb 2017 19:46:41 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-16v.sys.comcast.net with SMTP
        id dj3ec78A6KnqCdj3fcRHxg; Tue, 14 Feb 2017 19:46:41 +0000
Subject: Re: [PATCH 2/3] MIPS: Xtalk: Clean-up xtalk.h macros
To:     James Hogan <james.hogan@imgtec.com>
References: <20170207055751.8134-1-kumba@gentoo.org>
 <20170207055751.8134-3-kumba@gentoo.org>
 <20170214131632.GU24226@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <12fc37ba-8888-34c9-df84-9653da2bba18@gentoo.org>
Date:   Tue, 14 Feb 2017 14:46:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170214131632.GU24226@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOcdmwqQ2QfKntUtT1X7ADrObYGrocHwAGrJ5CEnneLhP+0elNfWt4fGDdSTSbDDgHZubWr4OkprAzCHJ4A09QnaRzbhGNBnVT25x3RZUwDodECJMwcL
 0UXd30nGDle6txsEcmBqFjYlWRtv5qQtac0AdkGGY0daZ5DrswTtsc/tU5XkhCSxax8enB1fxcpB93e8SSsr63hccFIl1pBdUEP/JpAVF2d9k6k2iyZ9i77W
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56819
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

On 02/14/2017 08:16, James Hogan wrote:
> Hi Joshua,
> 
> On Tue, Feb 07, 2017 at 12:57:50AM -0500, Joshua Kinard wrote:
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> Clean-up several macros in arch/mips/include/asm/xtalk/xtalk.h:
>>  - Hex addresses are lowercased.
>>  - Added whitespace around several operators.
>>  - Removed bridge_probe declaration.
>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> ---
>>  arch/mips/include/asm/xtalk/xtalk.h | 23 +++++++----------------
>>  1 file changed, 7 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/xtalk/xtalk.h b/arch/mips/include/asm/xtalk/xtalk.h
>> index 9125bd85514d..627ed91b2880 100644
>> --- a/arch/mips/include/asm/xtalk/xtalk.h
>> +++ b/arch/mips/include/asm/xtalk/xtalk.h
>> @@ -21,24 +21,15 @@
>>  #define XWIDGET_MFG_NUM_NONE	-1
>>  
>>  /* It is often convenient to fold the XIO target port */
>> -#define XIO_NOWHERE	(0xFFFFFFFFFFFFFFFFull)
>> -#define XIO_ADDR_BITS	(0x0000FFFFFFFFFFFFull)
>> -#define XIO_PORT_BITS	(0xF000000000000000ull)
>> +#define XIO_NOWHERE	(0xffffffffffffffffULL)
>> +#define XIO_ADDR_BITS	(0x0000ffffffffffffULL)
>> +#define XIO_PORT_BITS	(0xf000000000000000ULL)
>>  #define XIO_PORT_SHIFT	(60)
>>  
>> -#define XIO_PACKED(x)	(((x)&XIO_PORT_BITS) != 0)
>> -#define XIO_ADDR(x)	((x)&XIO_ADDR_BITS)
>> -#define XIO_PORT(x)	((s8)(((x)&XIO_PORT_BITS) >> XIO_PORT_SHIFT))
>> -#define XIO_PACK(p, o)	((((uint64_t)(p))<<XIO_PORT_SHIFT) | ((o)&XIO_ADDR_BITS))
>> -
>> -#ifdef CONFIG_PCI
>> -extern int bridge_probe(nasid_t nasid, int widget, int masterwid);
>> -#else
>> -static inline int bridge_probe(nasid_t nasid, int widget, int masterwid)
>> -{
>> -	return 0;
>> -}
>> -#endif
> 
> Won't this break the build when CONFIG_PCI=n?
> 
> Cheers
> James

It might, though I believe my BRIDGE updates addressed that.  Though, these
machines are pretty unusable without PCI anyways.

Hold on these patches for now (same for the BRIDGE series).  I need to re-spin
them once I tackle fixing the PCI Bridge window bits this weekend.  I think
I'll make the window selection a platform_data parameter and have a built-in
default for small windows, since those are usually fixed by hardware, with each
BRIDGE-capable platform passing in its own big window range.

Then, IP27 is going to require porting additional code from Linux-2.5.70/IA64
to get its big windows to work...

--J
