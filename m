Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2012 07:01:28 +0200 (CEST)
Received: from ozlabs.org ([203.10.76.45]:48360 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901163Ab2HTFBX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Aug 2012 07:01:23 +0200
Received: by ozlabs.org (Postfix, from userid 1011)
        id C74072C0089; Mon, 20 Aug 2012 15:01:18 +1000 (EST)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix module.c build for 32 bit
In-Reply-To: <20120814151345.GB30856@linux-mips.org>
References: <87d32us55c.fsf@rustcorp.com.au> <1344332473-19842-1-git-send-email-jonas.gorski@gmail.com> <31154.1344872382@warthog.procyon.org.uk> <32504.1344953290@warthog.procyon.org.uk> <20120814151345.GB30856@linux-mips.org>
User-Agent: Notmuch/0.12 (http://notmuchmail.org) Emacs/23.3.1 (i686-pc-linux-gnu)
Date:   Mon, 20 Aug 2012 12:19:36 +0930
Message-ID: <87boi65lbz.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 34282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rusty@rustcorp.com.au
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 14 Aug 2012 17:13:45 +0200, Ralf Baechle <ralf@linux-mips.org> wrote:
> Fixes build failure introduced by "Make most arch asm/module.h files use
> asm-generic/module.h" by moving all the RELA processing code to a
> separate file to be used only for RELA processing on 64-bit kernels.
> 
>   CC      arch/mips/kernel/module.o
> arch/mips/kernel/module.c:250:14: error: 'reloc_handlers_rela' defined but not 
> used [-Werror=unused-variable]
> cc1: all warnings being treated as errors
> 
> make[6]: *** [arch/mips/kernel/module.o] Error 1
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> This is bigger than Jonas' suggested patch but far less #ifdefy.
> A minimal fix would be to add __maybe_unused to the definition of
> reloc_handlers_rela but imho __maybe_unused should be avoided where
> possible.
> 
> I tested this on top of today's -next but ideally to keep bisectability
> it should be applied early in the series before CONFIG_MODULES_USE_ELF_RELA
> is introduced which would require trivial tweaking arch/mips/kernel/Makefile
> tweaking.

OK, as suggested, applied as a separate patch (with a bit of tweaking),
and then modified David's patch to flip the condition in the Makefile.

This will sit in linux-next another cycle.

Cheers,
Rusty.
