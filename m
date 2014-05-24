Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 May 2014 03:34:03 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:60517 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833400AbaEXBeBcw6hg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 May 2014 03:34:01 +0200
Received: by mail-ig0-f173.google.com with SMTP id hn18so1341064igb.0
        for <multiple recipients>; Fri, 23 May 2014 18:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tjTcBnXTITpCwA8ChurzIhflK2m1q1FMaEG0KSrdyhk=;
        b=aSplbp5lmhTxMVCIaXS0osf9AME4kbnvZ1bFxqVRqXBOO8X1dIo4cwIGoD0j1eivYp
         nXCe0Qe3GIW+mDkHj9kQt+Ah2+tBGD3UMYmcUc2TD/FHzyUYFX7wBYLF/e89u35KiJ3Q
         hDTQCWRa9HxKwaWq2SI5NM6TW50oad7RPuXVsMqzmftp7gkJp0nJVjCFza37iVr6Tn13
         JQYMe+L0Y+B9nrEu7SzrJMU1j7KLpkSi0TYBfQFuTUwb0tpgecuM21pWuHPK/uWZG3XL
         c7Y15HDxMtp6veuhJU0eNWTmWIO9kE18nYHayAO4thWfdr7DJAYgSSkulPOQW4Ld9h7H
         IuaA==
MIME-Version: 1.0
X-Received: by 10.50.30.6 with SMTP id o6mr8639220igh.43.1400895235254; Fri,
 23 May 2014 18:33:55 -0700 (PDT)
Received: by 10.64.137.71 with HTTP; Fri, 23 May 2014 18:33:55 -0700 (PDT)
In-Reply-To: <CAGXxSxW69ua7=OcTPym+Not23-+isWdiZj3XvrEPJKQ5qf-Kyw@mail.gmail.com>
References: <1400401410-32600-1-git-send-email-chenj@lemote.com>
        <CAAhV-H6zvhUvjoQiG9-e5HHGBkbLJvN_LkbEZWEzfjJEmrmLgg@mail.gmail.com>
        <20140519100244.GL63315@pburton-linux.le.imgtec.org>
        <CAGXxSxWD2ryrv0JHnOUpDkjXGGKLk=5=RYH_aEXsq9kCu40LfQ@mail.gmail.com>
        <20140519170658.GB17197@linux-mips.org>
        <CAGXxSxW69ua7=OcTPym+Not23-+isWdiZj3XvrEPJKQ5qf-Kyw@mail.gmail.com>
Date:   Sat, 24 May 2014 09:33:55 +0800
Message-ID: <CAAhV-H5r_sRPL=LVTJghw7sTebDB1ThW3F+p8ziq1VmoUEbqUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
From:   Huacai Chen <chenhuacai@gmail.com>
To:     cee1 <fykcee1@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?546L6ZSQ?= <r@hev.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

No, I think we need more experiments to test the compatiability of
Loongson-3. So, ralf, I suggest to merge the first patch and drop this
one.

On Tue, May 20, 2014 at 8:33 PM, cee1 <fykcee1@gmail.com> wrote:
> 2014-05-20 1:06 GMT+08:00 Ralf Baechle <ralf@linux-mips.org>:
>> On Mon, May 19, 2014 at 11:15:15PM +0800, Chen Jie wrote:
>>
>>> 2014-05-19 18:02 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
>>> > On Sun, May 18, 2014 at 10:39:20PM +0800, Huacai Chen wrote:
>>> >> Due to Wang Rui's tests, Loongson-3's EI/DI instructions don't have
>>> >> correct behaviors, its Status.FR is also different with MIPS64R2. So,
>>> >> I don't want to select CPU_MIPS64_R2.
>>> >
>>> > Out of curiosity, how do ei & di misbehave?
>>> In our test, it may cause machine stall if use ei&di in kernel,
>>> especially in smp case.
>>
>> In that case we could make the use of DI/EI depend on a new errata flag
>> in war.h or similar.
>
> Thanks for the suggest!
> Huacai，I think we would try to select MIPS64_R2 for loongson3
> processor, and take care of the above bits to see whether it works.
>
>
> --
> Regards,
>
> - cee1
