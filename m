Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 19:38:22 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:34697
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994693AbeHTRiSqkUKn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 19:38:18 +0200
Received: by mail-qt0-x243.google.com with SMTP id m13-v6so17126586qth.1;
        Mon, 20 Aug 2018 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IyO7vfXI//Q4MSlPAGfegu2NC1XVbQ6cIgY5ii/oCNo=;
        b=W1UV082aMCWLPoyIwBJqsn5irFGtn2okXLFB2GOtG1j+uAOkKxuMwupdI6gFc6bR+y
         H2jkIe6czbtsvYPFj/ju0YbB/wDdo2KqALJiO7XR4j+zCUbdkpmGlLqNmF/yq35BRJUV
         Mv6lOb4JJPBSlH7P/ePMHOsegufw4H0abF1HvssfnZJf9QOwqBPJIQd6x9MInAXmytkp
         m0injG2U8mJ+SjougvC+9r6ZRYr2hg8IqsUaWaxJ6IXMnOBdkC1h3LdsVnBcM99cGQxA
         eoFXZqDZ2R2MC7848bCdTlL5wrcogNzjnlAZo2cyOjQzVYI4AB7Kn31+E14Fuujf05rW
         oVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IyO7vfXI//Q4MSlPAGfegu2NC1XVbQ6cIgY5ii/oCNo=;
        b=MmXnkCIa+7r253m3CRg+FzAj94lqsDGbF+W83qvCIeAiQW8vHyU87+D5NEWqb3SvGv
         Ji3s9LFtxKkq/sfbuiCl4/a3s/jhAeOq6BPtGIFefmaUFND6/OqgEKDum6sWJqcucmq4
         pDeShY4AbyZq1wXiFpHtum1hNrO+cy2cr/LKfMsl4Fan8fr8gqdzYUuJmfOKsEVhspY7
         /8IZNBcvaZZ/KY6Wr4o6dU+k9SOOvuurA+JPqBvLDlm0GHMlb+YyqC7XTRrYbivIvdVT
         diqvaQ9vJbPyWcLNxE/uPXh4gXWRcASIfrKQw+dbaPgo2BqA3hKl7wbSW1MjsZtZ6Dzv
         iZKA==
X-Gm-Message-State: APzg51A6v40tl5KV66jWIaNteqodvPeUgeOT1cEkZLD+HvKc53DDgG3T
        WDBIqwoxwxINEGWGmAA74KZRexE3Sb4FiU5ytPTw80Sx
X-Google-Smtp-Source: ANB0VdZOcJYKQ11+qMxzo7bNxJ0Jk5gBwaEUhqAZMaXM39kozsRrM5Dnjgkp8kr12cELJHszyq/iHBFxWr6hC5yYMpc=
X-Received: by 2002:a0c:9251:: with SMTP id 17-v6mr6476879qvz.239.1534786692543;
 Mon, 20 Aug 2018 10:38:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 10:38:11
 -0700 (PDT)
In-Reply-To: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 20 Aug 2018 10:38:11 -0700
Message-ID: <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <liu.song.a23@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liu.song.a23@gmail.com
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

I am testing the patch set with the following code:

#include <stdio.h>
#include <unistd.h>

volatile short semaphore = 0;

int for_uprobe(int c)
{
        printf("%d\n", c + 10);
        return c + 1;
}

int main(int argc, char *argv[])
{
        for_uprobe(argc);
        while (1) {
                sleep(1);
                printf("semaphore %d\n", semaphore);
        }
}

I created a uprobe on function for_uprobe(), that uses semaphore as
reference counter:

  echo "p:uprobe_1 /root/a.out:0x49a(0x1036)" >> uprobe_events

I found that if I start a.out before enabling the uprobe, the output
of a.out is like:

root@virt-test:~# ~/a.out
11
semaphore 0
semaphore 0
semaphore 2      <<<  when the uprobe is enabled
semaphore 2
semaphore 2
semaphore 2
semaphore 2
semaphore 0     <<< when the uprobe is disabled
semaphore 0
semaphore 0

I am not quite sure whether the value should be 1 or 2, but it works.

However, if I start a.out AFTER enabling the uprobe, there is something wrong:

root@virt-test:~# ~/a.out
11
semaphore 0       <<< this should be non-zero, as the uprobe is already enabled
semaphore 0
semaphore 0
semaphore 0
semaphore 0       <<< disabling the uprobe, the value is still 0,
                            <<<  get warning "ref_ctr going negative"
at the same time
semaphore 0
semaphore 0
semaphore 1       <<< enable uprobe again, getting 1 this time
semaphore 1
semaphore 1

I haven't spent much time debugging this, but I guess there is
something wrong on the mmap path?

Thanks,
Song

On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> v8 -> v9:
>  - Rebased to rostedt/for-next (Commit bb730b5833b5 to be precise)
>  - Not including first two patches now. They are already pulled by
>    Steven.
>  - Change delayed_uprobe_remove() function as suggested by Oleg
>  - Dump inode, offset, ref_ctr_offset, mm etc if we fail to update
>    reference counter.
>  - Rename delayed_uprobe_install() to delayed_ref_ctr_inc()
>  - Use 'short d' (delta) in update_ref_ctr() in place of 'bool
>    is_register'.
>
> v8: https://lkml.org/lkml/2018/8/9/81
>
> Future work:
>  - Optimize uprobe_mmap()->delayed_ref_ctr_inc() by making
>    delayed_uprobe_list per mm.
>
> Description:
> Userspace Statically Defined Tracepoints[1] are dtrace style markers
> inside userspace applications. Applications like PostgreSQL, MySQL,
> Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
> have these markers embedded in them. These markers are added by developer
> at important places in the code. Each marker source expands to a single
> nop instruction in the compiled code but there may be additional
> overhead for computing the marker arguments which expands to couple of
> instructions. In case the overhead is more, execution of it can be
> omitted by runtime if() condition when no one is tracing on the marker:
>
>     if (reference_counter > 0) {
>         Execute marker instructions;
>     }
>
> Default value of reference counter is 0. Tracer has to increment the
> reference counter before tracing on a marker and decrement it when
> done with the tracing.
>
> Currently, perf tool has limited supports for SDT markers. I.e. it
> can not trace markers surrounded by reference counter. Also, it's
> not easy to add reference counter logic in userspace tool like perf,
> so basic idea for this patchset is to add reference counter logic in
> the a uprobe infrastructure. Ex,[2]
>
>   # cat tick.c
>     ...
>     for (i = 0; i < 100; i++) {
>         DTRACE_PROBE1(tick, loop1, i);
>         if (TICK_LOOP2_ENABLED()) {
>             DTRACE_PROBE1(tick, loop2, i);
>         }
>         printf("hi: %d\n", i);
>         sleep(1);
>     }
>     ...
>
> Here tick:loop1 is marker without reference counter where as tick:loop2
> is surrounded by reference counter condition.
>
>   # perf buildid-cache --add /tmp/tick
>   # perf probe sdt_tick:loop1
>   # perf probe sdt_tick:loop2
>
>   # perf stat -e sdt_tick:loop1,sdt_tick:loop2 -- /tmp/tick
>   hi: 0
>   hi: 1
>   hi: 2
>   ^C
>   Performance counter stats for '/tmp/tick':
>              3      sdt_tick:loop1
>              0      sdt_tick:loop2
>      2.747086086 seconds time elapsed
>
> Perf failed to record data for tick:loop2. Same experiment with this
> patch series:
>
>   # ./perf buildid-cache --add /tmp/tick
>   # ./perf probe sdt_tick:loop2
>   # ./perf stat -e sdt_tick:loop2 /tmp/tick
>     hi: 0
>     hi: 1
>     hi: 2
>     ^C
>      Performance counter stats for '/tmp/tick':
>                  3      sdt_tick:loop2
>        2.561851452 seconds time elapsed
>
> [1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> [2] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506
>
> Ravi Bangoria (4):
>   Uprobes: Support SDT markers having reference count (semaphore)
>   Uprobes/sdt: Prevent multiple reference counter for same uprobe
>   trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
>   perf probe: Support SDT markers having reference counter (semaphore)
>
>  include/linux/uprobes.h       |   5 +
>  kernel/events/uprobes.c       | 278 ++++++++++++++++++++++++++++++++++++++++--
>  kernel/trace/trace.c          |   2 +-
>  kernel/trace/trace_uprobe.c   |  75 +++++++++++-
>  tools/perf/util/probe-event.c |  39 +++++-
>  tools/perf/util/probe-event.h |   1 +
>  tools/perf/util/probe-file.c  |  34 +++++-
>  tools/perf/util/probe-file.h  |   1 +
>  tools/perf/util/symbol-elf.c  |  46 +++++--
>  tools/perf/util/symbol.h      |   7 ++
>  10 files changed, 453 insertions(+), 35 deletions(-)
>
> --
> 2.14.4
>
