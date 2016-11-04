Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 17:55:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63707 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993082AbcKDQzMBlaRv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 17:55:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A25C1A7B40FAF;
        Fri,  4 Nov 2016 16:55:02 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 4 Nov 2016 16:55:05 +0000
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 HHMAIL-X.hh.imgtec.org ([fe80::3509:b0ce:371:2b%18]) with mapi id
 14.03.0294.000; Fri, 4 Nov 2016 16:55:05 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>
Subject: RE: [PATCH] MIPS: VDSO: Always select -msoft-float
Thread-Topic: [PATCH] MIPS: VDSO: Always select -msoft-float
Thread-Index: AQHSNpqpZSKpsmkzvECGzdemX2t3KKDIyilQgAAoI4CAAAwsgIAACz2A
Date:   Fri, 4 Nov 2016 16:55:05 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235380AB822B@HHMAIL01.hh.imgtec.org>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net>
 <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk>
 <20161101233038.GA25472@roeck-us.net>
 <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
 <20161104152603.GB12009@roeck-us.net>
 <alpine.DEB.2.00.1611041558460.13938@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1611041558460.13938@tp.orcam.me.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.105]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Maciej Rozycki <Maciej.Rozycki@imgtec.com> writes:
> On Fri, 4 Nov 2016, Guenter Roeck wrote:
> 
> > > As above, unless absolutely critical to have floating point code
> > > then the vDSO should just avoid all FP related issues and build
> soft-float.
...
> > Anyway, isn't the kernel supposed to not use floating point operations
> > in the first place ? Is this different for vDSO ?
> 
>  This code is executed in the user mode so while floating-point code may
> not be needed there, not at least right now, there's actually nothing
> which should stop us from from adding some should such a need arise.

Indeed. For now though the switch to -msoft-float is the simplest solution
isn't it?

Matthew
