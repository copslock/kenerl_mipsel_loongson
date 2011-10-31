Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2011 10:20:22 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:65492 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903553Ab1JaJUT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2011 10:20:19 +0100
Received: by wwf4 with SMTP id 4so984682wwf.24
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v9awrXCDz0JhwNc5c+IWc/oBmGVvxyxSYcm/Y+LZsLw=;
        b=rVlfCLrhf0aZCivIK7n2NrXfYLQxXG5S77UdioI7HjNUJ9d7ImupnfcIpYgOwjqF8R
         7/dD2AIwEnb6znkYwfNKQeOAt9+O1D00TWWLGGRAqYm/zDJYVS2wKTyIiUaibhIr1ZaP
         GKf08HVZ3QqZzGEkrDB6gmKRL07uPjYUGRMoo=
MIME-Version: 1.0
Received: by 10.216.137.42 with SMTP id x42mr2482177wei.56.1320052813754; Mon,
 31 Oct 2011 02:20:13 -0700 (PDT)
Received: by 10.216.187.137 with HTTP; Mon, 31 Oct 2011 02:20:13 -0700 (PDT)
In-Reply-To: <CAGXxSxXmgzxN361Cko1fY_+oWwfgjXLhS61gtvqB8YYXHXZVyw@mail.gmail.com>
References: <CAGXxSxXmgzxN361Cko1fY_+oWwfgjXLhS61gtvqB8YYXHXZVyw@mail.gmail.com>
Date:   Mon, 31 Oct 2011 17:20:13 +0800
Message-ID: <CAM2zO=CodQLE05ZNOOba3jv_qJ5XuZj3yrnS0aHCOj+cp_24Xw@mail.gmail.com>
Subject: Re: [MIPS]clocks_calc_mult_shift() may gen a too big mult value
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     Chen Jie <chenj@lemote.com>
Cc:     linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        johnstul@us.ibm.com, tglx@linutronix.de, yanhua <yanh@lemote.com>,
        =?UTF-8?B?6aG55a6H?= <xiangy@lemote.com>,
        zhangfx <zhangfx@lemote.com>,
        =?UTF-8?B?5a2Z5rW35YuH?= <sunhy@lemote.com>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21833

On Mon, Oct 31, 2011 at 5:00 PM, Chen Jie <chenj@lemote.com> wrote:
> Hi all,
>
> On MIPS, with maxsec=4, clocks_calc_mult_shift() may generate a very
> big mult, which may easily cause timekeeper.mult overflow within
> timekeeping jobs.

Hmmm, why not use clocksource_register_hz()/clocksource_register_khz()
instead? it's more convenient.

Thanks,
Yong

>
> e.g. when clock freq was 250000500(i.e. mips_hpt_frequency=250000500,
> and the CPU Freq will be 250000500*2=500001000), mult will be
> 0xffffde72
>
> Attachment is a script that calculates mult values for CPU Freq
> between 400050000 and 500050000, with 1KHz step. It outputs mult
> values greater than 0xf0000000:
> CPU Freq:500001000, mult:0xffffde72, shift:30
> CPU Freq:500002000, mult:0xffffbce4, shift:30
> CPU Freq:500003000, mult:0xffff9b56, shift:30
> CPU Freq:500004000, mult:0xffff79c9, shift:30
> ...
>
> The peak value appears around CPU_freq=500001000.
>
> To avoid this, it may need:
> 1. Supply a bigger maxsec value?
> 2. In clocks_calc_mult_shift(), pick next mult/shift pair if mult is
> too big? Then maxsec will not be strictly obeyed.
> 3. Change timekeeper.mult to u64?
> 4. ...
>
> Any idea?
>
>
>
> --
> Regards,
> - Chen Jie
>



-- 
Only stand for myself
