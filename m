Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2014 05:12:09 +0200 (CEST)
Received: from smtpbg298.qq.com ([184.105.67.102]:41403 "EHLO smtpbg298.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6842384AbaHTDMGgsNNq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Aug 2014 05:12:06 +0200
X-QQ-mid: bizesmtp5t1408504310t868t267
Received: from mail-qa0-f51.google.com (unknown [209.85.216.51])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 20 Aug 2014 11:11:49 +0800 (CST)
X-QQ-SSF: 01100000002000F0FF22B00A0000000
X-QQ-FEAT: hUz2QKAUQ1MxgoX1B6HWlBUzJDlYkwLmqxeTA3wTgVmevGzd5cSwvWi0Ayk0a
        zworog2nqd9M5rhX68CInZ8lW+Vs0EcfyXdwzZ4ritw1lh6WZ+mnB+2olG1wmLvWleYB9DE
        ddaJhZ8789efE01BzuJIqT96wbXaNtwy5bjiyaJbXC06TlGLkj1s8jl8lb1CuW9wXDXYiYW
        YPHI97eH+Tg==
X-QQ-GoodBg: 0
Received: by mail-qa0-f51.google.com with SMTP id k15so6393585qaq.38
        for <multiple recipients>; Tue, 19 Aug 2014 20:11:48 -0700 (PDT)
X-Received: by 10.140.22.137 with SMTP id 9mr70161356qgn.4.1408504307987; Tue,
 19 Aug 2014 20:11:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.96.118.97 with HTTP; Tue, 19 Aug 2014 20:11:27 -0700 (PDT)
In-Reply-To: <53F3DC11.1080208@gmail.com>
References: <CAGXxSxXGpRBJm+8sYfYXN4-20OYdmJ4FgBDnPknv9uMBN9zBsQ@mail.gmail.com>
 <1408093018-25436-1-git-send-email-chenj@lemote.com> <53F3DC11.1080208@gmail.com>
From:   Chen Jie <chenj@lemote.com>
Date:   Wed, 20 Aug 2014 11:11:27 +0800
Message-ID: <CAGXxSxV7RCoGUVyn7-n2PLyrODSFOF6JWQjnZUEVWe0qQSDM0A@mail.gmail.com>
Subject: Re: [v2] mips: use wsbh/dsbh/dshd on Loongson 3A
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
X-QQ-SENDSIZE: 520
X-QQ-FName: 827494A6980B491A891A0421D3B53854
X-QQ-LocalIP: 58.250.132.20
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42157
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

2014-08-20 7:21 GMT+08:00 David Daney <ddaney.cavm@gmail.com>:
> On 08/15/2014 01:56 AM, chenj wrote:
>>
>> Signed-off-by: chenj <chenj@lemote.com>
>> ---
>> This patch is modified from http://patchwork.linux-mips.org/patch/7054/
>> The original author is ralf.
>>
>> v2: using "#if defined(CONFIG_CPU_MIPSR2) ||
>> defined(CONFIG_CPU_LOONGSON3)"
>> instead of "#if cpu_has_wsbh" in csum_partial.S
>>
>>   arch/mips/include/asm/cpu-features.h                       | 10
>> ++++++++++
>>   .../include/asm/mach-cavium-octeon/cpu-feature-overrides.h |  1 +
>>   .../mips/include/asm/mach-loongson/cpu-feature-overrides.h |  2 ++
>>   arch/mips/include/uapi/asm/swab.h                          | 14
>> ++++++++++++--
>>   arch/mips/lib/csum_partial.S                               | 10
>> ++++++++--
>>   arch/mips/net/bpf_jit.c                                    |  2 +-
>>   6 files changed, 34 insertions(+), 5 deletions(-)
>>
> [...]
>
>> diff --git a/arch/mips/include/uapi/asm/swab.h
>> b/arch/mips/include/uapi/asm/swab.h
>> index ac9a8f9..20b884a 100644
>> --- a/arch/mips/include/uapi/asm/swab.h
>> +++ b/arch/mips/include/uapi/asm/swab.h
>
> [...]
>
>> @@ -46,8 +53,11 @@ static inline __attribute_const__ __u32
>> __arch_swab32(__u32 x)
>>   static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
>>   {
>>         __asm__(
>> +       "       .set    push                    \n"
>> +       "       .set    arch=mips64r2           \n"
>>         "       dsbh    %0, %1\n"
>>         "       dshd    %0, %0"
>> +       "       .set    pop                     \n"
>>         : "=r" (x)
>>         : "r" (x));
>>
>
> This section of the patch is defective.  It appears to have not been compile
> tested.
>
> On mips-for-linux-next commit d4c5edf76f14720a32805202129dfa8206560035
> produces:
Really sorry for that, I've submitted a patch for this:
http://patchwork.linux-mips.org/patch/7550/
