Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 21:57:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55295 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006778AbaHYT5WADNBm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 21:57:22 +0200
Date:   Mon, 25 Aug 2014 20:57:21 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
In-Reply-To: <CAOLZvyG4F_PCb5hbws1_e8nCeJ+odvnC5u=yitSe9CwY3TWZdw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1408252036420.18483@eddie.linux-mips.org>
References: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com> <20140825125107.GA25892@linux-mips.org> <alpine.LFD.2.11.1408251502140.18483@eddie.linux-mips.org> <CAOLZvyG4F_PCb5hbws1_e8nCeJ+odvnC5u=yitSe9CwY3TWZdw@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 25 Aug 2014, Manuel Lauss wrote:

> > 1. Determine whether `-Wa,-msoft-float' and `.set hardfloat' are available
> >    (a single check will do, they were added to GAS both at the same time)
> >    and only enable them if supported by binutils being used to build the
> >    kernel, e.g. (for the `.set' part):
> >
> > #ifdef GAS_HAS_SET_HARDFLOAT
> > #define SET_HARDFLOAT .set      hardfloat
> > #else
> > #define SET_HARDFLOAT
> > #endif
> >
> >    Otherwise we'd have to bump the binutils requirement up to 2.19; this
> 
> Do people really update their toolchain so rarely?

 I don't know, but unless they're toolchain developers at the same time 
I'd expect some to stick with whatever they've found working.  The worst 
thing that can happen to you is when you need to upgrade the kernel to fix 
a critical bug, then the updated kernel requires newer tools and then the 
newer tools trigger a bunch of new bugs that you don't even know if they 
are kernel or toolchain bugs (or both).  So I don't want to force people 
to upgrade unless absolutely necessary (e.g. a microMIPS kernel), I'd 
rather let them do it whenever *they* feel comfortable doing it.

 Linux's generic requirement is binutils 2.12 or newer, I reckon we bumped 
the corresponding requirement for the MIPS port up a bit recently because 
of some braindamage in binutils 2.24 the workaround for which has some 
version limitations.  And I am not convinced it is a good idea to bump the 
requirement in such a short time again just because a GCC version to be 
released next year have become strictier about the FP ABI (that we don't 
use anyway).  Especially as the solution is so simple.

 I'm still at 2.20.1 as far as the MIPS target is concerned BTW, I just 
considered the time I'd have to spend on upgrading would be better spent 
on sorting out the kernel issues I've had outstanding, and there's been 
quite a bunch.

  Maciej
