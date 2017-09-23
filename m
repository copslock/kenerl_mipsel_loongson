Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Sep 2017 15:40:31 +0200 (CEST)
Received: from zeniv.linux.org.uk ([195.92.253.2]:39558 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990425AbdIWNkV50iEw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Sep 2017 15:40:21 +0200
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1dvkfN-0001Dl-E2; Sat, 23 Sep 2017 13:40:21 +0000
Date:   Sat, 23 Sep 2017 14:40:21 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: potential deadlock in r4k_flush_cache_sigtramp()
Message-ID: <20170923134021.GN32076@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <viro@ftp.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viro@ZenIV.linux.org.uk
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

	Calling get_user_pages_fast() while holding ->mmap_sem is
asking for trouble:

CPU1: r4k_flush_cache_sigtramp()
	down_read(&current->mm->mmap_sem);

CPU2: (running thread with the same ->mm): sys_pkey_alloc()
	down_write(&current->mm->mmap_sem);

CPU1:
	pages = get_user_pages_fast(addr, 1, 0, &args.page);
which hits an absent page and goto slow.  Then it goes on to
        ret = get_user_pages_unlocked(start, (end - start) >> PAGE_SHIFT,
                                      pages, write ? FOLL_WRITE : 0);
which does
        return __get_user_pages_unlocked(current, current->mm, start, nr_pages,
                                         pages, gup_flags | FOLL_TOUCH);
which does
        down_read(&mm->mmap_sem);
        ret = __get_user_pages_locked(tsk, mm, start, nr_pages, pages, NULL, 
                                      &locked, false, gup_flags);

and we have a classical deadlock on recursive down_read() (thread 1: down_read()
gets the rwsem; thread 2: down_write() blocks waiting for thread 1 to release
it; thread 1: down_read() blocks waiting for thread 2 to get through down_write()
and eventual up_write(), which completes the deadlock).

Replacing pkey_alloc(2) with e.g. mmap(2) turns that from hard deadlock into
something killable, but while "with bad timing you might get process stuck
hard" is worse than "with bad timing you might get process stuck until you
kill -9 it", neither is a good thing.

I'm not familiar enough with arch/mips guts to suggest any variant of solution;
replacing get_user_pages_fast() with get_user_pages_locked() would solve the
deadlock, but that loses the fast path; not taking ->mmap_sem there have
local_r4k_flush_cache_sigtramp() run without fcs_args->mm being locked, which
might or might not be a problem.  Suggestions?
