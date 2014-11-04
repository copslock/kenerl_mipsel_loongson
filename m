Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 15:54:12 +0100 (CET)
Received: from mail-oi0-f44.google.com ([209.85.218.44]:51610 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012586AbaKDOyGhF279 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Nov 2014 15:54:06 +0100
Received: by mail-oi0-f44.google.com with SMTP id h136so10491465oig.31
        for <linux-mips@linux-mips.org>; Tue, 04 Nov 2014 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=n//8ndg/XxEfsunuG4JmN+nyDyn4gJUn+/Xkgz3Tm2U=;
        b=isbR70wuWJ0dqQxLEkLfaXFTZhTEnUnh7tbeVGOeIEZUV4Hu1H/8l9lggmoWLaD6jo
         zgbG0Jb7Ew1fL1itKyvkKXOfx/2pEjTMhrEAlMW+7SjqBowHoTqbyQPdC2EAiFGwf/ua
         w4hC/rAsH4R4NPs+KaBhkMkn0cLms/yBKPZJkv33YYbziovrGURPPcFqdPycOIyU/lYo
         mRGTiZhyO1U+7L4iLFhHKBMi5RFHEMsvboyz4Usrlco8Ukf011W7PwvJ3d8xNjpdkaWa
         nl1w1SKbx1BVTBgYmT/0ycnyy7PlhkfaUNlY5kSS70qejASboPSXIYTrH/Ua559lEgPc
         NOPw==
MIME-Version: 1.0
X-Received: by 10.60.136.129 with SMTP id qa1mr2343380oeb.59.1415112839812;
 Tue, 04 Nov 2014 06:53:59 -0800 (PST)
Received: by 10.60.41.193 with HTTP; Tue, 4 Nov 2014 06:53:59 -0800 (PST)
In-Reply-To: <tencent_23B90CE67AF56A127F8ADA05@qq.com>
References: <CAKcpw6WiuqJ5Cn4FNoYQEga8KBhZAZ4ohx35MqsdaOZDL6bABA@mail.gmail.com>
        <tencent_7A73C86D635497A07A126836@qq.com>
        <CAKcpw6Wb5+GMMHELghc4b2kss1bSGLqPw1k+MeJUsXzPA1Eb5w@mail.gmail.com>
        <tencent_23B90CE67AF56A127F8ADA05@qq.com>
Date:   Tue, 4 Nov 2014 22:53:59 +0800
Message-ID: <CAKcpw6VSQMKba62BQW9M6OmAzf6AyDuje57K0=+Mpb1DkAq__Q@mail.gmail.com>
Subject: Re: Problems of kernel of Loongson 3
From:   YunQiang Su <wzssyqa@gmail.com>
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <wzssyqa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wzssyqa@gmail.com
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

On Tue, Nov 4, 2014 at 10:48 PM, 陈华才 <chenhc@lemote.com> wrote:
> Hi,
>
> 1, mainstream kernel has only basic Loongson-3 support, not full-functional, something has missing.
> 2, Unfortunately, no VESA driver on Loongson...

AHhhhh, then what to do if to work with other graphic cards?

>
> Huacai
>
> ------------------ Original ------------------
> From:  "YunQiang Su"<wzssyqa@gmail.com>;
> Date:  Tue, Nov 4, 2014 10:36 PM
> To:  "陈华才"<chenhc@lemote.com>;
> Cc:  "linux-mips"<linux-mips@linux-mips.org>; "Aurelien Jarno"<aurelien@aurel32.net>;
> Subject:  Re: Problems of kernel of Loongson 3
>
>
> On Tue, Nov 4, 2014 at 10:24 PM, 陈华才 <chenhc@lemote.com> wrote:
>> Hi,
>>
>> 1, You can try 3.16 from master branch here:
>> http://dev.lemote.com/cgit/linux-official.git/
>
> OK, I will try it. Even though, we still need a patch to make it can
> use on Lemote machiens.
>
>>
>> 2, Since 3.14, radeon cannot support non-firmware display. This is confirmed by drm maintainers.
>
> How can x86 machines display something when firmwares are missing?
> Use something like vesa when firmwares are lost?
>
>>
>> Huacai
>>
>> ------------------ Original ------------------
>> From:  "YunQiang Su"<wzssyqa@gmail.com>;
>> Date:  Tue, Nov 4, 2014 09:40 PM
>> To:  "陈华才"<chenhc@lemote.com>;
>> Cc:  "linux-mips"<linux-mips@linux-mips.org>; "Aurelien Jarno"<aurelien@aurel32.net>;
>> Subject:  Problems of kernel of Loongson 3
>>
>>
>> I have tested the kernel 3.16, and 3.17 of Debian on loongson 3.
>> I met 2 major problems:
>>
>> 1. On the Lemote 6100 and Yeeloong 8133, load command hangs
>>
>>  PMON> load (wd0,0)/vmlinux-3.16-3-loongson-3
>>  Loading file: (wd0,0)/vmlinux-3.16-3-loongson-3
>>  (elf64)
>>  0x80200000/9171584 + 0x80abf280/34201152(z)
>>
>>  It also hangs on the dev board from Lemote.
>>  While it can boot on dev boards from Loongson.
>>
>>  3.15 kernel works fine on both boards.
>>
>> 2. If without radeon non-free firmware in initrd/vmlinux,
>>  the screen can display nothing.
>>  It makes us difficult to patch debian-install to support Loongson 3.
>>  A automatic fallback may be needed when nonfree firmware is not available.
>>
>> --
>> YunQiang Su
>
>
>
> --
> YunQiang Su



-- 
YunQiang Su
