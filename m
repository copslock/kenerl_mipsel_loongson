Return-Path: <SRS0=yIBi=UY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D844C48BD6
	for <linux-mips@archiver.kernel.org>; Tue, 25 Jun 2019 20:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C439208CA
	for <linux-mips@archiver.kernel.org>; Tue, 25 Jun 2019 20:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561493733;
	bh=Non/zwPybF2AGuhmjwFgxmMCpYW8ogfnhbNrhDKk/vc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ulTqxPMj9ff4v02nhIj3QrI1urz1ILQvBZFUgaRhpKQ6A1+UtCpSZ4a3KUs+NSPh3
	 Cdqb3cbwvJ8DlT7OAgV2nrIRPON5gQoFKMkNxNnYIrpj2G+fnlo6kTTzZLQB68JrGA
	 4rzfSsjiW4NIjRlLUcVZd2RWAmFgLyCr+tCnyfOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfFYUPd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfFYUPd (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 25 Jun 2019 16:15:33 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7006208CA
        for <linux-mips@vger.kernel.org>; Tue, 25 Jun 2019 20:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561493732;
        bh=Non/zwPybF2AGuhmjwFgxmMCpYW8ogfnhbNrhDKk/vc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lLPnssPRCinSZhMedXFl4IX9MsXTNhVSxFwL4KFntKi0pXjqZtp295xgMzrg8LGbO
         mOUGpRdpbB/L63NxLJu57zUIKU8V40nkRaOVFZ6w0Dr1RtDyGNFekX200zDZun+Q1n
         hwMQ4fQRt/bJqYXOD6mBo2LKulD7skPGobAZzDmU=
Received: by mail-wr1-f48.google.com with SMTP id p11so50819wre.7
        for <linux-mips@vger.kernel.org>; Tue, 25 Jun 2019 13:15:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXNOkxtpiQnwKbCsAkZj6eeUuqofmv+0/WQkMRnWyxYnS8ELvQX
        n4Whq1o4SW+FZqJzYv2vuNIesPEqf5ffSPoaOli/Yw==
X-Google-Smtp-Source: APXvYqyhHtmITJg1+Pl3hirpl0QwbJ++nvN6wGzhM8y02SUtgxU8TIY6h1kuPsgr5idu476pi12gfJv0CJukh1rt4Oc=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr17560wrj.47.1561493730555;
 Tue, 25 Jun 2019 13:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190624133607.GI29497@fuggles.cambridge.arm.com>
 <20190625161804.38713-1-vincenzo.frascino@arm.com> <alpine.DEB.2.21.1906251851350.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906252024350.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906252024350.32342@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Jun 2019 13:15:19 -0700
X-Gmail-Original-Message-ID: <CALCETrWE3zYN-6h0RkMV9j5kSkSWbJ-nQnjhH=md=ybSR0eZ9Q@mail.gmail.com>
Message-ID: <CALCETrWE3zYN-6h0RkMV9j5kSkSWbJ-nQnjhH=md=ybSR0eZ9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib/vdso: Delay mask application in do_hres()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, Jun 25, 2019 at 11:27 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 25 Jun 2019, Thomas Gleixner wrote:
>
> > On Tue, 25 Jun 2019, Vincenzo Frascino wrote:
> >
> > CC+ Andy
> >
> > > do_hres() in the vDSO generic library masks the hw counter value
> > > immediately after reading it.
> > >
> > > Postpone the mask application after checking if the syscall fallback is
> > > enabled, in order to be able to detect a possible fallback for the
> > > architectures that have masks smaller than ULLONG_MAX.
> >
> > Right. This only worked on x86 because the mask is there ULLONG_MAX for all
> > VDSO capable clocksources, i.e. that ever worked just by chance.
> >
> > As we talked about that already yesterday, I tested this on a couple of
> > machines and as expected the outcome is uarch dependent. Minimal deviations
> > to both sides and some machines do not show any change at all. I doubt it's
> > possible to come up with a solution which makes all uarchs go faster
> > magically.
> >
> > Though, thinking about it, we could remove the mask operation completely on
> > X86. /me runs tests
>
> Unsurprisingly the results vary. Two uarchs do not care, but they did not
> care about moving the mask either. The other two gain performance and the
> last one falls back to the state before moving the mask. So in general it
> looks like a worthwhile optimization.
>

At one point, I contemplated a different approach: have the "get the
counter" routine return 0 and then do if (unlikely(cycles <= last))
goto fallback.  This will remove one branch from the hot path.  I got
dubious results when I tried benchmarking it, probably because the
branch in question was always correctly predicted.
