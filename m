Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 22:58:41 +0200 (CEST)
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:42183 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991859AbcH3U6eX9loQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 22:58:34 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9E33A9EA11;
        Tue, 30 Aug 2016 20:58:32 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: maid64_67898a89e0a19
X-Filterd-Recvd-Size: 1860
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 20:58:31 +0000 (UTC)
Date:   Tue, 30 Aug 2016 16:58:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers
 per syscall
Message-ID: <20160830165830.5e494c43@gandalf.local.home>
In-Reply-To: <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
        <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
        <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com>
        <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
        <20160830152955.17633511@gandalf.local.home>
        <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54871
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

On Tue, 30 Aug 2016 12:53:53 -0700
Andy Lutomirski <luto@amacapital.net> wrote:


> Egads!  OK, I see why this is a mess.

:-)

> 
> I guess we should be creating the metadata from the syscall tables
> instead of from the syscall definitions, but I guess that's currently
> a nasty per-arch mess.

Yep.

> 
> Could we at least have an array of (arch, nr) instead of just an array
> of nrs in the metadata?

I guess I'm not following you on what would be used for "arch".

-- Steve
