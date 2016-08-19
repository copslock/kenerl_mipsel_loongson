Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 15:09:14 +0200 (CEST)
Received: from mail-yw0-f173.google.com ([209.85.161.173]:32769 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992172AbcHSNJGw40aU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 15:09:06 +0200
Received: by mail-yw0-f173.google.com with SMTP id r9so12377830ywg.0
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2016 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2oabHHmlWAAG5KzqqrX1RRD06MowaL2J9Rt0U9TYM/o=;
        b=HcfeWIICHcv+bWQycVNqIy8JuPIIz00yHNJ/aAMqPWpsedA7CbjsMXtN1/LXwpQX1W
         J6Bevyumx+3DG7WRIcclFjblUhMGp5rSvHoy6U7CudS2Bpy10ob/1q5M09xOn204Bmnh
         ZA26ji5RmdSu/rI26Y6gJ9g9om5Q5ektLVHmuAkIQcRssL1pagUlKVypeACcm9yA4R9W
         dAEbXs735zXUEmGt5sCxB0KWRT2GhmFfGjC3OO3Sjp2x6zUvhLX7C5U+crcZwIukSPGs
         E082RiC/fAuo4hHxhcMgaBjwLKeS8HLXxVMNZDBdOR08vCAjAPqO9fIQ7P0M/2YArViF
         qkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2oabHHmlWAAG5KzqqrX1RRD06MowaL2J9Rt0U9TYM/o=;
        b=KmOAkh/ELExgSbxPztyFktd8muLZVaiozV2y8ioYfVITdFRG7DQzI5ol49xiqLUJjV
         ju8NvvC8MaAh/HsbC6vcMX/Cu7Oa8PBxvahvm9opzHRNl5KKGao3Yj/utcI4+mpBbZ4I
         0TGz0+jT/AmF+6l6yLpQzSQbc07BJNEzEKZVPwC920FNE39xC5vgLPl+/sO3EVhstjiX
         HWK+FASbJNnB2pxi/KRxQGyeDXGF0BVg3NvcacwpOLcLBHJuuiK6HcJ8T8ekm7R2rZDm
         UoNBVjRIOgYZMrCgvnaCerA/Y0ZO6MWfa8/5Pg8yBIEx+H/tX86jjvV6RN69WgSoAZnU
         r3Qw==
X-Gm-Message-State: AEkoout4rPbw05T2kD8rtV7yCLk+kk8tbMN+DyfsZaIezl8x/6ORtjaSfOseAMtLFseAydXRfbKnUE9dizY2LA==
X-Received: by 10.13.222.133 with SMTP id h127mr6671156ywe.279.1471612141141;
 Fri, 19 Aug 2016 06:09:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.44.77 with HTTP; Fri, 19 Aug 2016 06:09:00 -0700 (PDT)
In-Reply-To: <CAH8yC8ny62Vf63cjtL8bUgGoRr-0BVGvqazs20S4JreJq+OBcg@mail.gmail.com>
References: <1471448151-20850-1-git-send-email-prasannatsmkumar@gmail.com> <CAH8yC8ny62Vf63cjtL8bUgGoRr-0BVGvqazs20S4JreJq+OBcg@mail.gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Fri, 19 Aug 2016 18:39:00 +0530
Message-ID: <CANc+2y4-sVNbs9=uuESoWY8Db3i_GkxQ=hrAEF8oWFGBm6fiKw@mail.gmail.com>
Subject: Re: [PATCH] Add Ingenic JZ4780 hardware RNG driver
To:     noloader@gmail.com
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

> __ARM_FEATURE_UNALIGNED (cf.,
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0774f/chr1383660321827.html)
> . MIPSEL does not define such a macro.
>
>     # MIPS ci20 creator with GCC 4.6
>     $ gcc -march=native -dM -E - </dev/null | grep -i align
>     #define __BIGGEST_ALIGNMENT__ 8
>
> If the MIPS CPU does not tolerate unaligned data access, then the
> following could SIGBUS:
>
>> +       u32 *data = buf;
>> +       *data = jz4780_rng_readl(jz4780_rng, REG_RNG_DATA);
>
> If GCC emits code that uses the MIPS unaligned load and store
> instructions, then there's probably going to be a performance penalty.
>
> Regardless of what the CPU tolerates, I believe unaligned data access
> is undefined behavior in C/C++. I believe you should memcpy the value
> into the buffer.

I am not sure whether this is required. 'buf' is part of a structure
so I guess it is properly aligned by padding. Not sure though, will
look about this.
