Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 22:16:36 +0100 (CET)
Received: from mail-io0-x233.google.com ([IPv6:2607:f8b0:4001:c06::233]:39237
        "EHLO mail-io0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbdLHVQaCDFdX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 22:16:30 +0100
Received: by mail-io0-x233.google.com with SMTP id h12so3754455iof.6
        for <linux-mips@linux-mips.org>; Fri, 08 Dec 2017 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JINXylPt24gsOr5tWR0CbYPgLxnS4mhBudiuQ3WdUc=;
        b=SoJnCGNajr5HdKVb59Wwb66tig2hZ0oiaKjk09pOx5ofMdnKgoX171oAezOc5LCxTS
         CQxOnSQeXIahCHe7wJctN0jfVynb7BUz5Mc9eT+6JwNCJOuEhAumRL4FqF9y4TLgUn4l
         32jNfiu7htF8Wm6HxELBkzu4gmg4PtLer2oPxbgIRNgLCjOLWuOxcmUMqbYXm4GQUFgT
         FBO8CvEA4NGYJXm472TgKukmEya4wXwtIOkOiyQMRz0nVwxoTJ4cVIhgI99i3v4l8z3y
         2mymFtOUgibfHQtSzrB0SPzQVGOMAPoBB8zsgTVsTwuWXF+9zfRZjMLdCuTDjeNdmKJx
         tl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JINXylPt24gsOr5tWR0CbYPgLxnS4mhBudiuQ3WdUc=;
        b=krTvmw1IU4aBTRir7+hwc3L4pBddZCaho+69R2CqzUvtkQ9S/ILqxvJwIhkT+n9XcK
         Sfye8tcd23DIUKMSxhx0pjk5OF82xik8DF9bjESZSmoC63E0fEtYfdUAuHsIwzqkY+XF
         mAw//Rm+kEc8U1S8ii1BRkUzJ7WWn1P9Jg7uF5vmbBnsoPXIkxb6vaYwf1bHFpWjxiAc
         LKYIPo0aX9MqXM817v8byay6UNEXeen47t2d19g/XJlaF7GxVLtXzoOPGYGQ5MjU+bVx
         9fcWqteBDgiJiDllry66gHn4oJ3HYwIQzwhN/WJ18TIS+JymAEKJV5iq4i0bhf6Uvdtb
         KTHg==
X-Gm-Message-State: AJaThX69yTWlygQwt8mLiQWY6t29puWtw60Ns8rtgAh5G0iN6G2dVSMY
        47oTgdgwFBA5ObVIgjkEIV8=
X-Google-Smtp-Source: AGs4zMayuEoXL7AIbjW5c4mz8kt3n+tLwF2W8T8QJhN6uom5HfCin+Cstdh4bXKOXpKSDyKpezh7nw==
X-Received: by 10.107.9.223 with SMTP id 92mr42710172ioj.16.1512767783736;
        Fri, 08 Dec 2017 13:16:23 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:100:3fe9:f33:c853:df11? ([2620:15c:2c1:100:3fe9:f33:c853:df11])
        by smtp.googlemail.com with ESMTPSA id m123sm3958986iom.71.2017.12.08.13.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 13:16:22 -0800 (PST)
Message-ID: <1512767781.25033.30.camel@gmail.com>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-nfs@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Date:   Fri, 08 Dec 2017 13:16:21 -0800
In-Reply-To: <CAEdQ38HEduSTY38Noj4peaMN_G++5sLJfqzCMkd3M4pPNTpU_Q@mail.gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
         <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com>
         <CAEdQ38HcPswBk3pUHzQerFZ=4KjPc5nVYTqNnGQNMk7QbPXuOQ@mail.gmail.com>
         <CANn89iJKGRLVNAE99JWiyXcOXveytkjbQAiZ9XPiJc6fyEdFVA@mail.gmail.com>
         <1512741164.25033.28.camel@gmail.com>
         <CAEdQ38HEduSTY38Noj4peaMN_G++5sLJfqzCMkd3M4pPNTpU_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <eric.dumazet@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.dumazet@gmail.com
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

On Fri, 2017-12-08 at 12:26 -0800, Matt Turner wrote:
> 
> Thanks for the quick reply!
> 
> I tried the patch on top of master, but unfortunately the corruption
> still occurs.

You might try replacing in sbdma_add_rcvbuffer()

sb_new = netdev_alloc_skb(dev, size);

by 

sb_new = alloc_skb(size, GFP_ATOMIC);

Maybe the device does not like having a frame spanning 2 pages.
