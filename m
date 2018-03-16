Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2018 00:14:26 +0100 (CET)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:48534 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994647AbeCPXOT73fDY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Mar 2018 00:14:19 +0100
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1ewyXv-0001Zn-00; Fri, 16 Mar 2018 23:13:59 +0000
Date:   Fri, 16 Mar 2018 19:13:59 -0400
From:   Rich Felker <dalias@libc.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huacai Chen <chenhc@lemote.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
Message-ID: <20180316231359.GU1436@brightrain.aerifal.cx>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
 <20180316151337.f277e3a734326672d41cec61@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316151337.f277e3a734326672d41cec61@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dalias@aerifal.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@libc.org
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

On Fri, Mar 16, 2018 at 03:13:37PM -0700, Andrew Morton wrote:
> On Fri, 16 Mar 2018 15:55:16 +0800 Huacai Chen <chenhc@lemote.com> wrote:
> 
> > Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> > stack checking always fails for decompress_kernel() itself. So remove
> > __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> > call decompress_kernel().
> > 
> > Original code comes from ARM but also used for MIPS and SH, so fix them
> > together. If without this fix, compressed booting of these archs will
> > fail because stack checking is enabled by default (>=4.16).
> > 
> > ...
> >
> >  arch/arm/boot/compressed/head.S        | 4 ++++
> >  arch/arm/boot/compressed/misc.c        | 7 -------
> >  arch/mips/boot/compressed/decompress.c | 7 -------
> >  arch/mips/boot/compressed/head.S       | 4 ++++
> >  arch/sh/boot/compressed/head_32.S      | 8 ++++++++
> >  arch/sh/boot/compressed/head_64.S      | 4 ++++
> >  arch/sh/boot/compressed/misc.c         | 7 -------
> >  7 files changed, 20 insertions(+), 21 deletions(-)
> 
> Perhaps this should be split into three patches and each one routed via
> the appropriate arch tree maintainer (for sh, that might be me).

Apologies for that. I'm trying to pick back up on things now, now that
I've got both some downtime from other things and funding for core sh
maintenance stuff. If you know any issues you'd especially like me to
put my attention on now, please let me know. I have a few patches
queued up from myself and others, but I believe there's a lot more I
haven't been able to get to for quite a while. I should have new SH
hardware to test on soon and in the meantime I've improved my qemu
setup.

One question I have about this specific patch is why any code is
needed at all. Why can't __stack_chk_guard just be moved to
initialized data, or left uninitialized, for the compressed kernel
image loader? Assuming it is needed, the code looks ok, but I question
the premise.

Rich
