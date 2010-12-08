Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2010 22:21:54 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:51463 "EHLO www.tglx.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492058Ab0LHVVp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Dec 2010 22:21:45 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
        by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id oB8LL4vV026820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 8 Dec 2010 22:21:05 +0100
Date:   Wed, 8 Dec 2010 22:21:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     David Daney <ddaney@caviumnetworks.com>,
        Anoop P A <anoop.pa@gmail.com>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Introduce mips_late_time_init
In-Reply-To: <20101208203704.GB30923@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1012082217230.2653@localhost6.localdomain6>
References: <1291623812.31822.6.camel@paanoop1-desktop> <4CFD2095.9040404@caviumnetworks.com> <20101208203704.GB30923@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.3 at www.tglx.de
X-Virus-Status: Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Wed, 8 Dec 2010, Ralf Baechle wrote:
> Running everything from late_time_init() instead allows the use of kmalloc.
> X86 has the same issue with requiring kmalloc in time_init which is why
> they had moved everything to late_time_init.

It's more ioremap, but yeah.
 
> So the real question is, why can't we just move the call of time_init()
> in setup_kernel() to where late_time_init() is getting called from for
> all architectures, does anything rely on it getting called early?

That's a good question and I asked it myself already. I can't see a
real reason why something would need it early. Definitely worth to
try.

Thanks,

	tglx
