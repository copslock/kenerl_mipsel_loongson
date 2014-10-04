Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2014 18:17:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4954 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010069AbaJDQRTRR0hE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Oct 2014 18:17:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 122A02D67E17A;
        Sat,  4 Oct 2014 17:17:09 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 4 Oct
 2014 17:17:12 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 4 Oct
 2014 17:17:11 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([::1]) with mapi id 14.03.0174.001; Sat, 4 Oct 2014
 09:17:04 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Zubair Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Davidlohr Bueso <davidlohr@hp.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        "alex@alex-smith.me.uk" <alex@alex-smith.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Crispin <blogic@openwrt.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "Manuel Lauss" <manuel.lauss@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Subject: Re: [PATCH 0/3] MIPS executable stack protection
Thread-Topic: [PATCH 0/3] MIPS executable stack protection
Thread-Index: AQHP34Gysxw0os/VaEewjedDoGfZbpwgDy6AgACAvYD//45ViA==
Date:   Sat, 4 Oct 2014 16:17:03 +0000
Message-ID: <vi8ojsasknll8us53fy9myb8.1412439420039@email.android.com>
References: <20141004030438.28569.85536.stgit@linux-yegoshin>
        <20141004082307.GS10583@worktop.programming.kicks-ass.net>,<CA+55aFynSp90n=jdUdmY7nq-9t4pHS82Tj-WfZOBfot7ip0hBw@mail.gmail.com>
In-Reply-To: <CA+55aFynSp90n=jdUdmY7nq-9t4pHS82Tj-WfZOBfot7ip0hBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42955
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

Linus, it works on CPU with hardware page table walker - MIPS P5600 aka Apache.

I was involved in architecture development of HTW and took care of it.


Linus Torvalds <torvalds@linux-foundation.org> wrote:


On Sat, Oct 4, 2014 at 1:23 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Oct 03, 2014 at 08:17:14PM -0700, Leonid Yegoshin wrote:
>> The following series implements an executable stack protection in MIPS.
>>
>> It sets up a per-thread 'VDSO' page and appropriate TLB support.
>
> So traditionally we've always avoided per-thread pages like that. What
> makes it worth it on MIPS?

Nothing makes it worth it on MIPS.

It may be easy to implement when you have all software-fill of TLB's,
but it's a mistake even then - because it means that you'll never be
able to do hardware TLB walkers.

And MIPS *does* have hardware TLB walkers, even if they are not
necessarily available everywhere.

So this is a horrible idea. Don't do it. Page tables need to be
per-process, not per thread, so that page tables can be shared.

              Linus
