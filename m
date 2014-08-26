Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 12:45:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51594 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006860AbaHZKpYdQGZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 12:45:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A79A559DF0AFF;
        Tue, 26 Aug 2014 11:45:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 26 Aug 2014 11:45:17 +0100
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0195.001; Tue, 26 Aug 2014 11:45:17 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: RE: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
Thread-Topic: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
Thread-Index: AQHPwHDE/dnGEcCXt0itDbFAumPAUJvhpBsAgAAHz4CAAP4REA==
Date:   Tue, 26 Aug 2014 10:45:16 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320EF70D1@LEMAIL01.le.imgtec.org>
References: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com>
 <20140825125107.GA25892@linux-mips.org>
 <alpine.LFD.2.11.1408251502140.18483@eddie.linux-mips.org>
 <CAOLZvyG4F_PCb5hbws1_e8nCeJ+odvnC5u=yitSe9CwY3TWZdw@mail.gmail.com>
 <alpine.LFD.2.11.1408252036420.18483@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1408252036420.18483@eddie.linux-mips.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.76]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42251
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

Maciej W. Rozycki <macro@linux-mips.org> writes:
> On Mon, 25 Aug 2014, Manuel Lauss wrote:
> 
> > > 1. Determine whether `-Wa,-msoft-float' and `.set hardfloat' are
> available
> > >    (a single check will do, they were added to GAS both at the same
> time)
> > >    and only enable them if supported by binutils being used to build
> the
> > >    kernel, e.g. (for the `.set' part):
> > >
> > > #ifdef GAS_HAS_SET_HARDFLOAT
> > > #define SET_HARDFLOAT .set      hardfloat
> > > #else
> > > #define SET_HARDFLOAT
> > > #endif
> > >
> > >    Otherwise we'd have to bump the binutils requirement up to 2.19;
> this
> >
> > Do people really update their toolchain so rarely?
> 
>  I don't know, but unless they're toolchain developers at the same time
> I'd expect some to stick with whatever they've found working.  The worst
> thing that can happen to you is when you need to upgrade the kernel to
> fix
> a critical bug, then the updated kernel requires newer tools and then
> the
> newer tools trigger a bunch of new bugs that you don't even know if they
> are kernel or toolchain bugs (or both).  So I don't want to force people
> to upgrade unless absolutely necessary (e.g. a microMIPS kernel), I'd
> rather let them do it whenever *they* feel comfortable doing it.

Rather than me give a bunch of comments here could someone confirm what
your (kernel perspective) opinion is of what should change?

From what I can tell it seems OK for pre-existing kernel releases to not
build with new tools from time to time. Also, it seems OK for currently
maintained branches to need a fix as long as it results in code which
can be built with old and new tools. This was my assumption when doing
the binutils work, it is just unfortunate that Manuel found the issue
before the kernel guys at Imagination had got round to discussing this
topic on the kernel list.

As a slight aside. Please do retain -msoft-float on kernel builds it is the
only way to ensure that no floating-point instructions are used even if
you have no 'float' or 'double' types. MIPS GCC relies on a cost model
to avoid floating point registers being used in the absence of floating
point types but this is not a guarantee. I do plan on working on this area
but it is non-trivial to say the least.

Regards,
Matthew
