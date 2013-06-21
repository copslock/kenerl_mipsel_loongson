Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 18:12:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60146 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825725Ab3FUQMzCusmp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jun 2013 18:12:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5LGCm2d008441;
        Fri, 21 Jun 2013 18:12:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5LGCfxg008420;
        Fri, 21 Jun 2013 18:12:41 +0200
Date:   Fri, 21 Jun 2013 18:12:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Daney <david.daney@cavium.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3] kernel/signal.c: fix BUG_ON with SIG128 (MIPS)
Message-ID: <20130621161241.GC17626@linux-mips.org>
References: <1371821962-9151-1-git-send-email-james.hogan@imgtec.com>
 <51C47864.9030200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51C47864.9030200@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37088
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

On Fri, Jun 21, 2013 at 08:59:32AM -0700, David Daney wrote:

> On 06/21/2013 06:39 AM, James Hogan wrote:
> >MIPS has 128 signals, the highest of which has the number 128 (they
> >start from 1). The following command causes get_signal_to_deliver() to
> >pass this signal number straight through to do_group_exit() as the exit
> >code:
> >
> >   strace sleep 10 & sleep 1 && kill -128 `pidof sleep`
> >
> >However do_group_exit() checks for the core dump bit (0x80) in the exit
> >code which matches in this particular case and the kernel panics:
> >
> >   BUG_ON(exit_code & 0x80); /* core dumps don't get here */
> >
> >Fundamentally the exit / wait status code cannot represent SIG128. In
> >fact it cannot represent SIG127 either as 0x7f represents a stopped
> >child.
> >
> >Therefore add sig_to_exitcode() and exitcode_to_sig() functions which
> >map signal numbers > 126 to exit code 126 and puts the remainder (i.e.
> >sig - 126) in higher bits. This allows WIFSIGNALED() to return true for
> >both SIG127 and SIG128, and allows WTERMSIG to be later updated to read
> >the correct signal number for SIG127 and SIG128.
> 
> I really hate this approach.
> 
> Can we just change the ABI to reduce the number of signals so that
> all the standard C library wait related macros don't have to be
> changed?

Changing the ABI is a very strong medicine that wants to be used very
carefully.

> Think about it, any user space program using signal numbers 127 and
> 128 doesn't work correctly as things exist today, so removing those
> two will be no great loss.

Glibc has it's own sigset_t of 1024 signals.  I wonder if it will even
use more than 64 signals.  Similar for other libcs.

  Ralf
