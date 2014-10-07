Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 20:45:02 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:54847 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010743AbaJGSpBFT328 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 20:45:01 +0200
Received: by mail-la0-f44.google.com with SMTP id gb8so7063533lab.3
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 11:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=FPYeoe5YiSyM1uidi0bRyQI9yltJZLjXmzLodymgQzE=;
        b=XGmkrfwBv6RPXCZMBBxYZes26UQJ8nKeSSjuSgdxlNTVaZLdifSDac0JxQZ+HTUHBu
         u1Q4/xxQ2OLsjlXpgV5iGR/uAJcmfGd+tjij08dWOGWSaUDKFL1r7frbyc0m4syTCVgG
         +Jo9aQowhFQ0r1myle2n3Nh2cAPBuANsEjWU9+KJ/LKOvkp4G60Sc8NcwMqi0wDcka8x
         RHZ85GW78kmZJZZDNAH4BWkJKQxB5KgoBnpPrhYFhhA2H/RAVfqQXMB1ZwotWZSytc9m
         q+w0nRs0F0v1pH5oW7OzgL9FesAvHwFJZipkmDkRHI2ea215lJZxiHV0LjnSPUTo9pB7
         rpWQ==
X-Gm-Message-State: ALoCoQnSbvKJuhrj4wM0ngoGKpPHSwP60LFUuoZfvtX8gMl38lerkd3mxx3LrJGkhSdT0Mgg9VaV
X-Received: by 10.152.8.194 with SMTP id t2mr682012laa.85.1412707495508; Tue,
 07 Oct 2014 11:44:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 7 Oct 2014 11:44:35 -0700 (PDT)
In-Reply-To: <543431DA.4090809@imgtec.com>
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com>
 <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com>
 <20141006213101.GA23797@brightrain.aerifal.cx> <54330D79.80102@caviumnetworks.com>
 <20141006215813.GB23797@brightrain.aerifal.cx> <543327E7.4020608@amacapital.net>
 <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx>
 <543334CE.8060305@caviumnetworks.com> <20141007004915.GF23797@brightrain.aerifal.cx>
 <54337127.40806@gmail.com> <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org>
 <543431DA.4090809@imgtec.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 7 Oct 2014 11:44:35 -0700
Message-ID: <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <david.s.daney@gmail.com>,
        Rich Felker <dalias@libc.org>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Tue, Oct 7, 2014 at 11:32 AM, Leonid Yegoshin
<Leonid.Yegoshin@imgtec.com> wrote:
> Well, I am not a subscriber to mail-list, so I read it the first time and
> some notes:
>

>
> 3)  The signal happened during execution of emulated instruction - signals
> are under control of kernel and we can easily delay a signal during
> execution of emulated instruction until return from do_dsemulret. It is not
> a big deal - nor code, nor performance. Thank you for good point.

If you go down this particular rabbit hole, you will never come back out.

What happens if one of those out-of-line instructions causes a
synchronous trap?  What if SIGSTOP arrives before ret?  What if
another thread removes the magic ret sequence?

>
> 4)  The voice for doing any instruction emulation in kernel - it is not a
> MIPS business model to force customer to put details of all Coprocessor 2
> instructions public. We provide an interface and the rest is a customer
> business. Besides that it is really painful to make a differentiation
> between Cavium Octeon and some another CPU instructions with the same
> opcode. On other side, leaving emulation of their instructions to them is
> not a wise after having some good way doing that multiple years.

IMO this is all backwards.  If MIPS customers put proprietary
instructions into their ISA, they leave out the FPU, and they put a
proprietary insn in a branch delay slot, then I think that they
deserve a fatal signal.

There's a really easy solution for new systems: fix the toolchain.
Teach the assembler to disallow any proprietary instructions in an FP
branch delay slot.

--Andy
