Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 00:08:52 +0200 (CEST)
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35319 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991859AbcH3WIqGQZ6B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 00:08:46 +0200
Received: by mail-ua0-f172.google.com with SMTP id i32so57557515uai.2
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2016 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QUY+Z00udvK03gwqUJG5P0xdjtQKYdIIX1bvZmxibZU=;
        b=1k84LuqKZq+mSOif/jk6tV4uu/k7Ce5/9RXpkmIe6/2p34aUgRmS1W1asYei47l1gB
         BWeJwFpeicjgWv/3NQKir2pFp+zTEr5TeglDhvWuvapczYtu2gUkspkJl9Styn6ciZc9
         RZP/YRJ+ht2exKh+mg3/HukAddDlX+j1rLZbkvxONh8/eU3XQAC9bClKvn80ZMGD9Vb/
         YGj6dUx54UPzLV/q3Yi7yYS27W2kexiAFDF57T7/O4RjA6Tqfimj5YUFlp+oN50+IjA9
         AZPVijn/ASSuJDLGgg+iW7p2ORBjoYyNRBoKjqodC+heTp34QdvoWIDaknUBKmyOzxxe
         aOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QUY+Z00udvK03gwqUJG5P0xdjtQKYdIIX1bvZmxibZU=;
        b=ZZbdsQpdzUnlhW6poKRFsmfcpzuxmP9cERp/UmkKST+QqDRPgEHXrPrEzW94AkOGLu
         Z+Vy12rmSq3V88EorEmvVc6N6Sk9IRRTeUC6PryNB5gxCNfRe34F72MDUmTR232niaS/
         /FPc2ohFUdCpqRNTKg0Xx0oAKFynx/B3jgtvC0Kgifr1eNfH8GZd52HxG9YNLFhO9lt9
         zM0uCy6zPqAtNCltggW/KsDUxbfZideYVuOmWoLJI2Cr5y8LgsvdlWNJXdg2olGXF8pY
         /GW0AoGi5S/Hwx6PgGdg5FOE+ApgSGXWAkocKySn+eTlp1LGXgi9Bn85IUUF79TaaKP9
         dvXg==
X-Gm-Message-State: AE9vXwNyDEHapxukxtXZTZs/1Xubz/UE675QSQRVI7AMD4uIbovGLWeMmlHFuu8rxIeqD995U8p81+4PiXUjJ1UM
X-Received: by 10.31.14.133 with SMTP id 127mr341905vko.50.1472594920326; Tue,
 30 Aug 2016 15:08:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.76.146 with HTTP; Tue, 30 Aug 2016 15:08:19 -0700 (PDT)
In-Reply-To: <20160830180328.4e579db3@gandalf.local.home>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
 <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com> <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
 <20160830152955.17633511@gandalf.local.home> <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
 <20160830165830.5e494c43@gandalf.local.home> <CALCETrW_bnmqBRp3qWoaWUu=m7Bi19VcH9kMBifyL06JuGGVzg@mail.gmail.com>
 <20160830180328.4e579db3@gandalf.local.home>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 30 Aug 2016 15:08:19 -0700
Message-ID: <CALCETrWjpcKqFHvxS35Csd3An1QNMXW8yiHChuWfuWTvVu8_ig@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers per syscall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Tue, Aug 30, 2016 at 3:03 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 30 Aug 2016 14:45:05 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>> I wonder: could more of it be dynamically allocated?  I.e. statically
>> generate metadata with args and name and whatever but without any nr.
>> Then dynamically allocate the map from nr to metadata?
>
> Any ideas on how to do that?

This might be as simple as dropping the syscall_nr field from
syscall_metadata.  I admit I'm not familiar with this code at all, but
I'm not really sure why that field is needed.  init_ftrace_syscalls is
already dynamically allocating an array that maps nr to metadata, and
I don't see what in the code actually needs that mapping to be
one-to-one or needs the reverse mapping.

>
>>
>> > >
>> > > Could we at least have an array of (arch, nr) instead of just an array
>> > > of nrs in the metadata?
>> >
>> > I guess I'm not following you on what would be used for "arch".
>>
>> Whatever syscall_get_arch() would return for the syscall.  For x86,
>> for example, most syscalls have a compat nr and a non-compat nr.  How
>> does tracing currently handle that?
>
> We currently disable tracing compat syscalls.
>
> What the current code does, is that the macro and linker magic creates
> a list of meta data structures, that have a name attached to them.
>
> Then on boot up, we scan the list of syscall numbers and then ask the
> arch for the system call they represent to get the actual function
> itself:
>
>         addr = arch_syscall_addr(i);
>
> where 'i' is the system call nr.
>
> Then the find_syscall_meta(addr) will do a ksyms_lookup to convert the
> addr into the system call name, and then search the meta data for one
> that has that name attached to it.
>
> Yes it is ugly. But we don't currently have a method to automatically
> match the meta data with the system call numbers. The system call
> macros only have access to the names and the parameters, not the
> numbers that are associated with them.
>

Yeah, I think I get it now.  But I think my suggestion of removing
syscall_nr entirely might actually work.  You'd have to initialize
more than one syscalls_metadata array, but they could share the
underlying metadata objects.

--Andy


-- 
Andy Lutomirski
AMA Capital Management, LLC
