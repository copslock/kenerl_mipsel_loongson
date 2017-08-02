Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 01:23:48 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:45244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994866AbdHBXXeNHSNP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Aug 2017 01:23:34 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2690DAF80;
        Wed,  2 Aug 2017 23:23:33 +0000 (UTC)
Date:   Thu, 3 Aug 2017 01:23:31 +0200
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
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
Message-ID: <20170802232331.GO18884@wotan.suse.de>
References: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com>
 <20170802001200.GD18884@wotan.suse.de>
 <CAGXu5jJw74M0hTL8JGUtshgZpGjzWia2d=oK3t8oJF6qo9Xp_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJw74M0hTL8JGUtshgZpGjzWia2d=oK3t8oJF6qo9Xp_A@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <lurodriguez@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59345
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

On Tue, Aug 01, 2017 at 07:28:20PM -0700, Kees Cook wrote:
> On Tue, Aug 1, 2017 at 5:12 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > On Fri, Jul 21, 2017 at 03:05:20PM +0100, Matt Redfearn wrote:
> >> Commit 6d7964a722af ("kmod: throttle kmod thread limit") which was
> >> merged in v4.13-rc1 broke this behaviour since the recursive modprobe is
> >> no longer caught, it just ends up waiting indefinitely for the kmod_wq
> >> wait queue. Hence the kernel appears to hang silently when starting
> >> userspace.
> >
> > Indeed, the recursive issue were no longer expected to exist.
> 
> Errr, yeah, recursive binfmt loads can still happen.
> 
> > The *old* implementation would also prevent a set of binaries to daisy chain
> > a set of 50 different binaries which require different binfmt loaders. The
> > current implementation enables this and we'd just wait. There's a bound to
> > the number of binfmd loaders though, so this would be bounded. If however
> > a 2nd loader loaded the first binary we'd run into the same issue I think.
> >
> > If we can't think of a good way to resolve this we'll just have to revert
> > 6d7964a722af for now.
> 
> The weird but "normal" recursive case is usually a script calling a
> script calling a misc format. Getting a chain of modprobes running,
> though, seems unlikely. I *think* Matt's patch is okay, but I agree,
> it'd be better for the request_module() to fail.

In that case how about we just have each waiter only wait max X seconds,
if the number of concurrent ongoing modprobe calls hasn't reduced by
a single digit in X seconds we give up on request_module() for the
module and clearly indicate what happened.

Matt, can you test?

Note I've used wait_event_killable_timeout() to only accept SIGKILL
for now. I've seen issues wit SIGCHILD and at modprobe this could
even be a bigger issue, so this would restrict the signals received
*only* to SIGKILL.

It would be good to come up with a simple test case for this in
tools/testing/selftests/kmod/kmod.sh

  Luis

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 5b74e36c0ca8..dc19880c02f5 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -757,6 +757,43 @@ extern int do_wait_intr_irq(wait_queue_head_t *, wait_queue_entry_t *);
 	__ret;									\
 })
 
+#define __wait_event_killable_timeout(wq_head, condition, timeout)		\
+	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
+		      TASK_KILLABLE, 0, timeout,				\
+		      __ret = schedule_timeout(__ret))
+
+/**
+ * wait_event_killable_timeout - sleep until a condition gets true or a timeout elapses
+ * @wq_head: the waitqueue to wait on
+ * @condition: a C expression for the event to wait for
+ * @timeout: timeout, in jiffies
+ *
+ * The process is put to sleep (TASK_KILLABLE) until the
+ * @condition evaluates to true or a kill signal is received.
+ * The @condition is checked each time the waitqueue @wq_head is woken up.
+ *
+ * wake_up() has to be called after changing any variable that could
+ * change the result of the wait condition.
+ *
+ * Returns:
+ * 0 if the @condition evaluated to %false after the @timeout elapsed,
+ * 1 if the @condition evaluated to %true after the @timeout elapsed,
+ * the remaining jiffies (at least 1) if the @condition evaluated
+ * to %true before the @timeout elapsed, or -%ERESTARTSYS if it was
+ * interrupted by a kill signal.
+ *
+ * Only kill signals interrupt this process.
+ */
+#define wait_event_killable_timeout(wq_head, condition, timeout)		\
+({										\
+	long __ret = timeout;							\
+	might_sleep();								\
+	if (!___wait_cond_timeout(condition))					\
+		__ret = __wait_event_killable_timeout(wq_head,			\
+						condition, timeout);		\
+	__ret;									\
+})
+
 
 #define __wait_event_lock_irq(wq_head, condition, lock, cmd)			\
 	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
diff --git a/kernel/kmod.c b/kernel/kmod.c
index 6d016c5d97c8..1b5f7bada8d2 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -71,6 +71,13 @@ static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
 static DECLARE_WAIT_QUEUE_HEAD(kmod_wq);
 
 /*
+ * If modprobe can't be called after this time we assume its very likely
+ * your userspace has created a recursive dependency, and we'll have no
+ * option but to fail.
+ */
+#define MAX_KMOD_TIMEOUT 5
+
+/*
 	modprobe_path is set via /proc/sys.
 */
 char modprobe_path[KMOD_PATH_LEN] = "/sbin/modprobe";
@@ -167,8 +174,18 @@ int __request_module(bool wait, const char *fmt, ...)
 		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
 				    atomic_read(&kmod_concurrent_max),
 				    MAX_KMOD_CONCURRENT, module_name);
-		wait_event_interruptible(kmod_wq,
-					 atomic_dec_if_positive(&kmod_concurrent_max) >= 0);
+		ret = wait_event_killable_timeout(kmod_wq,
+						  atomic_dec_if_positive(&kmod_concurrent_max) >= 0,
+						  MAX_KMOD_TIMEOUT * HZ);
+		if (!ret) {
+			pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
+					    module_name, atomic_read(&kmod_concurrent_max), MAX_KMOD_TIMEOUT);
+			pr_warn_ratelimited("request_module: recursive modprobe call very likely!");
+			return -ETIME;
+		} else if (ret == -ERESTARTSYS) {
+			pr_warn_ratelimited("request_module: sigkill sent for modprobe %s, giving up", module_name);
+			return ret;
+		}
 	}
 
 	trace_module_request(module_name, wait, _RET_IP_);
