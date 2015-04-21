Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 03:29:45 +0200 (CEST)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35427 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011972AbbDUB3nr2PUB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 03:29:43 +0200
Received: by wgyo15 with SMTP id o15so197615869wgy.2;
        Mon, 20 Apr 2015 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NBOkp6pBr4ovTACoS9aNqjHHnI5p1gt0BM8C03ZAAqI=;
        b=o2yYx3wCCf/hdWbrkThzLTVfbjaxAl+6g/lCC9lZkbeNGtyZveNYauknxkDGdl07En
         a/BgBw9roxsEXXcFmc4WXd4OcOVSartdVkVSD9z91KkU/WH0/KLGxpsjyAnMrembQg08
         i5ssbPisv6AwsP3L1jCisgo5GrCXA25UbJD2HcBj99WCq8NgLhJ4prdwasgmHQEvEFMp
         rwohfbRqjxqoEXXvkUmfkjG32Duyk9p4opCY3j1S2TlPWCDpMAvmZIrzAOXYkwg4EPi8
         bqrj5KGOgUeQ/m8aWbUJjmBU7qmBUXw09W2Fpnr0QCFUZKqi/dyARiZstqo7uw9EvYEF
         OgUA==
MIME-Version: 1.0
X-Received: by 10.194.174.225 with SMTP id bv1mr36303872wjc.101.1429579780151;
 Mon, 20 Apr 2015 18:29:40 -0700 (PDT)
Received: by 10.28.62.131 with HTTP; Mon, 20 Apr 2015 18:29:40 -0700 (PDT)
In-Reply-To: <20150420184151.GA31618@fuloong-minipc.musicnaut.iki.fi>
References: <1429521179-25758-1-git-send-email-chenhc@lemote.com>
        <20150420184151.GA31618@fuloong-minipc.musicnaut.iki.fi>
Date:   Tue, 21 Apr 2015 09:29:40 +0800
X-Google-Sender-Auth: lSnnoEDBupfcW5wDkyniXSZaHG4
Message-ID: <CAAhV-H4zKQF3w0MjEoD4uND4oqSMn91dmrPHKKZenUDMOzu+Sw@mail.gmail.com>
Subject: Re: [RFC PATCH] MIPS: Loongson: Naming style cleanup and rework
From:   Huacai Chen <chenhc@lemote.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

OK, Thanks.

On Tue, Apr 21, 2015 at 2:41 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Mon, Apr 20, 2015 at 05:12:59PM +0800, Huacai Chen wrote:
>> +config MACH_LOONGSON64
>> +     bool "Loongson-2/3 family of machines"
>>       select SYS_SUPPORTS_ZBOOT
>>       help
>> -       This enables the support of Loongson family of machines.
>> +       This enables the support of Loongson-2/3 family of machines.
>>
>> -       Loongson is a family of general-purpose MIPS-compatible CPUs.
>> -       developed at Institute of Computing Technology (ICT),
>> +       Loongson is a family of 64-bit general-purpose MIPS-compatible
>> +       CPUs. developed at Institute of Computing Technology (ICT),
>               ^
>               ^ This dot should be removed.
>
> Also you should probably say "Loongson-2/3 is a family...".
>
> A.
>
