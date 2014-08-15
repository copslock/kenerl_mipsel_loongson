Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2014 22:16:09 +0200 (CEST)
Received: from ec2-54-194-5-104.eu-west-1.compute.amazonaws.com ([54.194.5.104]:51636
        "EHLO smtpbgie2.qq.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855189AbaHOUQAx2cVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2014 22:16:00 +0200
X-QQ-mid: bizesmtp7t1408133746t174t203
Received: from mail-ig0-f178.google.com (unknown [209.85.213.178])
        by esmtp4.qq.com (ESMTP) with SMTP id 0
        for <linux-mips@linux-mips.org>; Sat, 16 Aug 2014 04:15:44 +0800 (CST)
X-QQ-SSF: 01100000002000F0FF22B00A0000000
X-QQ-FEAT: Ay4iuitErgnyEvtQ0ZFis94y9Xe7x5aEBq4fmgdMJkusuR7DXle3GOGQrSZVQ
        tslRA8FMRZV4Gp3Wh04DV6XhMtTkyk/h7d9tRVNfKUH1ab8xDEo0G1KoTW1mOzUz51PIskA
        FuL/vxb6TyUc2H3ZEn48AA0Pu9GoxD1iC1uGYeoWdItOy4OrlK/0BT3Dx/0GqjR7v7q72es
        =
X-QQ-GoodBg: 0
Received: by mail-ig0-f178.google.com with SMTP id uq10so2825529igb.17
        for <linux-mips@linux-mips.org>; Fri, 15 Aug 2014 13:15:43 -0700 (PDT)
X-Received: by 10.43.63.134 with SMTP id xe6mr428836icb.97.1408133743897; Fri,
 15 Aug 2014 13:15:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.42.198 with HTTP; Fri, 15 Aug 2014 13:15:23 -0700 (PDT)
In-Reply-To: <CAGXxSxUBej1hTzDWmf1tz=vST1Z1gXvzagO3B+4wWhuVX4Q5_w@mail.gmail.com>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400469247-17788-1-git-send-email-chenj@lemote.com> <1818781.bbVdBBlkH9@radagast>
 <CAGXxSxUBej1hTzDWmf1tz=vST1Z1gXvzagO3B+4wWhuVX4Q5_w@mail.gmail.com>
From:   Chen Jie <chenj@lemote.com>
Date:   Sat, 16 Aug 2014 04:15:23 +0800
Message-ID: <CAGXxSxWxRYC_84A_kMsXZ_Hc1KMVDcrXQp62MoqPhhthc26mdg@mail.gmail.com>
Subject: Re: [PATCH, v2] MIPS: lib: csum_partial: more instruction paral
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        markos.chandras@imgtec.com,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

2014-05-19 23:32 GMT+08:00 Chen Jie <chenj@lemote.com>:
> 2014-05-19 14:59 GMT+08:00 James Hogan <james.hogan@imgtec.com>:
>> On Monday 19 May 2014 11:14:07 chenj wrote:
>>> Computing sum introduces true data dependency, e.g.
>>>       ADDC(sum, t0)
>>>       ADDC(sum, t1)
>>>       ADDC(sum, t2)
>>>       ADDC(sum, t3)
>>> Here, each ADDC(sum, ...) references the sum value updated by previous ADDC.
>>>
>>> In this patch, above sequence is adjusted as following:
>>>       ADDC(t0, t1)
>>>       ADDC(t2, t3)
>>>       ADDC(sum, t0)
>>>       ADDC(sum, t2)
>>> The first two ADDC operations are independent, hence can be executed
>>> simultaneously if possible.
>>
>> The actual patch appears to change it to this:
>> ADDC(t0, t1)
>> ADDC(sum, t0)
>> ADDC(t2, t3)
>> ADDC(sum, t2)
>>
>> which is slightly different (presumably due to the interleaved stores in some
>> of the cases).
>>
>>> This patch improves instruction level parallelism, and brings at most 50%
>>> csum performance gain on Loongson 3a processor[1].
>>
>> Nice results.
>>
>> The stuff below the --- will get dropped when the patch is applied though,
>> after which the "[1]" won't refer to anything.
>>
> Thanks for your suggestion, I'll amend the commit message further later.
>
> Basically, the patch reduces the case of one ADDC depending on the
> result of the previous ADDC.
>
> BTW, I'm not sure whether the sum value of the new implementation is
> equivalent to the original one, but in my test(make run_test of the
> csum_test.tar.gz, and a comparing patch in kernel) it is.

It is equivalent to the original one.
More explanation about the math behind "x ADDC y ADDC z == x ADDC (y ADDC z)":

Let C = the value of '(uint64_t) -1 + 1' in 64bit case, then
0 <= x <= C-1
0 <= y <= C-1
0 <= z <= C-1

Here 'x ADDC y' is defined as
x + y >= C ? x + y - C + 1 : x + y


Case 1: x + y >= C && x + y - C + 1 + z < C (i.e. x ADDC y ADDC z = x
+ y - C +1 + z)
if y + z >= C:
=> y ADDC z = y + z - C + 1
C > x + y + z - C + 1
=> The result is x + y + z - C + 1

if y + z < C:
=> y ADDC z = y + z
x + y >= C
=> x + (y + z) >= C + z >= C
=> The result is x + y + z - C + 1

Case 2: x + y < C && x + y + z >= C (i.e. x ADDC y ADDC z = x + y + z - C + 1)
if y + z >= C:
=> y ADDC z = y + z - C + 1
C > x + y
=> C + z - C + 1 > x + y + z - C + 1
=> z + 1 > x + y + z - C + 1
=> C >= z + 1 > x + y + z - C + 1
=> The result is x + y + z - C + 1

if y + z < C:
=> y ADDC z = y + z
x + y + z >= C
=> The result is x + y + z - C + 1

Case 3: x + y >= C && x + y - C + 1 + z >= C (i.e. x ADDC y ADDC z = x
+ y + z - 2C + 2)
x + y - C + 1 + z >= C
=> y + z >= 2C - 1 - x
C >= 1 + x
=> 2C - 1 - x >= C
=> y + z >= C
=> y ADDC z = y + z - C + 1

x + y - C + 1 + z >= C
=> The result is  x + y + z - 2C + 2


Case 4: x + y < C && x + y + z < C (i.e. x ADDC y ADDC z = x + y + z)
x + y + z < C
=> y + z < C - x <= C
=> y + z < C
=> y ADDC z = y + z

x + y + z < C
=> The result is x + y + z
