Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2016 02:21:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55450 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992128AbcJCAVlblcWF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Oct 2016 02:21:41 +0200
Date:   Mon, 3 Oct 2016 01:21:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: dec: Avoid la pseudo-instruction in delay slots
In-Reply-To: <20160920123301.GN5881@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1609210301430.19345@eddie.linux-mips.org>
References: <20160902141902.2478-1-paul.burton@imgtec.com> <alpine.LFD.2.20.1609192323450.19345@eddie.linux-mips.org> <20160920123301.GN5881@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55309
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

On Tue, 20 Sep 2016, Ralf Baechle wrote:

> >  I take it it's a quest for a clean compilation with no warnings reported, 
> > as the message is otherwise harmless and correct code is produced here.
> > 
> >  Some of the systems affected are not necessarily fast (e.g. clocked at 
> > 12MHz), so I wonder if we shouldn't just bite the bullet and expand the 
> > %hi/%lo pair here.  Even with R4k DECstations we only support `-msym32' 
> > compilation only, due to R4k errata, so it's not like the higher parts 
> > will ever be needed for address calculation.
> > 
> >  Alternatively we could have a `.set warn'/`.set nowarn' setting in GAS, 
> > previously discussed I believe, although it would take a bit to propagate.
> 
> Yeah, I'm already looking into the other direction whenever this warning
> pops up - and it does so often.  I've even pondered submitting something
> like -Werror for gas ;-)

 Well, the GCC driver already handles it and catches warnings from GAS if 
requested, doesn't it?

> It's not very elegant but you could just open code everything, see below
> patch.  Compiles but not runtime tested due to lack of hardware.

 That's what I noted above and as also noted you only need the %hi/%lo 
variant due to the `-msym32' restriction for 64-bit DECstation kernels; 
the kernel is always linked to KSEG0.

 Alternatively for maximum safety perhaps we could define PTR_LA_EXPLICIT 
or suchlike with a suitable open-coded sequence for the pointer width 
chosen; note however that `-msym32' doesn't set any CPP's internal 
predefined macro, so we'd have to define our own to control this.

> Maciej, can you test this?

 I'll see what I can do; I've been travelling a lot lately.

  Maciej
