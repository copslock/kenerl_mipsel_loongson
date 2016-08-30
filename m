Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 00:30:43 +0200 (CEST)
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:53941 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991859AbcH3WagVf02h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 00:30:36 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 84A9C268E11;
        Tue, 30 Aug 2016 22:30:32 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: net12_21b1e8c3f7918
X-Filterd-Recvd-Size: 3785
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 22:30:31 +0000 (UTC)
Date:   Tue, 30 Aug 2016 18:30:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers
 per syscall
Message-ID: <20160830183030.3e9f67f0@gandalf.local.home>
In-Reply-To: <CALCETrWjpcKqFHvxS35Csd3An1QNMXW8yiHChuWfuWTvVu8_ig@mail.gmail.com>
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
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54875
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

On Tue, 30 Aug 2016 15:08:19 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> On Tue, Aug 30, 2016 at 3:03 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 30 Aug 2016 14:45:05 -0700
> > Andy Lutomirski <luto@amacapital.net> wrote:
> >  
> >> I wonder: could more of it be dynamically allocated?  I.e. statically
> >> generate metadata with args and name and whatever but without any nr.
> >> Then dynamically allocate the map from nr to metadata?  
> >
> > Any ideas on how to do that?  
> 
> This might be as simple as dropping the syscall_nr field from
> syscall_metadata.  I admit I'm not familiar with this code at all, but
> I'm not really sure why that field is needed.  init_ftrace_syscalls is
> already dynamically allocating an array that maps nr to metadata, and
> I don't see what in the code actually needs that mapping to be
> one-to-one or needs the reverse mapping.

The issue is that the syscall trace points are called by a single
location, that passes in the syscall_nr, and we need a way to map that
syscall_nr to the metadata.

System calls are really a meta tracepoint. They share a single real
tracepoint called raw_syscalls:sys_enter and raw_syscalls:sys_exit.
When you enable a system call like sys_enter_read, what really happens
is that the sys_enter tracepoint is attached with a function called
ftrace_syscall_enter().

This calls trace_get_syscall_nr(current, regs), to extract the actual
syscall_nr that was called. This is used to find the "file" that is
mapped to the system call (the tracefs file that enabled the system
call).

	trace_file = tr->enter_syscall_files[syscall_nr];

And the meta data (what is used to tell us what to save) is found with
the syscall_nr_to_meta() function.

Now the metadata is used to extract the arguments of the system call:

 syscall_get_arguments(current, regs, 0, sys_data->nb_args,
	etnry->args);

As well as the size needed.

There's no need to map syscall meta to nr, we need a way to map the nr
to the syscall metadata, and when there's more than a one to one
mapping, we need a way to differentiate that in the raw syscall
tracepoints.

-- Steve
