Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 21:13:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35688 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010745AbaJGTNuyfMrX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 21:13:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1A1191956D703;
        Tue,  7 Oct 2014 20:13:40 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 20:13:43 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 20:13:43 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 20:13:43 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 7 Oct 2014
 12:13:38 -0700
Message-ID: <54343B61.4020408@imgtec.com>
Date:   Tue, 7 Oct 2014 12:13:37 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <david.s.daney@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com> <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com> <20141006213101.GA23797@brightrain.aerifal.cx> <54330D79.80102@caviumnetworks.com> <20141006215813.GB23797@brightrain.aerifal.cx> <543327E7.4020608@amacapital.net> <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx> <543334CE.8060305@caviumnetworks.com> <20141007004915.GF23797@brightrain.aerifal.cx> <54337127.40806@gmail.com> <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org> <543431DA.4090809@imgtec.com> <5434343E.2090308@caviumnetworks.com>
In-Reply-To: <5434343E.2090308@caviumnetworks.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

(repeat it because of some e-mail failure, sorry)

On 10/07/2014 11:43 AM, David Daney wrote:

>> Five lines per instruction.
> But you must be able to emulate them, so you need an emulator, not XOL.

I feel I didn't say clear - emulation of ADDIUPC (after second look it
is the only instruction requires a special handling) is A FIVE LINE OF
CODE. At least in MIPS R2 it would require 5 lines. In MIPS R2 emulator
I have some routine (50 lines) which checks BD-slot instruction for some
popular opcodes and emulates that and leave other opcodes to dsemul().

The same can be done for FPU emulator.

> The problem is what to do with synchronous signals (SIGSEGV) Those
> cannot be held off, and you really want the EPC value saved in the
> register state to be correct.

Any synchronous exception is not a problem, we know that emulation in
VDSO (read today - stack) is running and should take care of it. We can
easily change EPC before we start doing signal and pretend that problem
happened in correct place.

The async signals seem to be some problem... yet... until I finish look
into common Linux kernel code, I think.


On 10/07/2014 11:44 AM, Andy Lutomirski wrote:

> What happens if one of those out-of-line instructions causes a synchronous trap?

If we need to return that as signal then we change EPC to proper value
from emulframe->epc. If we do a nested emulation - continue.

  > What if SIGSTOP arrives before ret?

I am looking into way to delay asynchronous signals until an emulated
instruction is finished. Signals are not time accurate and never been,
so it is not a big deal to delay it.


  > What if another thread removes the magic ret sequence?

It can't do it in my approach, emulation is done in write protected area
and it is done in per-thread memory space.

- Leonid.
