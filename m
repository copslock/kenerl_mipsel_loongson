Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 22:13:09 +0200 (CEST)
Received: from mail-wm1-x342.google.com ([IPv6:2a00:1450:4864:20::342]:53285
        "EHLO mail-wm1-x342.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993961AbeIYUNBnIFqk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 22:13:01 +0200
Received: by mail-wm1-x342.google.com with SMTP id b19-v6so14774236wme.3;
        Tue, 25 Sep 2018 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=LiZhOqz7StL5Ja1ofBA4O+CSFGJDKQQ5BcXyQrpm6lg=;
        b=XuOmBHibBTCoPO3JBlnCGuET8ceYE2Qe8kriKUPWGsQx2CD8IKGFdu128pzlltfSVy
         3qDVrNXjDIqEA7NKHTVJzsyVOM1gsjTRuQ2CPe+NhMvYD32KJyL6tSQhCzcG78as97JQ
         J82sxYDF29ugqSuFFNraczy7sNPAVQtQbD4faNsontp/Q/CymfALM1MgvFIQtsOxUjBs
         dkFqoaDMimV/oMnM9ckUdqKr3KktSONM/gF7+mJqeT1Wi6s8ClX0lUgn7/5B/wOoT21I
         jJBqUVrE72C4Wpvf6ERL/ofupV1RKUp5qAjjtJzdlp2NPAPCUhcTQHr4dhwk2Yodd6iR
         1NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LiZhOqz7StL5Ja1ofBA4O+CSFGJDKQQ5BcXyQrpm6lg=;
        b=mhSHetckhrxDJednZo/7JBi98eMvlBJTQfgh5vGCkonoR6q6g18pKHJOII+4+IDYXD
         cFHlw9/uigijwyFYwAwXSiRW0RlncNVMVKihm6sE4A6Mf7khLeIV8GHULjoVh9K71CO4
         f0Vil9nckGHzQCb92x9dLsRqtrxl5LcRxpkvVB7g9OcwH8yvnFMEkPNTu0K+T4jyG7vX
         nsB0OLQuzXlgppwFEl6U+OXgcBL3N6OSy9eJHTug8qft57RvwrHj864OSX/VfvXhBuzU
         o9+UDgyKHzGkA9TcYvMPuIZCjjKhhNcpz7HUcnhcqoB3ZqZ2MBxYYBDaPhtDSUj1PgfC
         P7EA==
X-Gm-Message-State: ABuFfoiIOxSmG9qJDTGnTxqdVdIS+J8/EchdXGofxMEvRywpC55FP2Jy
        W2Gx6evbU+vbCrMVFJz9WQ96PV4bUps=
X-Google-Smtp-Source: ACcGV63Ctn6BGoaJ78s+rSLB/mCL+yQuT0HJqqcLO0HybgvTAGLpRnvcqlFtKuxuh3fBt8cZ6AIjeQ==
X-Received: by 2002:a1c:f210:: with SMTP id s16-v6mr2142887wmc.36.1537906376290;
        Tue, 25 Sep 2018 13:12:56 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id x16-v6sm1982387wro.84.2018.09.25.13.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:12:55 -0700 (PDT)
Message-ID: <a75bc7c92bd9806a56ec2736218dec15b5cf7eba.camel@gmail.com>
Subject: Re: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned
 access instructions
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Sep 2018 23:12:53 +0300
In-Reply-To: <20180925195757.glglc6q3ghn3dhs5@pburton-laptop>
References: <20180920170306.9157-1-yasha.che3@gmail.com>
         <20180920170306.9157-2-yasha.che3@gmail.com>
         <20180925174510.rg3j4lfmwvlecnqt@pburton-laptop>
         <fc0016b8c3d08fc139356c39668c6ab5d8c297fd.camel@gmail.com>
         <20180925195757.glglc6q3ghn3dhs5@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66561
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

On Tue, 2018-09-25 at 19:57 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Tue, Sep 25, 2018 at 10:30:52PM +0300, Yasha Cherikovsky wrote:
> > On Tue, 2018-09-25 at 17:45 +0000, Paul Burton wrote:
> > > How about we:
> > > 
> > >   - Add a Kconfig option CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and
> > > select
> > >     it for all existing pre-r6 targets (probably from CONFIG_CPU_*).
> > > 
> > >   - Change CONFIG_GENERIC_CSUM to default y if
> > >     !CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and drop the selects of it.
> > > 
> > > That would avoid the double-negative ("if we don't not support this")
> > > that the #ifndef's currently represent. It would also mean any future
> > > architecture/ISA targets beyond MIPSr6 automatically avoid the
> > > instructions.
> > 
> > Thanks for your feedback, I'll start preparing v2.
> > 
> > Looking in arch/mips/Kconfig, some CPU options start
> > with CPU_SUPPORTS_ and some with CPU_HAS_.
> > Which perfix should we use here?
> 
> That's a good question :)
> 
> To be honest I don't think either of them is perfect, since what we're
> really describing is what's supported by the ISA that the kernel build
> is targeting - and in theory the CPU we actually run on could support
> extra things.
> 
> But considering it I think CPU_HAS_ is probably the best choice for
> this, since it's already used similarly to indicate support for pref &
> sync instructions.
> 
> Thanks,
>     Paul

OK, Thanks.
