Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 22:19:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57744 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994874AbdFPUTOVUFRV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 22:19:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CBE47C509857D;
        Fri, 16 Jun 2017 21:19:03 +0100 (IST)
Received: from [10.20.78.219] (10.20.78.219) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 21:19:07 +0100
Date:   Fri, 16 Jun 2017 21:18:56 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, <msalter@redhat.com>,
        <dmitry.torokhov@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Make individual platforms select
 ARCH_MIGHT_HAVE_PC_SERIO
In-Reply-To: <1ccd3748-9b52-2b23-f686-df86d8be050d@gmail.com>
Message-ID: <alpine.DEB.2.00.1706162110010.23046@tp.orcam.me.uk>
References: <20170605171033.15008-1-f.fainelli@gmail.com> <alpine.DEB.2.00.1706160249370.23046@tp.orcam.me.uk> <1ccd3748-9b52-2b23-f686-df86d8be050d@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.219]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58577
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

On Fri, 16 Jun 2017, Florian Fainelli wrote:

> >  How did you determine that?  Malta for one not only has an SMSC FDC37M817 
> > Super I/O Controller featuring an 8042-compatible core, but actual PS/2 
> > keyboard and mouse connectors as well.
> 
> I was just grepping for i8042 in platform code to determine that, this
> came after having SERIO accidentally enabled on my platform
> (BMIPS_GENERIC) and seeing that it crashed badly and it annoyed the crap
> out of me that MIPS had ARCH_MIGHT_HAVE_PC_SERIO for platforms that
> don't need it.
> 
> Will come up with a v2 that includes malta, any other platforms for
> which it's not obvious?

 I don't know offhand, but in principle anything that has PCI and a 
southbridge (not all PCI platforms have one, e.g. Broadcom SWARM and 
BigSur are legacy-free) can have an 8042 wired.  Ideally probing for 8042 
hardware should be done by platform code and the driver's init code would 
not be called at all if there's no 8042 present, similarly to how e.g. RTC 
is usually registered.

  Maciej
