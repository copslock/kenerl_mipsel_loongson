Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 02:09:59 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:45299 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995191AbdHIAJnbI2np (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Aug 2017 02:09:43 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7716AEE0;
        Wed,  9 Aug 2017 00:09:42 +0000 (UTC)
Date:   Wed, 9 Aug 2017 02:09:42 +0200
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@redhat.com>, Michal Marek <mmarek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, Petr Mladek <pmladek@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] exec: Avoid recursive modprobe for binary format
 handlers
Message-ID: <20170809000942.GV27873@wotan.suse.de>
References: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com>
 <20170802001200.GD18884@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802001200.GD18884@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <lurodriguez@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59450
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

On Wed, Aug 02, 2017 at 02:12:00AM +0200, Luis R. Rodriguez wrote:
> On Fri, Jul 21, 2017 at 03:05:20PM +0100, Matt Redfearn wrote:
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 62175cbcc801..004bb50a01fe 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1644,6 +1644,9 @@ int search_binary_handler(struct linux_binprm *bprm)
> >  		if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
> >  		    printable(bprm->buf[2]) && printable(bprm->buf[3]))
> >  			return retval;
> > +		/* Game over if we need to load a module to execute modprobe */
> > +		if (strcmp(bprm->filename, modprobe_path) == 0)
> > +			return retval;
> 
> Wouldn't this just break having a binfmt used for modprobe always?

The place where you put the check is when a system has CONFIG_MODULES
and a first search for built-in handlers yielded no results so it would
not break that for built-in.

Thinking about this a little further, having an binfmd handler not built-in
seems to really be the issue in this particular case and indeed having one as
modular really just makes no sense as modprobe would be needed.

Although the alternative patch I suggested still makes sense for a *generic
loop detection complaint/error fix, putting this check in place and bailing
still makes sense as well, but this sort of thing seems to be the type of
system build error userspace could try to pick up on pro-actively, ie you
should not get to the point you boot into this, the build system should somehow
complain about it.

Cc'ing linux-modules folks to see if perhaps kmod could do something about this
more proactively.

Ideally if we could do this via kconfig for an architecture that'd be even
better but its not clear if this sort of thing is visible for MIPS on kconfig,
so kmod could be a next place to look for.

We'd need userpace kmod to verify the binary format for modprobe / kmod was
built-in otherwise fail.

> This also does not solve another issue I could think of now:
> 
> The *old* implementation would also prevent a set of binaries to daisy chain
> a set of 50 different binaries which require different binfmt loaders. The
> current implementation enables this and we'd just wait. There's a bound to
> the number of binfmd loaders though, so this would be bounded. If however
> a 2nd loader loaded the first binary we'd run into the same issue I think.

Upon testing -- the 2nd loader will not incur another new bump on kmod
concurrent given the original module would have a struct module already
present on the modules list, so these loops don't create a kmod concurrent
bump, they just keep the system waiting forever.

userspace kmod detects these sorts of loops but only for symbol references,
it doesn't check for request_module() calls, and even if it did, it would
then have to also consider aliasing.

kmod handles loops through export symbols references, it won't let a system
complete 'make modules_install' target as depmod will fail when this is
detected. The kmod git tree has some test for this, see
testsuite/module-playground/mod-loop* -- loading any of those yields an error
on modules_install target time as depmod picks it up:

depmod: ERROR: Found 7 modules in dependency cycles!
depmod: ERROR: Cycle detected: mod_loop_a -> mod_loop_b -> mod_loop_c -> mod_loop_a
depmod: ERROR: Cycle detected: mod_loop_a -> mod_loop_b -> mod_loop_c -> mod_loop_g
depmod: ERROR: Cycle detected: mod_loop_a -> mod_loop_b -> mod_loop_c -> mod_loop_f
depmod: ERROR: Cycle detected: mod_loop_d -> mod_loop_e -> mod_loop_d

So -- I will continue to submit the new generic alternative patch I suggested but
we should discuss this particular error further to try to more proactively
prevent it if possible.

It seems we already have in place userspace tools to prevent further loops, the
new warning should help catch others which escape our imagination at this time.
Two other types of issues would be desirable in the future for userspace
to detect proactively:

  o module loops using request_module() and aliases
  o when the modprobe binfmt is not built-in

  Luis
