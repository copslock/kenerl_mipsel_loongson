Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 12:48:56 +0200 (CEST)
Received: from ozlabs.org ([203.10.76.45]:54275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903507Ab2HPKst (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 12:48:49 +0200
Received: by ozlabs.org (Postfix, from userid 1011)
        id 45CFF2C0096; Thu, 16 Aug 2012 20:48:45 +1000 (EST)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, Jonas Gorski <jonas.gorski@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: fix module.c build for 32 bit
In-Reply-To: <1171.1345019698@warthog.procyon.org.uk>
References: <87ipckrgal.fsf@rustcorp.com.au> <87d32us55c.fsf@rustcorp.com.au> <1344332473-19842-1-git-send-email-jonas.gorski@gmail.com> <31154.1344872382@warthog.procyon.org.uk> <32504.1344953290@warthog.procyon.org.uk> <1171.1345019698@warthog.procyon.org.uk>
User-Agent: Notmuch/0.12 (http://notmuchmail.org) Emacs/23.3.1 (i686-pc-linux-gnu)
Date:   Thu, 16 Aug 2012 20:10:25 +0930
Message-ID: <87a9xvce7a.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 34204
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

On Wed, 15 Aug 2012 09:34:58 +0100, David Howells <dhowells@redhat.com> wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > For a build fix????
> 
> Linux hasn't pulled the asm-generic cleanup patch yet - you missed the merge
> window, I think.  Jonas detected the problem in linux-next.

Yes, I missed the window but asked Linus to pull anyway.  Was delaying
for the other module patch, left it too long.

This cleanup won't benefit from more stewing in linux-next, since it sat
there for quite a while already.  Feel free to add my Acked-by and push
it straight to Linus, otherwise I'll roll them together for next window.

Thanks,
Rusty.
