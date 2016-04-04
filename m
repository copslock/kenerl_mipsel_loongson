Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 10:40:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42924 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014185AbcDDIkW5Qj5S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 10:40:22 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 998E73AE166DF;
        Mon,  4 Apr 2016 09:40:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 4 Apr 2016 09:40:17 +0100
Received: from localhost (10.100.200.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 4 Apr
 2016 09:40:16 +0100
Date:   Mon, 4 Apr 2016 09:40:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Qais Yousef <qsyousef@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
Message-ID: <20160404084015.GB14758@NP-P-BURTON>
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
 <20160401124852.GA5145@NP-P-BURTON>
 <56FFB8B7.8050607@gmail.com>
 <20160404064140.GA1368@NP-P-BURTON>
 <20160404080222.GA15222@linux-mips.org>
 <20160404080654.GA14758@NP-P-BURTON>
 <CA+mqd+7YA5JH=CfLBV9S-c+0aQw=NHihT+WyPvgUF6UkmK+tEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CA+mqd+7YA5JH=CfLBV9S-c+0aQw=NHihT+WyPvgUF6UkmK+tEQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.28]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Mon, Apr 04, 2016 at 09:28:16AM +0100, Qais Yousef wrote:
> On 4 Apr 2016 09:06, "Paul Burton" <paul.burton@imgtec.com> wrote:
> >
> > On Mon, Apr 04, 2016 at 10:02:23AM +0200, Ralf Baechle wrote:
> > > FYI, Qais' initial fix is in the pull request I sent to Linus yesterday
> so
> > > any fixes please relative to that patch.
> >
> > Hi Ralf,
> >
> > To late - I already submitted:
> >
> >     https://patchwork.linux-mips.org/patch/13003/
> >
> > I can rebase, but it'll be a revert of Qais' workaround followed by
> > mine & squashed.
> >
> > Thanks,
> >     Paul
> 
> Removing BUG_ON () is the real workaround.

Hi Qais,

They're both workarounds. I think given the point in the cycle that
we're at now it's the best option for now.

> The problem with Malta is that it always selects GIC even when it does
> not have it.

No, that's by design. GIC support can be enabled in Kconfig & the actual
presence of a GIC is detected at runtime. A kernel with GIC support can
run on a system with or without a GIC.

> If you add 2 ipi domains then you need to add a way to tell the platform
> which one to use.

Then we may need some way to do that, or perhaps it'll be OK if we only
register one of them on any given system. As mentioned I haven't really
deciphered this IPI IRQ domain code yet.

> All of the patches I sent were sent for review and were around for a long
> time. There's no need for the passive aggressiveness please because you
> found a problem now. Everything went through the formal process and you and
> everyone had a chance to comment and raise issues out.

Passive agressiveness? Really?

I'm not complaining about your patches having being merged. I haven't
said you failed to follow any process. I didn't have time to review your
patches, and clearly nobody else spotted this either, and a regression
has snuck into mainline. I simply want to fix it. I would also have
liked to find some documentation since it's difficult to figure out how
to add support for the single-core multi-VPE software interrupt case,
but that's the only criticism I've made of the patches & I think it's
just. Please don't be so personal...

> My idea of a fix is to get config dependencies sorted but I'll leave it
> with you and Ralf.

As I tried to explain before and above, we don't have all of the
required information until runtime, so Kconfig cannot solve this. That
won't work.

Thanks,
    Paul
