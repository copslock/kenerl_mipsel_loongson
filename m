Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2011 14:05:28 +0100 (CET)
Received: from e37.co.us.ibm.com ([32.97.110.158]:36021 "EHLO
        e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903562Ab1JaNFV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2011 14:05:21 +0100
Received: from /spool/local
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <johnstul@us.ibm.com>;
        Mon, 31 Oct 2011 07:04:16 -0600
Received: from d03relay01.boulder.ibm.com ([9.17.195.226])
        by e37.co.us.ibm.com ([192.168.1.137]) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 31 Oct 2011 07:03:31 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
        by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9VD3K8s116166
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 07:03:26 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
        by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9VD3JMN030318
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 07:03:20 -0600
Received: from [9.65.34.197] (sig-9-65-34-197.mts.ibm.com [9.65.34.197])
        by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p9VD3IWU030183;
        Mon, 31 Oct 2011 07:03:19 -0600
Message-ID: <1320066197.2266.11.camel@js-netbook>
Subject: Re: [MIPS]clocks_calc_mult_shift() may gen a too big mult value
From:   John Stultz <johnstul@us.ibm.com>
To:     Chen Jie <chenj@lemote.com>
Cc:     Yong Zhang <yong.zhang0@gmail.com>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        yanhua <yanh@lemote.com>,
        =?UTF-8?Q?=E9=A1=B9=E5=AE=87?= <xiangy@lemote.com>,
        zhangfx <zhangfx@lemote.com>,
        =?UTF-8?Q?=E5=AD=99=E6=B5=B7=E5=8B=87?= <sunhy@lemote.com>
Date:   Mon, 31 Oct 2011 09:03:17 -0400
In-Reply-To: <CAGXxSxUHGN99hXK8K5k9ayVfMenAWAbWVpqkotix_JyUbPCU+w@mail.gmail.com>
References: <CAGXxSxXmgzxN361Cko1fY_+oWwfgjXLhS61gtvqB8YYXHXZVyw@mail.gmail.com>
         <CAM2zO=CodQLE05ZNOOba3jv_qJ5XuZj3yrnS0aHCOj+cp_24Xw@mail.gmail.com>
         <CAGXxSxUHGN99hXK8K5k9ayVfMenAWAbWVpqkotix_JyUbPCU+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.0- 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
x-cbid: 11103113-7408-0000-0000-000000782CE3
X-archive-position: 31331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21910

On Mon, 2011-10-31 at 18:48 +0800, Chen Jie wrote:
> Hi,
> 
> 2011/10/31 Yong Zhang <yong.zhang0@gmail.com>:
> > On Mon, Oct 31, 2011 at 5:00 PM, Chen Jie <chenj@lemote.com> wrote:
> >> Hi all,
> >>
> >> On MIPS, with maxsec=4, clocks_calc_mult_shift() may generate a very
> >> big mult, which may easily cause timekeeper.mult overflow within
> >> timekeeping jobs.
> >
> > Hmmm, why not use clocksource_register_hz()/clocksource_register_khz()
> > instead? it's more convenient.
> 
> Thanks for the suggestion. And sorry for I didn't notice the upstream
> code has already hooked to clocksource_register_hz() in csrc-r4k.c
> (We're using r4000 clock source)
> 
> I'm afraid this still doesn't fix my case. Through
> clocksource_register_hz()->__clocksource_register_scale()->__clocksource_updatefreq_scale,
> I got a calculated maxsec = (0xffffffff - (0xffffffff>>5))/250000500 =
> 16        # assume mips_hpt_frequency=250000500
> 
> With this maxsec, I got a mult of 0xffffde72, still too big.

Hrmm. Yong Zang is right to suggest clocksource_register_hz(), as the
intention of that code is to try to avoid these sorts of issues.

What is the corresponding shift value you're getting for the value
above?

Could you annotate clocks_calc_mult_shift() a little bit to see where
things might be going wrong?

thanks
-john
