Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 21:16:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46315 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVTQTTC5ZP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 21:16:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 94A7784E6623C;
        Tue, 22 Sep 2015 20:16:09 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 20:14:26 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 20:14:25 +0100
Date:   Tue, 22 Sep 2015 12:14:24 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/3] MIPS GIC fixes
Message-ID: <20150922191424.GC29903@NP-P-BURTON>
References: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
 <alpine.DEB.2.11.1509222106100.5606@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1509222106100.5606@nanos>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49334
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

On Tue, Sep 22, 2015 at 09:07:15PM +0200, Thomas Gleixner wrote:
> On Tue, 22 Sep 2015, Paul Burton wrote:
> 
> > This series fixes a couple of problems with the MIPS GIC support,
> > impacting systems with the 64 bit CM3 and those with multithreading and
> > non-contiguous numbering for VP(E)s across cores.
> > 
> > Paul Burton (3):
> >   MIPS: CM: provide a function to map from CPU to VP ID
> >   irqchip: mips-gic: convert CPU numbers to VP IDs
> >   irqchip: mips-gic: fix pending & mask reads for MIPS64 with 32b GIC
> 
> I assume that's a bugfix scheduled for 4.3.
> 
> Ralf, if so, please ship it through the MIPS tree with my Acked-by for
> the irqchip parts.
> 
> Thanks,
> 
> 	tglx

Hi Thomas,

These are fixes but to the best of my knowledge the only currently
supported system it would break is multicore I6400 on Malta, which only
exists in emulation at the moment. So it's probably not a huge deal to
get this into v4.3. If it's easy though, absolutely go ahead :)

I'll aim to be clearer when submitting future fixes about where they
apply.

Thanks,
    Paul
