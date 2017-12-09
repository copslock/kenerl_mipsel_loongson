Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2017 22:37:20 +0100 (CET)
Received: from mail-pl0-x243.google.com ([IPv6:2607:f8b0:400e:c01::243]:41322
        "EHLO mail-pl0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbdLIVhMfdST0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2017 22:37:12 +0100
Received: by mail-pl0-x243.google.com with SMTP id g2so2354829pli.8
        for <linux-mips@linux-mips.org>; Sat, 09 Dec 2017 13:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJqhuvmNDiGQ7DsgsalIVrxOlgVf9VjD/WOjlBXo85w=;
        b=O8oqdulP5aJRLt8XpkApkWzqvvFKOfcMFxrxald0Bk6J3duLxUHKpeMW7pyllWrNvZ
         M6wJYixWgn1XRZ4peFRjMNihrRssHqhaUoA15hyrq0xjY7GX3fjK+2/mAidSMlwe85je
         VY4p6VbmT14MyF+5qHQmdv4pX9jDgSw+DdsW6x2LPEh6ZLcFyv7BRywv+r0X+qVBIFdO
         OlObTXtr0VsnzIBFy+tDSQmDdXDVkZ9LOpPQ51mWKbFpEZPhB+pRIenEUwpKSgRLjxYl
         SPvJbzPF8aG/hCuB9Fv5tqx1ab2rkBoZyeQ0g6MsDMkDu9z/QCNmBk5gh4P5jF6O460W
         QE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJqhuvmNDiGQ7DsgsalIVrxOlgVf9VjD/WOjlBXo85w=;
        b=kd1E3Gtymmbd9qz1j4ZaAwX1A7shq+VQlcDV3NsqMgSrXZUC5v0geWab/Zjv9XnxEA
         laGrq8XXI4HZYLI6wDvOVRiDV/XJrrZ36CRrzCqQwzFCDNYKy7D+tfKsdw5ER77ZwgnE
         1N2Y2lFOtENjq4PDRrENQ2CJhCb5ltrPWRCaXVRt0tYvopcPl97R4L9tNfcikHzXuOD0
         Ds7POyDdHpcgAlXwtgrQLdzbUZ3rIpOWle6jSalOyXLIAp7kOpLWgpkJvvG0Quo6F7bk
         XSmoMhcS7clAHoaqGVeSbmaLfUZYbsxIXQBk+PKkVMS2g0te2G+d1895waqHLFrwfryb
         AAhQ==
X-Gm-Message-State: AJaThX77MtAffFBK7zFzDQgH5SzQ8/xlUcs6nbPst4KSPGmKRWxkrxou
        9EGegJKcIlK0w3R1Z0g+CQs=
X-Google-Smtp-Source: AGs4zMaVkaWvzYjhfvgBwyAz41RyRJXJ07vI4zJ2frv5OSy9ROioxqItimO/AlcmLNMFZEMJSfCk0g==
X-Received: by 10.84.244.2 with SMTP id g2mr33970824pll.170.1512855425938;
        Sat, 09 Dec 2017 13:37:05 -0800 (PST)
Received: from edumazet-glaptop3.lan (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.googlemail.com with ESMTPSA id a6sm17174732pff.158.2017.12.09.13.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Dec 2017 13:37:04 -0800 (PST)
Message-ID: <1512855422.25033.34.camel@gmail.com>
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
Date:   Sat, 09 Dec 2017 13:37:02 -0800
In-Reply-To: <CAEdQ38H+jUF3OXpe13Vfm=QZE3iHa=B7PpXkpbek1PnY2E1u5w@mail.gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
         <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com>
         <CAEdQ38HcPswBk3pUHzQerFZ=4KjPc5nVYTqNnGQNMk7QbPXuOQ@mail.gmail.com>
         <CANn89iJKGRLVNAE99JWiyXcOXveytkjbQAiZ9XPiJc6fyEdFVA@mail.gmail.com>
         <1512741164.25033.28.camel@gmail.com>
         <CAEdQ38HEduSTY38Noj4peaMN_G++5sLJfqzCMkd3M4pPNTpU_Q@mail.gmail.com>
         <1512767781.25033.30.camel@gmail.com>
         <CAEdQ38H+jUF3OXpe13Vfm=QZE3iHa=B7PpXkpbek1PnY2E1u5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <eric.dumazet@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61393
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

On Sat, 2017-12-09 at 13:03 -0800, Matt Turner wrote:
> On Fri, Dec 8, 2017 at 1:16 PM, Eric Dumazet <eric.dumazet@gmail.com>
> wrote:
> > On Fri, 2017-12-08 at 12:26 -0800, Matt Turner wrote:
> > > 
> > > Thanks for the quick reply!
> > > 
> > > I tried the patch on top of master, but unfortunately the
> > > corruption
> > > still occurs.
> > 
> > You might try replacing in sbdma_add_rcvbuffer()
> > 
> > sb_new = netdev_alloc_skb(dev, size);
> > 
> > by
> > 
> > sb_new = alloc_skb(size, GFP_ATOMIC);
> > 
> > Maybe the device does not like having a frame spanning 2 pages.
> 
> No such luck. I also gave changing the page size from 16K to 4K a
> shot
> without success.


If your hist is SMP, could you try running it with one CPU only ?

Sorry, I have no more ideas :/
