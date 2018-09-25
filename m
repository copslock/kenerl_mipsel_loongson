Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 21:31:05 +0200 (CEST)
Received: from mail-wm1-x343.google.com ([IPv6:2a00:1450:4864:20::343]:33103
        "EHLO mail-wm1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbeIYTbAO7rNk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 21:31:00 +0200
Received: by mail-wm1-x343.google.com with SMTP id r1-v6so13418119wmh.0;
        Tue, 25 Sep 2018 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ql9pVet2eun9Mn9AWv9RhcECS2xztA7i3bnKEiMZGLE=;
        b=PGt3Q1as+F+pJr9RREZ4/P20w7bSdYAblkqJnXKmKOhrzzvFX1SkFdDuxqWb0AwQrk
         zSYt9oCu2gnL+Y1sNeKW8WL3sI4iOUBDZBBnxwqNyVh8WTDNeKkyHvhw4Qr6O+ghFwST
         /6K19UMQRq6Aj6FNVLJkTf/8mu6lqfg94RrFEq+FEy/xOoVq7Y+mzEB8MPafAtpzcw1u
         So+2DJBc4c4T+5/T6xYI7Vg3JmMKEeZHLqUo1OkIqo8UXdVJirvabL3yem1ylAfhnuGS
         CDVsljo4R3g8LeTbUS/guwmNoqM4fY2k64Gfi/vhJS26pUTaTjvG3CciojyqFl5ykNze
         kiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ql9pVet2eun9Mn9AWv9RhcECS2xztA7i3bnKEiMZGLE=;
        b=P6mpYDKvfvadtVmLH/tl2G1MjklZ1sCX4nyekrTArqn2AWcIbASAU4tJseTDUaJcVx
         gKcWW5QaKvvPydWMfCC1dIKC6ehKZlSDX+nC0x3EfPdOg34Sopnxi5ouQPpJkB8/1l7a
         F9HR6/CUJG2bE8KkUOSbm0lZygiorpnWx5KC2/QUyNX882cpOXxaO2Cj2hyaI2Jhh53Z
         dg2EInoE+ZAGtNlrIQmCc3/47uQICPgN7qT7BYOUbB4I6v7zuZAJIWJZ4b4MZWw8t1Rp
         emYkrWIX7WYJM4mPiRUtWKr1vE9paHup0trE7LTaWOt/kQsuhpuUjDDcGZTOA34Z3o9i
         ZLfA==
X-Gm-Message-State: ABuFfojpf80B9S28rVKJJyZQQ1KWcv1Aul4qObQMixfGTC5Ezj2+6mJg
        XNX7dk1FNp/MegDfDG3Jd1A=
X-Google-Smtp-Source: ACcGV62dJhWbz8defye/tcdE5LSEKxWuWA+zArm/zfBqrG1YC7sTHQD0jBmmvvrerBeBFAKg/bdGbA==
X-Received: by 2002:a1c:90e:: with SMTP id 14-v6mr1948045wmj.130.1537903854838;
        Tue, 25 Sep 2018 12:30:54 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id c12-v6sm3353630wrr.6.2018.09.25.12.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:30:54 -0700 (PDT)
Message-ID: <fc0016b8c3d08fc139356c39668c6ab5d8c297fd.camel@gmail.com>
Subject: Re: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned
 access instructions
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Sep 2018 22:30:52 +0300
In-Reply-To: <20180925174510.rg3j4lfmwvlecnqt@pburton-laptop>
References: <20180920170306.9157-1-yasha.che3@gmail.com>
         <20180920170306.9157-2-yasha.che3@gmail.com>
         <20180925174510.rg3j4lfmwvlecnqt@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

Hi Paul,

On Tue, 2018-09-25 at 17:45 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Thu, Sep 20, 2018 at 08:03:06PM +0300, Yasha Cherikovsky wrote:
> > MIPSR6 doesn't support unaligned access instructions (lwl, lwr,
> > swl, swr).
> > The MIPS tree has some special cases to avoid these instructions,
> > and currently the code is testing for CONFIG_CPU_MIPSR6.
> > 
> > Declare a new Kconfig variable:
> > CONFIG_CPU_HAS_NO_UNALIGNED_LOAD_STORE,
> > and make CONFIG_CPU_MIPSR6 select it.
> > And switch all the special cases to test for the new variable.
> > 
> > Also, the new variable selects CONFIG_GENERIC_CSUM, to use
> > generic C checksum code (to avoid special assembly code that uses
> > the unsupported instructions).
> 
> Thanks for your patch :)
> 
> I think it would be cleaner to invert this logic & instead have the
> Kconfig entry indicate when kernel's build target *does* support the
> [ls]w[lr] instructions.
> 
> It would be good for the name to be clear that these instructions are
> what it's about too - "unaligned load store" is a little too vague
> for
> my liking. For example one could easily misconstrue it to mean
> something
> akin to the inverse of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
> whereas
> in the MIPSr6 case many CPUs actually handle unaligned accesses in
> hardware when using the regular load/store instructions. They don't
> have
> the [ls]w[lr] instructions, but they don't need them because they
> handle
> unaligned accesses more naturally without needing us to be explicit
> about them.
> 
> How about we:
> 
>   - Add a Kconfig option CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and
> select
>     it for all existing pre-r6 targets (probably from CONFIG_CPU_*).
> 
>   - Change CONFIG_GENERIC_CSUM to default y if
>     !CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and drop the selects of it.
> 
> That would avoid the double-negative ("if we don't not support this")
> that the #ifndef's currently represent. It would also mean any future
> architecture/ISA targets beyond MIPSr6 automatically avoid the
> instructions.
> 
> Thanks,
>     Paul

Thanks for your feedback, I'll start preparing v2.

Looking in arch/mips/Kconfig, some CPU options start
with CPU_SUPPORTS_ and some with CPU_HAS_.
Which perfix should we use here?

Thanks,
Yasha
