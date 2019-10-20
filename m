Return-Path: <SRS0=5Qf2=YN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71C0CA9EAD
	for <linux-mips@archiver.kernel.org>; Sun, 20 Oct 2019 22:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBF7222BD
	for <linux-mips@archiver.kernel.org>; Sun, 20 Oct 2019 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571609583;
	bh=Bj6TMw73TeyNuW745jBR36LTFG28G62Y2RhDJWbn4wI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JpnfU5yFuJT4tqwk+gNh5pOFdStrQaEP35av7/Z2Y3+XbymTL9yvHsJlQPF5u/I09
	 82yxcWXDMzzRqEh6Nv/wTDldg80CX4mcvAU41adSlOCKDn7aoyf2F+XvrqYn5jcDpB
	 ZFT1yrTeVvajHHlwI1X+ddJawFt8FDbnxpSdmsW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfJTWNB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 20 Oct 2019 18:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfJTWNA (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 20 Oct 2019 18:13:00 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38F3222D2
        for <linux-mips@vger.kernel.org>; Sun, 20 Oct 2019 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571609580;
        bh=Bj6TMw73TeyNuW745jBR36LTFG28G62Y2RhDJWbn4wI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VIyC6wMikDIhgnUB916uKwtRZcQQS+CCJ0/RiVro3qHvmTqjvylBSubxX3UJgU8e3
         vkHSFY2q5M3gGM8xWnrn1rKm3rPBMDwevxuVZOPgJuS0/YLTrkSWPTd0CATZ65aF8h
         JiaQnct0W52K3qiJ2nuZpRINiX4Er5jGr1FbeTmg=
Received: by mail-wm1-f53.google.com with SMTP id p7so11144600wmp.4
        for <linux-mips@vger.kernel.org>; Sun, 20 Oct 2019 15:12:59 -0700 (PDT)
X-Gm-Message-State: APjAAAWdRiV45P82ZmhtjzJjRrjsit7+qZvroU+C4X8k4EbQLDkPgH/6
        tlmdWLFtAwaLoszKi9yxDjS3gIlYXPXNwYVdvUCb/Q==
X-Google-Smtp-Source: APXvYqzMQ1Ze2hicw5XWHD67VMC7zJog1FHKMEmLDyh4ecdsNSYrUq/3HwKGfn5UAcczdDu2eqPXZy7UkPB8fZDR+yU=
X-Received: by 2002:a1c:a556:: with SMTP id o83mr17574912wme.0.1571609577995;
 Sun, 20 Oct 2019 15:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <1571367619-13573-1-git-send-email-chenhc@lemote.com>
 <CALCETrWXRgkQOJGRqa_sOLAG2zhjsEX6b86T2VTsNYN9ECRrtA@mail.gmail.com>
 <CAAhV-H6VkW5-hMOrzAQeyHT4pYGExZR6eTRbPHSPK50GAkigCw@mail.gmail.com> <alpine.DEB.2.21.1910191156240.2098@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910191156240.2098@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 20 Oct 2019 15:12:44 -0700
X-Gmail-Original-Message-ID: <CALCETrXik5bzj-jQyHgqkzXqhYVJzedyD6WqBS+m+zmzKzCcDQ@mail.gmail.com>
Message-ID: <CALCETrXik5bzj-jQyHgqkzXqhYVJzedyD6WqBS+m+zmzKzCcDQ@mail.gmail.com>
Subject: Re: [PATCH] lib/vdso: Use __arch_use_vsyscall() to indicate fallback
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhc@lemote.com>, Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, Oct 19, 2019 at 3:01 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 19 Oct 2019, Huacai Chen wrote:
> > On Fri, Oct 18, 2019 at 11:15 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 7:57 PM Huacai Chen <chenhc@lemote.com> wrote:
> > > >
> > > > In do_hres(), we currently use whether the return value of __arch_get_
> > > > hw_counter() is negtive to indicate fallback, but this is not a good
> > > > idea. Because:
> > > >
> > > > 1, ARM64 returns ULL_MAX but MIPS returns 0 when clock_mode is invalid;
> > > > 2, For a 64bit counter, a "negtive" value of counter is actually valid.
> > >
> > > s/negtive/negative
> > >
> > > What's the actual bug?  Is it that MIPS is returning 0 but the check
> > > is < 0?  Sounds like MIPS should get fixed.
> > My original bug is what Vincenzo said, MIPS has a boot failure if no
> > valid clock_mode, and surely MIPS need to fix. However, when I try to
> > fix it, I found that clock_getres() has another problem, because
> > __cvdso_clock_getres_common() get vd[CS_HRES_COARSE].hrtimer_res, but
> > hrtimer_res is set in update_vdso_data() which relies on
> > __arch_use_vsyscall().
>
> __arch_use_vsyscall() is a pointless exercise TBH. The VDSO data should be
> updated unconditionally so all the trivial interfaces like time() and
> getres() just work independently of the functions which depend on the
> underlying clocksource.
>
> This functions have a fallback operation already:
>
> Let __arch_get_hw_counter() return U64_MAX and the syscall fallback is
> invoked.
>

My thought was that __arch_get_hw_counter() could return last-1 to
indicate failure, which would allow the two checks to be folded into
one check.  Or we could continue to use U64_MAX and rely on the fact
that (s64)U64_MAX < 0, not worry about the cycle counter overflowing,
and letting cycles < last catch it.

(And we should change it to return s64 at some point regardless -- all
the math is signed, so the underlying types should be too IMO.)
