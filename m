Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 14:45:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35797 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991119AbdGXMppKYosL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 14:45:45 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 677DDFF1C2EB9;
        Mon, 24 Jul 2017 13:45:36 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 24 Jul 2017 13:45:38 +0100
Received: from BADAG03.ba.imgtec.org (10.20.40.115) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 13:45:37 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 badag03.ba.imgtec.org ([fe80::5efe:10.20.40.115%12]) with mapi id
 14.03.0266.001; Mon, 24 Jul 2017 05:45:34 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To:     James Hogan <James.Hogan@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "Douglas Leung" <Douglas.Leung@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Petar Jovanovic" <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH v3 11/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix NaN
 propagation
Thread-Topic: [PATCH v3 11/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix NaN
 propagation
Thread-Index: AQHTAit/SvXBAKyY40KYXcnAouqzcaJjPv0A//+d87M=
Date:   Mon, 24 Jul 2017 12:45:33 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015D9C3A0F@BADAG02.ba.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-12-git-send-email-aleksandar.markovic@rt-rk.com>,<20170724102412.GP6973@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170724102412.GP6973@jhogan-linux.le.imgtec.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Aleksandar.Markovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@imgtec.com
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

> _______________________________________
> From: James Hogan
> Sent: Monday, July 24, 2017 3:24 AM
> To: Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Aleksandar Markovic; Miodrag Dinic; Goran Ferenc; Douglas Leung; linux-> kernel@vger.kernel.org; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle
> Subject: Re: [PATCH v3 11/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix NaN propagation
> 
> On Fri, Jul 21, 2017 at 04:09:09PM +0200, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> >
> > Fix the cases of <MADDF|MSUBF>.<D|S> when any of three inputs is any
> > NaN. Correct behavior of <MADDF|MSUBF>.<D|S> fd, fs, ft is following:
> >
> >   - if any of inputs is sNaN, return a sNaN using following rules: if
> >     only one input is sNaN, return that one; if more than one input is
> >     sNaN, order of precedence for return value is fd, fs, ft
> >   - if no input is sNaN, but at least one of inputs is qNaN, return a
> >     qNaN using following rules: if only one input is qNaN, return that
> >     one; if more than one input is qNaN, order of precedence for
> >     return value is fd, fs, ft
> >
> > The previous code contained handling of some above cases, but not all.
> > Also, such handling was scattered into various cases of
> > "switch (CLPAIR(xc, yc))" statement and elsewhere. With this patch,
> > this logic is placed in one place, and "switch (CLPAIR(xc, yc))" is
> > significantly simplified.
> >
> > The relevant example:
> >
> > MADDF.S fd,fs,ft:
> >   If fs contains qNaN1, ft contains qNaN2, and fd contains qNaN3, fd
> >   is going to contain qNaN3 (without this patch, it used to contain
> >   qNaN1).
> >
> 
> Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
> Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction")
> 

In v4, I will add these lines to commit messages of all MADDF/MSUBF patches from this series.

> > Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> > Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> 
> > If backported, I suspect commits:
> > 6162051e87f6 ("MIPS: math-emu: Unify ieee754sp_m{add,sub}f")
> > and
> > d728f6709bcc ("MIPS: math-emu: Unify ieee754dp_m{add,sub}f")
> > in 4.7 will require manual backporting between 4.3 and 4.7 (due to
> > separation of maddf/msubf before that point), so I suppose tagging
> > stable 4.7+ and backporting is best (assuming you consider this fix
> > worth backporting).

I am going to tag all MADDF/MSUBF patches "stable 4.7+" and all MIN/MAX/MINA/MAXA patches "stable 4.3+" in v4.

> > ---
> >  arch/mips/math-emu/dp_maddf.c | 71 ++++++++++++++-----------------------------
> >  arch/mips/math-emu/sp_maddf.c | 69 ++++++++++++++---------------------------
> >  2 files changed, 46 insertions(+), 94 deletions(-)
> ...
> > +     /* handle the cases when at least one of x, y or z is a NaN */
> > +     if (((xc == IEEE754_CLASS_SNAN) || (xc == IEEE754_CLASS_QNAN)) ||
> > +         ((yc == IEEE754_CLASS_SNAN) || (yc == IEEE754_CLASS_QNAN)) ||
> > +         ((zc == IEEE754_CLASS_SNAN) || (zc == IEEE754_CLASS_QNAN))) {
> 
> This condition basically covers all of the cases below. Any particular
> reason not to skip it ...
> > +             /* order of precedence is z, x, y */
> > +             if (zc == IEEE754_CLASS_SNAN)
> > +                     return ieee754dp_nanxcpt(z);
> > +             if (xc == IEEE754_CLASS_SNAN)
> > +                     return ieee754dp_nanxcpt(x);
> > +             if (yc == IEEE754_CLASS_SNAN)
> > +                     return ieee754dp_nanxcpt(y);
> > +             if (zc == IEEE754_CLASS_QNAN)
> > +                     return z;
> > +             if (xc == IEEE754_CLASS_QNAN)
> > +                     return x;
> >               return y;
> 
> ... and make this return conditional on (yc == IEEE754_CLASS_QNAN)?

You are right. I am going to reorganize the code as you suggested in v4.

Regards,
Aleksandar
From Aleksandar.Markovic@imgtec.com Mon Jul 24 14:49:31 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 14:49:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41516 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992241AbdGXMtbFU2vL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 14:49:31 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0B10485C780BE;
        Mon, 24 Jul 2017 13:49:23 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 24 Jul 2017 13:49:25 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 13:49:24 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([fe80::5efe:10.20.40.28%12]) with mapi id
 14.03.0266.001; Mon, 24 Jul 2017 05:49:21 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To:     James Hogan <James.Hogan@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        "Goran Ferenc" <Goran.Ferenc@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Petar Jovanovic" <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH v3 12/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some
 cases of infinite inputs
Thread-Topic: [PATCH v3 12/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some
 cases of infinite inputs
Thread-Index: AQHTAiuC+KNiv21WwkOy0h2g1ZtpS6JjQzEA//+uPJM=
Date:   Mon, 24 Jul 2017 12:49:20 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015D9C3A2C@BADAG02.ba.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-13-git-send-email-aleksandar.markovic@rt-rk.com>,<20170724103914.GQ6973@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170724103914.GQ6973@jhogan-linux.le.imgtec.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Aleksandar.Markovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@imgtec.com
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
Content-Length: 1116
Lines: 24

> 
> ________________________________________
> From: James Hogan
> Sent: Monday, July 24, 2017 3:39 AM
> To: Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Aleksandar Markovic; Douglas Leung; Miodrag Dinic; Goran Ferenc; linux-kernel@vger.kernel.org; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf > Baechle
> Subject: Re: [PATCH v3 12/16] MIPS: math-emu: <MADDF|MSUBF>.<D|S>: Fix some cases of infinite inputs
> 
> On Fri, Jul 21, 2017 at 04:09:10PM +0200, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> >
> > Fix the cases of <MADDF|MSUBF>.<D|S> when any of two multiplicands is
> > infinity. The correct behavior in such cases is affected by the nature
> > of third input. Cases of addition of infinities with opposite signs
> > and subtraction of infinities with same signs may arise and must be
> > handles separately. Also, the value od flags argument (that determines
> 
> s/handles/handled/?
> s/od/of/

In v4, I am going to fix these typos and also other typos and spelling mistakes
in commit messages of all patches in this series.

Thanks,
Aleksandar
From Aleksandar.Markovic@imgtec.com Mon Jul 24 14:51:31 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 14:51:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9763 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992241AbdGXMva3KVDL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 14:51:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 75DE88F8A4488;
        Mon, 24 Jul 2017 13:51:22 +0100 (IST)
Received: from BADAG03.ba.imgtec.org (10.20.40.115) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 13:51:24 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 badag03.ba.imgtec.org ([fe80::5efe:10.20.40.115%12]) with mapi id
 14.03.0266.001; Mon, 24 Jul 2017 05:51:21 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To:     James Hogan <James.Hogan@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "Douglas Leung" <Douglas.Leung@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Petar Jovanovic" <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH v3 08/16] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases
 of input values with opposite signs
Thread-Topic: [PATCH v3 08/16] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases
 of input values with opposite signs
Thread-Index: AQHTAitycG1MTSVZqUCSgLsMgSkGz6Je4MuAgAQRkpM=
Date:   Mon, 24 Jul 2017 12:51:20 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015D9C3A3B@BADAG02.ba.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-9-git-send-email-aleksandar.markovic@rt-rk.com>,<20170721154201.GM6973@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170721154201.GM6973@jhogan-linux.le.imgtec.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Aleksandar.Markovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@imgtec.com
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
Content-Length: 1252
Lines: 28

> 
> ________________________________________
> From: James Hogan
> Sent: Friday, July 21, 2017 8:42 AM
> To: Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Aleksandar Markovic; Miodrag Dinic; Goran Ferenc; Douglas Leung; linux-kernel@vger.kernel.org; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle
> Subject: Re: [PATCH v3 08/16] MIPS: math-emu: <MAXA|MINA>.<D|S>: Fix cases of input values with opposite signs
> 
> On Fri, Jul 21, 2017 at 04:09:06PM +0200, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> >
> > Fix the value returned by <MAXA|MINA>.<D|S>, if inputs are normal fp
> > numbers of the same absolute value, but opposite signs.
> >
> > The relevant example:
> >
> > MAXA.S fd,fs,ft:
> >   If fs contains -3, and ft contains +3, fd is going to contain +3
> >   (without this patch, it used to contain -3).
> 
> I think its worth mentioning also that for MINA.*, it returns the
> negative one when the absolute values are equal (The phrase "For equal
> absolute values, returns the smallest positive argument" in the manual
> is a bit ambiguous IMO, so I ended up checking what I6500 did).

I am going to slightly rephrase the commit messege to address this.

Regards,
Aleksandar
From Aleksandar.Markovic@imgtec.com Mon Jul 24 15:36:16 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 15:36:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57704 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991119AbdGXNgQHPUTz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 15:36:16 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 798D21653A628;
        Mon, 24 Jul 2017 14:36:07 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Jul
 2017 14:36:09 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([fe80::5efe:10.20.40.28%12]) with mapi id
 14.03.0266.001; Mon, 24 Jul 2017 06:36:06 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To:     James Hogan <James.Hogan@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "Douglas Leung" <Douglas.Leung@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Petar Jovanovic" <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH v3 05/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix
 quiet NaN propagation
Thread-Topic: [PATCH v3 05/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>:
 Fix quiet NaN propagation
Thread-Index: AQHTAitmv0L4IhaR1UeYohnOc8UbGKJe0OIAgAQiJ3M=
Date:   Mon, 24 Jul 2017 13:36:05 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015D9C3A72@BADAG02.ba.imgtec.org>
References: <1500646206-2436-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500646206-2436-6-git-send-email-aleksandar.markovic@rt-rk.com>,<20170721144504.GJ6973@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170721144504.GJ6973@jhogan-linux.le.imgtec.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Aleksandar.Markovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@imgtec.com
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
Content-Length: 3670
Lines: 106

Hi, James,

I appreciate your thorough and expeditious review.

> 
> ________________________________________
> From: James Hogan
> Sent: Friday, July 21, 2017 7:45 AM
> To: Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Aleksandar Markovic; Miodrag Dinic; Goran Ferenc; Douglas Leung; linux-kernel@vger.kernel.org; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle
> Subject: Re: [PATCH v3 05/16] MIPS: math-emu: <MAX|MAXA|MIN|MINA>.<D|S>: Fix quiet NaN propagation
> 
> On Fri, Jul 21, 2017 at 04:09:03PM +0200, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> >
> > Fix the value returned by <MAX|MAXA|MIN|MINA>.<D|S>, if both inputs
> > are quiet NaNs. The specifications of <MAX|MAXA|MIN|MINA>.<D|S> state
> > that the returned value in such cases should be the quiet NaN
> > contained in register fs.
> >
> > The relevant example:
> >
> > MAX.S fd,fs,ft:
> >   If fs contains qNaN1, and ft contains qNaN2, fd is going to contain
> >   qNaN1 (without this patch, it used to contain qNaN2).
> >
> 
> Consider adding:
> 
> Fixes: a79f5f9ba508 ("MIPS: math-emu: Add support for the MIPS R6 MAX{, A} FPU instruction")
> Fixes: 4e9561b20e2f ("MIPS: math-emu: Add support for the MIPS R6 MIN{, A} FPU instruction")
> 

Will add in v4 (for all MIN/MAX/MINA/MAXa patches).

> > Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> > Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> 
> Consider adding:
> 
> Cc: <stable@vger.kernel.org> # 4.3+

Will add on v4 (for all MIN/MAX/MINA/MAXA patches).

> > ---
> >  arch/mips/math-emu/dp_fmax.c | 8 ++++++--
> >  arch/mips/math-emu/dp_fmin.c | 8 ++++++--
> >  arch/mips/math-emu/sp_fmax.c | 8 ++++++--
> >  arch/mips/math-emu/sp_fmin.c | 8 ++++++--
> >  4 files changed, 24 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
> > index fd71b8d..567fc33 100644
> > --- a/arch/mips/math-emu/dp_fmax.c
> > +++ b/arch/mips/math-emu/dp_fmax.c
> > @@ -47,6 +47,9 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
> >       case CLPAIR(IEEE754_CLASS_SNAN, IEEE754_CLASS_INF):
> >               return ieee754dp_nanxcpt(x);
> >
> > +     case CLPAIR(IEEE754_CLASS_QNAN, IEEE754_CLASS_QNAN):
> > +             return x;
> 
> couldn't the above...
> 
> > +
> >       /* numbers are preferred to NaNs */
> >       case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_QNAN):
> >       case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_QNAN):
> > @@ -54,7 +57,6 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
> 
> ... go somewhere around here and fall through to the existing return x
> case?
> 

It could, but at the expense of code clarity and/or logical grouping of special cases,
which after this patch looks like:

               . . .
                 |
  case of both inputs qNaN
                 |
  case of only x input qNaN
                 |
  case of only y input qNaN
                 |
               . . .

If you agree, I suggest keeping the code the same as currently proposed in
this patch, except that the following comments should be added in appropriate
places:

	/*
	 * Quiet NaN handling
	 */
	/* The case of both inputs quiet NaNs */
   . . .
	/* The cases of exactly one input quiet NaN */

Unfortunately, the code segment for handling of sNaN and infinity inputs do
not follow the organization that I proposed. However, I think that my proposal
for case organization is the superior one - therefore I intend to keep it in v4,
unless you tell me not to do so.

Regards,
Aleksandar
