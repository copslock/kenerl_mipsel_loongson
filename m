Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 03:13:04 +0200 (CEST)
Received: from smtpbg63.qq.com ([103.7.29.150]:39110 "EHLO smtpbg63.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006537AbaHZBNDJKn8I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 03:13:03 +0200
X-QQ-mid: bizesmtp5t1409015565t488t080
Received: from mail-ie0-f182.google.com (unknown [209.85.223.182])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 26 Aug 2014 09:12:43 +0800 (CST)
X-QQ-SSF: 01100000002000F0FF22B00A0000000
X-QQ-FEAT: aQc48XEnDWvHv1yzZsel+07js9ftwvxliyoSbUsfFR6Yk77TRNhQS+hM7kiV1
        dsi6sCuJ6QL1OMwzTBIl74Q3J25gWWxInHkn1Sn8Y5/jm5g2VjoNaU7TDusGTxCcuj9Kl8b
        KC7PA6gu7BHUu+e1vwfXGqHne6I6OaORZc4eUdIfh7LsqaqmKu3b3qZSaMZnX4tkuLugFbE
        =
X-QQ-GoodBg: 0
Received: by mail-ie0-f182.google.com with SMTP id y20so10760035ier.41
        for <multiple recipients>; Mon, 25 Aug 2014 18:12:42 -0700 (PDT)
X-Received: by 10.50.128.46 with SMTP id nl14mr19208792igb.48.1409015562517;
 Mon, 25 Aug 2014 18:12:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.201 with HTTP; Mon, 25 Aug 2014 18:12:22 -0700 (PDT)
In-Reply-To: <20140825194154.GC27238@linux-mips.org>
References: <1408504488-12319-1-git-send-email-chenj@lemote.com>
 <1408504488-12319-2-git-send-email-chenj@lemote.com> <20140820105356.GA21497@linux-mips.org>
 <CAGXxSxVqEs5jyckaOG=iX24UeV2P_WgmqV=EBQYycRJ1P9vPgg@mail.gmail.com>
 <20140825121240.GG27724@linux-mips.org> <alpine.LFD.2.11.1408252028580.18483@eddie.linux-mips.org>
 <20140825194154.GC27238@linux-mips.org>
From:   Chen Jie <chenj@lemote.com>
Date:   Tue, 26 Aug 2014 09:12:22 +0800
Message-ID: <CAGXxSxUZ=ds9K5UE41Q5R9qwOJjQJrVZnBUd7byvFFO+33eH8w@mail.gmail.com>
Subject: Re: [PATCH] mips: define _MIPS_ARCH_LOONGSON3A for Loongson3
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-QQ-SENDSIZE: 520
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42241
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

Hi Ralf,

2014-08-26 3:41 GMT+08:00 Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Aug 25, 2014 at 08:35:17PM +0100, Maciej W. Rozycki wrote:
>
>> On Mon, 25 Aug 2014, Ralf Baechle wrote:
>>
>> > > >> +cflags-$(CONFIG_CPU_LOONGSON3)  += -D_MIPS_ARCH_LOONGSON3A
>> > > >
>> > > > The _MIPS_ARCH_* namespace belongs to GCC.  While it seems current GCC
>> > > > does not define this symbol _MIPS_ARCH_LOONGSON3A runs into the danger
>> > > > of causing a conflict when GCC eventually will define the symbol.
>> > > When this symbol will be defined? With option '-march=loongson3a'?
>> >
>> > Well, not currently (at least not in my gcc 4.9.0) - but it might.  In
>> > fact, I'm wondering why it doesn't.  Maciej?
>>
>>  No idea, a _MIPS_ARCH_foo macro gets defined automagically by GCC
>> whenever `-march=foo' is in effect (be it implicitly or with the use of a
>> command-line option), so there should be one.
>>
>>  Has support for "loongson3a" been present in 4.9.x (it is in trunk)?  If
>> so, then what _MIPS_ARCH_* macro gets defined for `-march=loongson3a'?
>
> Hmm - I must have fatfingered something.  Now I'm getting:
>
> $ mips-linux-gcc < /dev/null -E -C -dM -march=loongson3a - | grep _MIPS_ARCH
> #define _MIPS_ARCH_LOONGSON3A 1
> #define _MIPS_ARCH "loongson3a"
> $
>
> So that would conflict with a manual definition, thus the patch would not
> be acceptable as it because:
>
> $ cat > c.c << EOF
> foo(){}
> EOF
> $ mips-linux-gcc -D_MIPS_ARCH_LOONGSON3A -march=loongson3a -Wall -c c.c
> c.c:1:1: warning: return type defaults to ‘int’ [-Wreturn-type]
>  foo(){}
>  ^
> c.c: In function ‘foo’:
> c.c:1:1: warning: control reaches end of non-void function [-Wreturn-type]
>  foo(){}
>  ^
> $
Thanks for the explanation. We will enable "-march=loongson3a" and do
some test internally to make sure doing so wouldn't cause any
problems.

To James:
> Any reason not to just refer directly to CONFIG_CPU_LOONGSON3 from the
> source rather than adding an intermediate definition?
>
> Cheers
> James

I guess it's because "arch/mips/include/uapi/asm/swab.h" is in "uapi/"
directory(http://lwn.net/Articles/507794/), that means it contains
"user-space API-related definitions", hence using CONFIG_CPU_LOONGSON3
is not suitable there.
