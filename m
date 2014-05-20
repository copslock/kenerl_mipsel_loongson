Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 14:34:07 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:62106 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819165AbaETMeErTA4Q convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 14:34:04 +0200
Received: by mail-lb0-f176.google.com with SMTP id p9so330269lbv.35
        for <multiple recipients>; Tue, 20 May 2014 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rVVWbBA2ZBSaEvSwB4WniWKYhbKakPhwEUcZwVrbeHI=;
        b=v0kVhb8l6/hK7cB2UVIWdia/Q0EpbIZZeo6dZ0Po0Lwf/7XU23cPwz/Gpa85jJ3eAy
         06PpUewUJPkjJXdFuLNbTykyYuQZuEPQdmVWWlq9piEUczeefY1K6Z2k36CVkmvaaT0C
         +tngblgKn2L32zL8Un8eZdY2gyxG8vtjLQtOwrj9YItiDic/E1cpK79ugHRSZ2d/kg7j
         ub5HB+fTTkfqF71f1sRnmWxv5j+AxpDfXjEtE2gfb3JycDawde+f3jorefUD+K4GxWCk
         imx3xbXCwRjbi6DeldMjexAJYx9yfma5DpbDeBHvrMl0BG/5sLSj8lW3+EBhLT1Z3Obb
         DP/A==
X-Received: by 10.112.137.39 with SMTP id qf7mr29782878lbb.18.1400589239090;
 Tue, 20 May 2014 05:33:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.176.137 with HTTP; Tue, 20 May 2014 05:33:39 -0700 (PDT)
In-Reply-To: <20140519170658.GB17197@linux-mips.org>
References: <1400401410-32600-1-git-send-email-chenj@lemote.com>
 <CAAhV-H6zvhUvjoQiG9-e5HHGBkbLJvN_LkbEZWEzfjJEmrmLgg@mail.gmail.com>
 <20140519100244.GL63315@pburton-linux.le.imgtec.org> <CAGXxSxWD2ryrv0JHnOUpDkjXGGKLk=5=RYH_aEXsq9kCu40LfQ@mail.gmail.com>
 <20140519170658.GB17197@linux-mips.org>
From:   cee1 <fykcee1@gmail.com>
Date:   Tue, 20 May 2014 20:33:39 +0800
Message-ID: <CAGXxSxW69ua7=OcTPym+Not23-+isWdiZj3XvrEPJKQ5qf-Kyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        huacai chen <chenhuacai@gmail.com>,
        =?UTF-8?B?546L?= =?UTF-8?B?6ZSQ?= <r@hev.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fykcee1@gmail.com
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

2014-05-20 1:06 GMT+08:00 Ralf Baechle <ralf@linux-mips.org>:
> On Mon, May 19, 2014 at 11:15:15PM +0800, Chen Jie wrote:
>
>> 2014-05-19 18:02 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
>> > On Sun, May 18, 2014 at 10:39:20PM +0800, Huacai Chen wrote:
>> >> Due to Wang Rui's tests, Loongson-3's EI/DI instructions don't have
>> >> correct behaviors, its Status.FR is also different with MIPS64R2. So,
>> >> I don't want to select CPU_MIPS64_R2.
>> >
>> > Out of curiosity, how do ei & di misbehave?
>> In our test, it may cause machine stall if use ei&di in kernel,
>> especially in smp case.
>
> In that case we could make the use of DI/EI depend on a new errata flag
> in war.h or similar.

Thanks for the suggest!
Huacai，I think we would try to select MIPS64_R2 for loongson3
processor, and take care of the above bits to see whether it works.


-- 
Regards,

- cee1
