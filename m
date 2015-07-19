Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Jul 2015 02:26:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41249 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011369AbbGSAZ6DZk7n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Jul 2015 02:25:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6J0Ppwd019555;
        Sun, 19 Jul 2015 02:25:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6J0PgMr019554;
        Sun, 19 Jul 2015 02:25:42 +0200
Date:   Sun, 19 Jul 2015 02:25:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <james.hogan@imgtec.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [PATCH 04/16] MIPS: use struct mips_abi offsets to save FP
 context
Message-ID: <20150719002542.GA5090@linux-mips.org>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
 <1436540426-10021-5-git-send-email-paul.burton@imgtec.com>
 <CAP=VYLr-DAi0TGuDiSZSeceKQ=Bb6Z9UXNZ=eBKVeP0g1SpOhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP=VYLr-DAi0TGuDiSZSeceKQ=Bb6Z9UXNZ=eBKVeP0g1SpOhg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sat, Jul 18, 2015 at 08:21:53PM -0400, Paul Gortmaker wrote:
> Date:   Sat, 18 Jul 2015 20:21:53 -0400
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> To: Paul Burton <paul.burton@imgtec.com>
> Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Matthew
>  Fortune <matthew.fortune@imgtec.com>, Leonid Yegoshin
>  <Leonid.Yegoshin@imgtec.com>, Michael Ellerman <mpe@ellerman.id.au>, LKML
>  <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, James
>  Hogan <james.hogan@imgtec.com>, Andy Lutomirski <luto@amacapital.net>,
>  Markos Chandras <markos.chandras@imgtec.com>, Ralf Baechle
>  <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>, "Maciej W.
>  Rozycki" <macro@codesourcery.com>, "linux-next@vger.kernel.org"
>  <linux-next@vger.kernel.org>
> Subject: Re: [PATCH 04/16] MIPS: use struct mips_abi offsets to save FP
>  context
> Content-Type: text/plain; charset=UTF-8
> 
> On Fri, Jul 10, 2015 at 11:00 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> > When saving FP state to struct sigcontext, make use of the offsets
> > provided by struct mips_abi to obtain appropriate addresses for the
> > sc_fpregs & sc_fpc_csr fields of the sigcontext. This is done only for
> > the native struct sigcontext in this patch (ie. for O32 in CONFIG_32BIT
> > kernels or for N64 in CONFIG_64BIT kernels) but is done in preparation
> > for sharing this code with compat ABIs in further patches.
> >
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > ---
> >
> >  arch/mips/kernel/r4k_fpu.S       | 151 +++++++++++++++++++++------------------
> >  arch/mips/kernel/signal-common.h |   6 ++
> >  arch/mips/kernel/signal.c        |  85 +++++++++++++++-------
> >  3 files changed, 145 insertions(+), 97 deletions(-)
> >
> 
>  The current version of this in linux-next picked up a booger in transit.
> 
> $ git show 6775b4ea74d5922e5310b7b7a902a8fbe61a0c9d|diffstat
>  arch/mips/kernel/r4k_fpu.S       |  151 ++++++++++++++++++++-------------------
>  arch/mips/kernel/signal-common.h |    6 +
>  arch/mips/kernel/signal.c        |   85 ++++++++++++++-------
>  index.html                       |   16 ++++
>  4 files changed, 161 insertions(+), 97 deletions(-)
> 
> Guessing it happened at Ralf's end.

Yes and I fixed a few hours ago.  Should be ok in the next -next.

  Ralf
