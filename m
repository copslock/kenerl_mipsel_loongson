Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 00:03:39 +0200 (CEST)
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:33796 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992009AbcH3WDc3YcaB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 00:03:32 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9FDC712BA12;
        Tue, 30 Aug 2016 22:03:30 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: knee40_58b62fc8aa81c
X-Filterd-Recvd-Size: 3031
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 22:03:29 +0000 (UTC)
Date:   Tue, 30 Aug 2016 18:03:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers
 per syscall
Message-ID: <20160830180328.4e579db3@gandalf.local.home>
In-Reply-To: <CALCETrW_bnmqBRp3qWoaWUu=m7Bi19VcH9kMBifyL06JuGGVzg@mail.gmail.com>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
        <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
        <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com>
        <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
        <20160830152955.17633511@gandalf.local.home>
        <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
        <20160830165830.5e494c43@gandalf.local.home>
        <CALCETrW_bnmqBRp3qWoaWUu=m7Bi19VcH9kMBifyL06JuGGVzg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54873
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

On Tue, 30 Aug 2016 14:45:05 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> I wonder: could more of it be dynamically allocated?  I.e. statically
> generate metadata with args and name and whatever but without any nr.
> Then dynamically allocate the map from nr to metadata?

Any ideas on how to do that?

> 
> > >
> > > Could we at least have an array of (arch, nr) instead of just an array
> > > of nrs in the metadata?  
> >
> > I guess I'm not following you on what would be used for "arch".  
> 
> Whatever syscall_get_arch() would return for the syscall.  For x86,
> for example, most syscalls have a compat nr and a non-compat nr.  How
> does tracing currently handle that?

We currently disable tracing compat syscalls.

What the current code does, is that the macro and linker magic creates
a list of meta data structures, that have a name attached to them.

Then on boot up, we scan the list of syscall numbers and then ask the
arch for the system call they represent to get the actual function
itself:

	addr = arch_syscall_addr(i);

where 'i' is the system call nr.

Then the find_syscall_meta(addr) will do a ksyms_lookup to convert the
addr into the system call name, and then search the meta data for one
that has that name attached to it.

Yes it is ugly. But we don't currently have a method to automatically
match the meta data with the system call numbers. The system call
macros only have access to the names and the parameters, not the
numbers that are associated with them.

-- Steve
