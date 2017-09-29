Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Sep 2017 00:39:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3868 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992618AbdI2WjpyOm06 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Sep 2017 00:39:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CD3F2FEA75FED;
        Fri, 29 Sep 2017 23:39:34 +0100 (IST)
Received: from [10.20.78.110] (10.20.78.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Fri, 29 Sep 2017
 23:39:38 +0100
Date:   Fri, 29 Sep 2017 23:39:24 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Use SLL by 0 for 32-bit truncation in
 `__read_64bit_c0_split'
In-Reply-To: <20170929195925.GF17077@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1709292325010.12020@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709291502060.12020@tp.orcam.me.uk> <20170929195925.GF17077@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.110]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Fri, 29 Sep 2017, James Hogan wrote:

> >  NB if this turns out indeed used, then we might have to do something 
> > about DMFC0 hazard avoidance for the sake of MIPS III support, and also
> > choose to use an MFC0/MFHC0 instruction pair instead on MIPS64r5+.
> 
> This would have to depend on MVH bit, but in practice I suspect it isn't
> worthwhile doing it here instead of in a separate macro to use depending
> on the register.

 Boot-time patching would be more appropriate IMO.

> Using MVH would have the advantage of avoiding the potential window when
> a 32-bit EJTAG or Cache error handler potentially canonicalises register
> state I suppose.
> 
> That's another advantage of this patch actually, it reduces the size of
> that window to a single instruction.

 That still sounds scary and justifies the use of MFHC0 (and MTHC0 in 
`__write_64bit_c0_split') where available more than just the minuscule 
performance improvement.

 Thanks for your review.

  Maciej
