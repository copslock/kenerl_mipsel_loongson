Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 02:12:10 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:60529 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993960AbdHBAMCVYmSm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Aug 2017 02:12:02 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A854AC54;
        Wed,  2 Aug 2017 00:12:01 +0000 (UTC)
Date:   Wed, 2 Aug 2017 02:12:00 +0200
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@redhat.com>, Michal Marek <mmarek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        linux-mips@linux-mips.org, Petr Mladek <pmladek@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] exec: Avoid recursive modprobe for binary format
 handlers
Message-ID: <20170802001200.GD18884@wotan.suse.de>
References: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <lurodriguez@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59314
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

On Fri, Jul 21, 2017 at 03:05:20PM +0100, Matt Redfearn wrote:
> When the kernel does not have a binary format handler for an executable
> it is attempting to load, when CONFIG_MODULES is enabled it will attempt
> to load a module for that format. If the kernel does not have a binary
> format handler for the modprobe executable, this will trigger another
> module load.

Ah fun.

> Previously this recursive module loading was caught and an
> error message printed informing the user that the executable could not
> be executed:
> 
> request_module: runaway loop modprobe binfmt-464c
> Starting init:/sbin/init exists but couldn't execute it (error -8)

Its incorrect to believe though that this message was coming up before
only after one cross dependency loop, it would only come up on we create
a loop which went over 50 requests. In this case this is caused because
the binfmt hander for modprobe is not loaded yet and it tries again to
load the bimfmd for it, which leads to the loop and > 50 limit reached.

modprobe binfmt for /sbin/init -- modprobe binfmt for modprobe --> loop

> Commit 6d7964a722af ("kmod: throttle kmod thread limit") which was
> merged in v4.13-rc1 broke this behaviour since the recursive modprobe is
> no longer caught, it just ends up waiting indefinitely for the kmod_wq
> wait queue. Hence the kernel appears to hang silently when starting
> userspace.

Indeed, the recursive issue were no longer expected to exist.

> This problem was observed when the binfmt handler for MIPS o32 binaries
> is not built in to a 64bit kernel and the root filesystem is o32 ABI.

I see!

Another way to see this is that the binfmt handler for modprobe should
be built-in, and its unclear if there is a sensible way to ensure this
with kconfig. Perhaps on some architectures it may be possible by not
allowing some binfmd handlers as modules, but I would be surprised if
this could be a general thing.

> Catch this by adding a guard to search_binary_handler(). If there is no
> binary format handler available to load an exectuable, and the
> executable matches modprobe_path, i.e. the userspace helper that would
> be executed to load a module, then do not attempt to load the module
> since it will just end up here again when it fails to execute. This
> actually improves the original behaviour since the "runaway loop"
> warning is no longer printed, and we simply get:
> 
> Starting init:/sbin/init exists but couldn't execute it (error -8)

Neat, indeed this error message is much more meaningful.

> Fixes: 6d7964a722af ("kmod: throttle kmod thread limit")
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
> 
> What we really need to detect is that exec'ing modprobe failed, but
> currently it does not get as far as an actual error since it just ends
> up stuck waiting for the modprobes to complete,

Well right, it won't return as the kernel is busy trying to load the
first binfmt for init by fist calling modprobe for the binfmt for...
modprobe.

> which they never will.

Yup.

> Open to suggestions of a different / better way to fix this.
> 
> Thanks,
> Matt
> 
> ---
>  fs/exec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 62175cbcc801..004bb50a01fe 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1644,6 +1644,9 @@ int search_binary_handler(struct linux_binprm *bprm)
>  		if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
>  		    printable(bprm->buf[2]) && printable(bprm->buf[3]))
>  			return retval;
> +		/* Game over if we need to load a module to execute modprobe */
> +		if (strcmp(bprm->filename, modprobe_path) == 0)
> +			return retval;

Wouldn't this just break having a binfmt used for modprobe always?

This also does not solve another issue I could think of now:

The *old* implementation would also prevent a set of binaries to daisy chain
a set of 50 different binaries which require different binfmt loaders. The
current implementation enables this and we'd just wait. There's a bound to
the number of binfmd loaders though, so this would be bounded. If however
a 2nd loader loaded the first binary we'd run into the same issue I think.

If we can't think of a good way to resolve this we'll just have to revert
6d7964a722af for now.

>  		if (request_module("binfmt-%04x", *(ushort *)(bprm->buf + 2)) < 0)
>  			return retval;
>  		need_retry = false;
> -- 
> 2.7.4

  Luis
