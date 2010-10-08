Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 17:58:28 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491201Ab0JHP6Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Oct 2010 17:58:25 +0200
Date:   Fri, 8 Oct 2010 16:58:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: siginfo difference MIPS and other arches
Message-ID: <20101008155823.GB30185@linux-mips.org>
References: <AANLkTikXySeekzpYeGf6wuH5NTMxLCK_oirvBcDu4h63@mail.gmail.com>
 <20101008155319.GC12107@linux-mips.org>
 <AANLkTimYGDoRovYgbReeBihD2nfYFHE_CmwJjv2_=s7v@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimYGDoRovYgbReeBihD2nfYFHE_CmwJjv2_=s7v@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 08, 2010 at 05:55:01PM +0200, Manuel Lauss wrote:

> >> current -git build breaks because of upstream commit
> >> a337fdac7a5622d1e6547f4b476c14dfe5a2c892, which introduced
> >> an unconditional check for siginfo_._sifields._sifault._si_addr_lsb field.
> >>
> >> Is there a reason why MIPS doesn't use the default siginfo_t structure
> >> as other architectures do?
> >
> > History - the MIPS structure is identical to IRIX.
> 
> Does anyone still run IRIX binaries on current linux?
> (and Isn't IRIX dead anyway? :)  )

Doesn't matter - you can't change the definition without breaking
binary compatibility.

  Ralf
