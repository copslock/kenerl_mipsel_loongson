Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Oct 2014 07:53:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63911 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006668AbaJEFxCJzyKb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Oct 2014 07:53:02 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1C8BBC905F3A2;
        Sun,  5 Oct 2014 06:52:53 +0100 (IST)
Received: from BADAG01.ba.imgtec.org (10.20.40.113) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sun, 5 Oct
 2014 06:52:54 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 BADAG01.ba.imgtec.org ([fe80::8c38:df2b:fd93:33d3%14]) with mapi id
 14.03.0123.003; Sat, 4 Oct 2014 22:52:50 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Zubair Kakakhel <Zubair.Kakakhel@imgtec.com>,
        "david.daney@cavium.com" <david.daney@cavium.com>,
        "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
        "davidlohr@hp.com" <davidlohr@hp.com>,
        "macro@linux-mips.org" <macro@linux-mips.org>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "alex@alex-smith.me.uk" <alex@alex-smith.me.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Subject: RE: [PATCH 2/3] MIPS: Setup an instruction emulation in VDSO
 protected page instead of user stack
Thread-Topic: [PATCH 2/3] MIPS: Setup an instruction emulation in VDSO
 protected page instead of user stack
Thread-Index: AQHP4A3mSxaly1ppUki9Ol84kSztDpwg+HZf
Date:   Sun, 5 Oct 2014 05:52:49 +0000
Message-ID: <07BA03A3EAC1A04EA0314E65E59B049B6E70BFB5@BADAG02.ba.imgtec.org>
References: <20141004030438.28569.85536.stgit@linux-yegoshin>
 <20141004031730.28569.38511.stgit@linux-yegoshin>,<20141004200016.GB7509@worktop.ger.corp.intel.com>
In-Reply-To: <20141004200016.GB7509@worktop.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.40.117]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42959
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

From: Peter Zijlstra [peterz@infradead.org]:

>On Fri, Oct 03, 2014 at 08:17:30PM -0700, Leonid Yegoshin wrote:

>> --- a/arch/mips/include/asm/switch_to.h
> >+++ b/arch/mips/include/asm/switch_to.h

>Why raw_smp_processor_id() and why evaluate it 3 times, sure compilers
>can be expected to do some CSE but something like:
>
>        int cpu = smp_processor_id();
>
>        if ( ... [cpu] ...)
>
>is far more readable as well.

Sure. But may be it has sense to use raw_smp_processor_id() due to elevated preemption counter.


>> +     flush_vdso_page();                                              \

>So what I didn't see is any talk about the cost of this. Surely a TLB
>flush isn't exactly free.

Well, flush_vdso_page() uses a local version of TLB page flushing and it is cheap 'per se' in comparison with system-wide.
And I take precautions to flush only if it matches the same memory map, so it is the situation then one pthread on some map is replaced by some pthread on the same map on the same CPU.
So, it flushes only after real use in previous pthread of that map.

However, some performance loss can be expected due to killing TLB.
In low-end cores, with small TLB array we can expect that this TLB can be kicked off anyway after context switch.
In high end cores we should expect FPU unit available and float point emulation can be very rare (un-normalized operations or so).

The only question is a middle line which has enough TLB (32 or more) but may have no float point processor. However, the emulation itself is very slow and it is natural to expect performance degradation because of float point emulation here in much higher degree than possible penalty due to early loss of TLB element.
