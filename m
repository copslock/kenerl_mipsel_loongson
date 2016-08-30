Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 01:28:31 +0200 (CEST)
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:44705 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992009AbcH3X2YA7w6B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 01:28:24 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 20FD329DD77;
        Tue, 30 Aug 2016 23:28:21 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: chalk40_65e19f4672047
X-Filterd-Recvd-Size: 3375
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 23:28:20 +0000 (UTC)
Date:   Tue, 30 Aug 2016 19:28:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers
 per syscall
Message-ID: <20160830192818.4e16a674@gandalf.local.home>
In-Reply-To: <CALCETrWx+1Pdob8mU_X1hOWPWqj31ihVL3Z1R0PqjVeExZ_HAA@mail.gmail.com>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
        <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
        <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com>
        <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
        <20160830152955.17633511@gandalf.local.home>
        <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
        <20160830165830.5e494c43@gandalf.local.home>
        <CALCETrW_bnmqBRp3qWoaWUu=m7Bi19VcH9kMBifyL06JuGGVzg@mail.gmail.com>
        <20160830180328.4e579db3@gandalf.local.home>
        <CALCETrWjpcKqFHvxS35Csd3An1QNMXW8yiHChuWfuWTvVu8_ig@mail.gmail.com>
        <20160830183030.3e9f67f0@gandalf.local.home>
        <CALCETrWx+1Pdob8mU_X1hOWPWqj31ihVL3Z1R0PqjVeExZ_HAA@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54877
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

On Tue, 30 Aug 2016 16:09:04 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> But none of this should be a problem at all for MIPS, right?  AFAICT
> the only problem for MIPS is that there *is* a mapping from metadata
> to nr.  If that mapping got removed, MIPS should just work, right?

Wait, where's the mapping of metadata to nr. I don't see that, nor do I
see a need for that. The issue is that we have metadata that expresses
how to record a syscall, and we map syscall nr to metadata, because
when tracing is active, the only thing we have to find that metadata is
the syscall nr.

Now if a syscall nr has more than one way to record (a single nr for
multiple syscalls), then we get into trouble. That's why we have
trouble with compat syscalls. The same number maps to different
syscalls, and we don't know how to differentiate that.


> 
> For x86 compat, I think that adding arch should be sufficient.
> Specifically, rather than having just one enter_syscall_files array,
> have one per audit arch.  Then call syscall_get_arch() as well as
> syscall_get_nr() and use both to lookup the metadata.  AFAIK this
> should work on all architectures, although you might need some arch
> helpers to enumerate all the arches and their respective syscall
> tables (and max syscall nrs).

OK, if the regs can get us to the arch, then this might work.

That is, perhaps we can have multiple tables (not really sure how to
make that happen in an arch agnostic way), and then have two functions:

trace_get_syscall_nr(current, regs)
trace_get_syscall_arch(current, regs)

Although, that "arch" may be confusing.

-- Steve
