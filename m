Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 04:11:05 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006516AbbEPCLBMaDPI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 04:11:01 +0200
Date:   Sat, 16 May 2015 03:11:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
cc:     David Daney <ddaney.cavm@gmail.com>,
        "aleksey.makarov@auriga.com" <aleksey.makarov@auriga.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "david.daney@cavium.com" <david.daney@cavium.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "davidlohr@hp.com" <davidlohr@hp.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH v2] MIPS64: Support of at least 48 bits of SEGBITS
In-Reply-To: <55564319.7020502@imgtec.com>
Message-ID: <alpine.LFD.2.11.1505160305100.4923@eddie.linux-mips.org>
References: <20150515013351.7450.12130.stgit@ubuntu-yegoshin> <55561EB6.4020009@gmail.com> <55564319.7020502@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47430
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

On Fri, 15 May 2015, Leonid Yegoshin wrote:

> > Many processors support larger VA space than is utilized by the kernel.
> >    A choice was made to reduce the size of the VA space in order to
> > reduce TLB handling overhead.
> >
> > If the true reason for the patch is to enable larger VA space, say that.
> >    But is it really required by those processors you mention?  I doubt it.
> 
> Well, I was not aware about many processors capability, I can't find this kind
> of note anywhere.

 The R10000 and friends all have a 44-bit virtual address space, so this 
is no news to Linux.  This is noted in <asm/processor.h> right above the 
change you made there.

  Maciej
