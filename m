Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 21:30:06 +0200 (CEST)
Received: from smtprelay0144.hostedemail.com ([216.40.44.144]:53908 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992009AbcH3T37iKZvj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 21:29:59 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0DB8D351FDD;
        Tue, 30 Aug 2016 19:29:58 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: mice47_39c50bd0eb25a
X-Filterd-Recvd-Size: 2364
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 19:29:56 +0000 (UTC)
Date:   Tue, 30 Aug 2016 15:29:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers
 per syscall
Message-ID: <20160830152955.17633511@gandalf.local.home>
In-Reply-To: <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
        <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
        <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com>
        <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Tue, 30 Aug 2016 11:52:39 -0700
Andy Lutomirski <luto@amacapital.net> wrote:


> Okay, I think I see what's going on.  init_ftrace_syscalls() does:
> 
>         meta = find_syscall_meta(addr);
> 
> Unless I'm missing some reason why this is a sensible thing to do,
> this seems overcomplicated and incorrect.  There is exactly one caller
> of find_syscall_meta() and that caller knows the syscall number.  Why
> doesn't it just look up the metadata by *number* instead of by syscall
> implementation address?  There are plenty of architectures for which
> multiple logically different syscalls can share an implementation
> (e.g. pretty much everything that calls in_compat_syscall()).

The problem is that the meta data is created at the syscalls
themselves. Look at all the macro magic in include/linux/syscalls.h,
and search for __syscall_metadata. The meta data is created via linker
magic, and the find_syscall_meta() is what finds a specific system call
and the meta data associated with it.

Then it can use the number to system call mapping.

Yes, this code needs some loving.

-- Steve
