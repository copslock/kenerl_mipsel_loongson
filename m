Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 21:24:03 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:50269 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991726AbdHHTXyS6iFv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Aug 2017 21:23:54 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DC25ACF4;
        Tue,  8 Aug 2017 19:23:53 +0000 (UTC)
Date:   Tue, 8 Aug 2017 21:23:52 +0200
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jessica Yu <jeyu@redhat.com>, Michal Marek <mmarek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        ebiederm@xmission.com, mingo@redhat.com, peterz@infradead.org,
        Petr Mladek <pmladek@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] exec: Avoid recursive modprobe for binary format
 handlers
Message-ID: <20170808192352.GU27873@wotan.suse.de>
References: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com>
 <20170802001200.GD18884@wotan.suse.de>
 <CAGXu5jJw74M0hTL8JGUtshgZpGjzWia2d=oK3t8oJF6qo9Xp_A@mail.gmail.com>
 <20170802232331.GO18884@wotan.suse.de>
 <757118c9-45e2-9680-dca2-079d928d9b1c@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757118c9-45e2-9680-dca2-079d928d9b1c@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <lurodriguez@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcgrof@kernel.org
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

On Mon, Aug 07, 2017 at 11:26:09AM +0100, Matt Redfearn wrote:
> Hi Luis,
> On 03/08/17 00:23, Luis R. Rodriguez wrote:
> > On Tue, Aug 01, 2017 at 07:28:20PM -0700, Kees Cook wrote:
> > > On Tue, Aug 1, 2017 at 5:12 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > > On Fri, Jul 21, 2017 at 03:05:20PM +0100, Matt Redfearn wrote:
> > > > > Commit 6d7964a722af ("kmod: throttle kmod thread limit") which was
> > > > > merged in v4.13-rc1 broke this behaviour since the recursive modprobe is
> > > > > no longer caught, it just ends up waiting indefinitely for the kmod_wq
> > > > > wait queue. Hence the kernel appears to hang silently when starting
> > > > > userspace.
> > > > Indeed, the recursive issue were no longer expected to exist.
> > > Errr, yeah, recursive binfmt loads can still happen.
> > > 
> > > > The *old* implementation would also prevent a set of binaries to daisy chain
> > > > a set of 50 different binaries which require different binfmt loaders. The
> > > > current implementation enables this and we'd just wait. There's a bound to
> > > > the number of binfmd loaders though, so this would be bounded. If however
> > > > a 2nd loader loaded the first binary we'd run into the same issue I think.
> > > > 
> > > > If we can't think of a good way to resolve this we'll just have to revert
> > > > 6d7964a722af for now.
> > > The weird but "normal" recursive case is usually a script calling a
> > > script calling a misc format. Getting a chain of modprobes running,
> > > though, seems unlikely. I *think* Matt's patch is okay, but I agree,
> > > it'd be better for the request_module() to fail.
> > In that case how about we just have each waiter only wait max X seconds,
> > if the number of concurrent ongoing modprobe calls hasn't reduced by
> > a single digit in X seconds we give up on request_module() for the
> > module and clearly indicate what happened.
> > 
> > Matt, can you test?
> 
> Sure - I've tested patch this on Cavium Octeon under the same conditions as
> before (64 bit kernel with 32bit userspace & no binfmt handler builtin).
> 
> The failing modprobe is now caught and rather than silence we get the
> expected kernel panic, albeit all the warnings look quite noisy.

Thanks for testing! I agree its all too verbose, I'll clean that up and
resubmit with a cleaner log.

I tried to devise a test case for this but for the life of me I could not. If
you happen to come up with something please feel free to submit one for
lib/test_kmod.c!

> In any case, this is better than the 4.13-rc1 behavior, so
> 
> Tested-by: Matt Redfearn <matt.redfearn@imgetc.com>

 Luis
