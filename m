Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2016 16:06:45 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:54693 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007443AbcDAOGjYnrMT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Apr 2016 16:06:39 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 98A362010F;
        Fri,  1 Apr 2016 14:06:35 +0000 (UTC)
Received: from jouet.infradead.org (unknown [179.235.167.147])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AFC2203E6;
        Fri,  1 Apr 2016 14:06:33 +0000 (UTC)
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A82FA140386; Fri,  1 Apr 2016 11:06:28 -0300 (BRT)
Date:   Fri, 1 Apr 2016 11:06:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] perf tools: Add support for MIPS userspace DWARF
 callchains.
Message-ID: <20160401140628.GE7115@kernel.org>
References: <cover.1459501014.git.ralf@linux-mips.org>
 <13b2723b59281cacda362f261ba57b643f21a0d1.1459501014.git.ralf@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b2723b59281cacda362f261ba57b643f21a0d1.1459501014.git.ralf@linux-mips.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <acme@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acme@kernel.org
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

Em Fri, Apr 01, 2016 at 10:56:56AM +0200, Ralf Baechle escreveu:
> From: David Daney <david.daney@cavium.com>
> 
> Hack up the Makefile and add support code for mips unwinding
> and dwarf-regs.

Bzzt, failing to build on a minimal mips64 debian experimental env, on the one
hand you expect perf/arch/mips/util/dwarf-regs.o to be built but something,
probably some missing devel package, is not triggering its build:

# docker run -v /home/acme/git:/git --privileged=true --rm=true -t -i perf-build-minimal-debian-experimental-x-mips64
make: Entering directory '/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
sh: 1: command: Illegal option -c

Auto-detecting system features:
...                         dwarf: [ OFF ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libelf: [ OFF ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ OFF ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]

config/Makefile:246: No libelf found, disables 'probe' tool and BPF support in 'perf record', please install elfutils-libelf-devel/libelf-dev
config/Makefile:364: Disabling post unwind, no support found.
config/Makefile:405: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
config/Makefile:416: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
config/Makefile:431: slang not found, disables TUI support. Please install slang-devel or libslang-dev
config/Makefile:445: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
config/Makefile:473: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
config/Makefile:499: No python interpreter was found: disables Python support - please install python-devel/python-dev
config/Makefile:606: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
config/Makefile:619: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
config/Makefile:676: Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/alias.o
  MKDIR    /tmp/build/perf/fd/
  CC       /tmp/build/perf/exec-cmd.o
  CC       /tmp/build/perf/event-parse.o
  CC       /tmp/build/perf/fd/array.o
  LD       /tmp/build/perf/fd/libapi-in.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/fs.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/annotate.o
  CC       /tmp/build/perf/help.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/fs/tracing_path.o
  CC       /tmp/build/perf/pager.o
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/cpu.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/parse-options.o
  CC       /tmp/build/perf/debug.o
  LD       /tmp/build/perf/libapi-in.o
  AR       /tmp/build/perf/libapi.a
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/parse-filter.o
  CC       /tmp/build/perf/parse-utils.o
  CC       /tmp/build/perf/kbuffer-parse.o
  LD       /tmp/build/perf/libtraceevent-in.o
  LINK     /tmp/build/perf/libtraceevent.a
  GEN      /tmp/build/perf/common-cmds.h
  CC       /tmp/build/perf/plugin_jbd2.o
  LD       /tmp/build/perf/plugin_jbd2-in.o
  CC       /tmp/build/perf/plugin_hrtimer.o
  PERF_VERSION = 4.5.0
  CC       /tmp/build/perf/builtin-bench.o
  LD       /tmp/build/perf/plugin_hrtimer-in.o
  CC       /tmp/build/perf/plugin_kmem.o
  CC       /tmp/build/perf/run-command.o
  LD       /tmp/build/perf/plugin_kmem-in.o
  CC       /tmp/build/perf/plugin_kvm.o
  LD       /tmp/build/perf/plugin_kvm-in.o
  CC       /tmp/build/perf/plugin_mac80211.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  CC       /tmp/build/perf/builtin-annotate.o
  CC       /tmp/build/perf/sigchain.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  CC       /tmp/build/perf/util/build-id.o
  CC       /tmp/build/perf/plugin_function.o
  LD       /tmp/build/perf/plugin_function-in.o
  CC       /tmp/build/perf/plugin_xen.o
  CC       /tmp/build/perf/subcmd-config.o
  LD       /tmp/build/perf/plugin_xen-in.o
  CC       /tmp/build/perf/plugin_scsi.o
  LD       /tmp/build/perf/libsubcmd-in.o
  AR       /tmp/build/perf/libsubcmd.a
  GEN      perf-archive
  GEN      perf-with-kcore
  CC       /tmp/build/perf/plugin_cfg80211.o
  LD       /tmp/build/perf/plugin_scsi-in.o
  MKDIR    /tmp/build/perf/arch/
  CC       /tmp/build/perf/arch/common.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugin_jbd2.so
  LINK     /tmp/build/perf/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugin_kmem.so
  LINK     /tmp/build/perf/plugin_kvm.so
  CC       /tmp/build/perf/builtin-config.o
  LINK     /tmp/build/perf/plugin_mac80211.so
  LINK     /tmp/build/perf/plugin_sched_switch.so
  LINK     /tmp/build/perf/plugin_function.so
  LINK     /tmp/build/perf/plugin_xen.so
  LINK     /tmp/build/perf/plugin_scsi.so
  CC       /tmp/build/perf/builtin-diff.o
  LINK     /tmp/build/perf/plugin_cfg80211.so
  MKDIR    /tmp/build/perf/arch/mips/util/
  LD       /tmp/build/perf/arch/mips/util/libperf-in.o
  LD       /tmp/build/perf/arch/mips/libperf-in.o
  CC       /tmp/build/perf/util/config.o
  LD       /tmp/build/perf/arch/libperf-in.o
  CC       /tmp/build/perf/builtin-evlist.o
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  CC       /tmp/build/perf/builtin-help.o
  CC       /tmp/build/perf/builtin-sched.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/setup.o
  CC       /tmp/build/perf/util/ctype.o
  CC       /tmp/build/perf/util/db-export.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/helpline.o
  CC       /tmp/build/perf/builtin-buildid-list.o
  CC       /tmp/build/perf/ui/progress.o
  CC       /tmp/build/perf/ui/util.o
  CC       /tmp/build/perf/util/env.o
  CC       /tmp/build/perf/builtin-buildid-cache.o
  CC       /tmp/build/perf/ui/hist.o
  CC       /tmp/build/perf/util/event.o
  CC       /tmp/build/perf/util/evlist.o
  CC       /tmp/build/perf/builtin-list.o
  CC       /tmp/build/perf/builtin-record.o
  CC       /tmp/build/perf/util/evsel.o
  CC       /tmp/build/perf/builtin-report.o
  CC       /tmp/build/perf/util/find_bit.o

  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/util/levenshtein.o
  CC       /tmp/build/perf/util/llvm-utils.o
  MKDIR    /tmp/build/perf/ui/stdio/
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/builtin-stat.o
  BISON    /tmp/build/perf/util/parse-events-bison.c
  CC       /tmp/build/perf/util/perf_regs.o
  CC       /tmp/build/perf/util/path.o
  CC       /tmp/build/perf/util/rbtree.o
  LD       /tmp/build/perf/ui/libperf-in.o
  MKDIR    /tmp/build/perf/scripts/
  LD       /tmp/build/perf/scripts/libperf-in.o
  CC       /tmp/build/perf/builtin-timechart.o
  CC       /tmp/build/perf/util/libstring.o
  CC       /tmp/build/perf/util/bitmap.o
  CC       /tmp/build/perf/util/hweight.o
  CC       /tmp/build/perf/util/quote.o
  CC       /tmp/build/perf/util/strbuf.o
  CC       /tmp/build/perf/util/string.o
  CC       /tmp/build/perf/util/strlist.o
  CC       /tmp/build/perf/util/strfilter.o
  CC       /tmp/build/perf/util/top.o
  CC       /tmp/build/perf/builtin-top.o
  CC       /tmp/build/perf/util/usage.o
  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/util/wrapper.o
  CC       /tmp/build/perf/util/dso.o
  CC       /tmp/build/perf/util/symbol.o
  CC       /tmp/build/perf/util/color.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/util/header.o
  CC       /tmp/build/perf/util/callchain.o
  CC       /tmp/build/perf/builtin-lock.o
  CC       /tmp/build/perf/builtin-kvm.o
  CC       /tmp/build/perf/builtin-inject.o
  CC       /tmp/build/perf/builtin-mem.o
  CC       /tmp/build/perf/builtin-data.o
  CC       /tmp/build/perf/builtin-version.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-messaging.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/builtin-test.o
  CC       /tmp/build/perf/perf.o
  CC       /tmp/build/perf/util/values.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-pipe.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/parse-events.o
  CC       /tmp/build/perf/util/debug.o
  CC       /tmp/build/perf/bench/mem-functions.o
  CC       /tmp/build/perf/bench/futex-hash.o
  CC       /tmp/build/perf/util/machine.o
  CC       /tmp/build/perf/bench/futex-wake.o
  CC       /tmp/build/perf/bench/futex-wake-parallel.o
  CC       /tmp/build/perf/bench/futex-requeue.o
  CC       /tmp/build/perf/bench/futex-lock-pi.o
  CC       /tmp/build/perf/util/map.o
  LD       /tmp/build/perf/bench/perf-in.o
  CC       /tmp/build/perf/util/pstack.o
  CC       /tmp/build/perf/util/session.o
  CC       /tmp/build/perf/tests/dso-data.o
  CC       /tmp/build/perf/util/ordered-events.o
  CC       /tmp/build/perf/util/comm.o
  CC       /tmp/build/perf/util/thread.o
  CC       /tmp/build/perf/tests/attr.o
  CC       /tmp/build/perf/util/thread_map.o
  CC       /tmp/build/perf/util/trace-event-parse.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC       /tmp/build/perf/tests/openat-syscall.o
  CC       /tmp/build/perf/util/parse-events-bison.o
  BISON    /tmp/build/perf/util/pmu-bison.c
  CC       /tmp/build/perf/util/trace-event-read.o
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
  CC       /tmp/build/perf/tests/mmap-basic.o
  CC       /tmp/build/perf/util/trace-event-info.o
  CC       /tmp/build/perf/tests/perf-record.o
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC       /tmp/build/perf/util/trace-event-scripting.o
  CC       /tmp/build/perf/util/trace-event.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  CC       /tmp/build/perf/tests/fdarray.o
  CC       /tmp/build/perf/util/svghelper.o
  CC       /tmp/build/perf/util/sort.o
  CC       /tmp/build/perf/tests/pmu.o
  CC       /tmp/build/perf/tests/hists_common.o
  CC       /tmp/build/perf/tests/hists_link.o
  CC       /tmp/build/perf/tests/hists_filter.o
  CC       /tmp/build/perf/tests/hists_output.o
  CC       /tmp/build/perf/util/hist.o
  CC       /tmp/build/perf/tests/hists_cumulate.o
  CC       /tmp/build/perf/tests/python-use.o
  CC       /tmp/build/perf/tests/bp_signal.o
  CC       /tmp/build/perf/tests/bp_signal_overflow.o
  CC       /tmp/build/perf/tests/task-exit.o
  CC       /tmp/build/perf/tests/sw-clock.o
  CC       /tmp/build/perf/util/util.o
  CC       /tmp/build/perf/tests/mmap-thread-lookup.o
  CC       /tmp/build/perf/tests/thread-mg-share.o
  CC       /tmp/build/perf/tests/switch-tracking.o
  CC       /tmp/build/perf/tests/keep-tracking.o
  CC       /tmp/build/perf/util/xyarray.o
  CC       /tmp/build/perf/util/cpumap.o
  CC       /tmp/build/perf/tests/code-reading.o
  CC       /tmp/build/perf/util/cgroup.o
  CC       /tmp/build/perf/tests/sample-parsing.o
  CC       /tmp/build/perf/util/target.o
  CC       /tmp/build/perf/util/rblist.o
  CC       /tmp/build/perf/util/intlist.o
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  CC       /tmp/build/perf/tests/kmod-path.o
  CC       /tmp/build/perf/util/vdso.o
  CC       /tmp/build/perf/util/counts.o
  CC       /tmp/build/perf/tests/thread-map.o
  CC       /tmp/build/perf/util/stat.o
  CC       /tmp/build/perf/util/stat-shadow.o
  CC       /tmp/build/perf/tests/llvm.o
  CC       /tmp/build/perf/tests/bpf.o
  CC       /tmp/build/perf/tests/topology.o
  CC       /tmp/build/perf/util/record.o
  CC       /tmp/build/perf/tests/cpumap.o
  CC       /tmp/build/perf/util/srcline.o
  CC       /tmp/build/perf/tests/stat.o
  CC       /tmp/build/perf/tests/event_update.o
  CC       /tmp/build/perf/tests/event-times.o
  CC       /tmp/build/perf/util/data.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/util/cloexec.o
  CC       /tmp/build/perf/util/thread-stack.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/tests/llvm-src-base.o
  CC       /tmp/build/perf/tests/llvm-src-kbuild.o
  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  CC       /tmp/build/perf/util/term.o
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
  LD       /tmp/build/perf/tests/perf-in.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  CC       /tmp/build/perf/util/mem-events.o
  LD       /tmp/build/perf/perf-in.o
  CC       /tmp/build/perf/util/symbol-minimal.o
  MKDIR    /tmp/build/perf/util/scripting-engines/
  LD       /tmp/build/perf/util/scripting-engines/libperf-in.o
  CC       /tmp/build/perf/util/demangle-java.o
  FLEX     /tmp/build/perf/util/parse-events-flex.c
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
  LD       /tmp/build/perf/util/libperf-in.o
  LD       /tmp/build/perf/libperf-in.o
  AR       /tmp/build/perf/libperf.a
mips64-linux-gnuabi64-ar: /tmp/build/perf/arch/mips/util/dwarf-regs.o: No such file or directory
Makefile.perf:437: recipe for target '/tmp/build/perf/libperf.a' failed
make[1]: *** [/tmp/build/perf/libperf.a] Error 1
Makefile:108: recipe for target 'install-bin' failed
make: *** [install-bin] Error 2
make: Leaving directory '/git/linux/tools/perf'
[root@jouet ~]#
 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: linux-mips@linux-mips.org
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  tools/perf/arch/mips/Build                   |  2 +-
>  tools/perf/arch/mips/Makefile                |  7 +++
>  tools/perf/arch/mips/include/perf_regs.h     | 84 ++++++++++++++++++++++++++++
>  tools/perf/arch/mips/util/Build              |  2 +
>  tools/perf/arch/mips/util/dwarf-regs.c       | 37 ++++++++++++
>  tools/perf/arch/mips/util/unwind-libunwind.c | 20 +++++++
>  6 files changed, 151 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/arch/mips/Makefile
>  create mode 100644 tools/perf/arch/mips/include/perf_regs.h
>  create mode 100644 tools/perf/arch/mips/util/Build
>  create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
> 
> diff --git a/tools/perf/arch/mips/Build b/tools/perf/arch/mips/Build
> index 1bb8bf6..54afe4a 100644
> --- a/tools/perf/arch/mips/Build
> +++ b/tools/perf/arch/mips/Build
> @@ -1 +1 @@
> -# empty
> +libperf-y += util/
> diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
> new file mode 100644
> index 0000000..fe9b61e
> --- /dev/null
> +++ b/tools/perf/arch/mips/Makefile
> @@ -0,0 +1,7 @@
> +ifndef NO_DWARF
> +PERF_HAVE_DWARF_REGS := 1
> +LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
> +endif
> +ifndef NO_LIBUNWIND
> +LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/unwind.o
> +endif
> diff --git a/tools/perf/arch/mips/include/perf_regs.h b/tools/perf/arch/mips/include/perf_regs.h
> new file mode 100644
> index 0000000..a91b904
> --- /dev/null
> +++ b/tools/perf/arch/mips/include/perf_regs.h
> @@ -0,0 +1,84 @@
> +#ifndef ARCH_PERF_REGS_H
> +#define ARCH_PERF_REGS_H
> +
> +#include <stdlib.h>
> +#include "../../util/types.h"
> +#include <asm/perf_regs.h>
> +
> +#define PERF_REG_IP PERF_REG_MIPS_PC
> +#define PERF_REG_SP PERF_REG_MIPS_R29
> +
> +#define PERF_REGS_MASK ((1ULL << PERF_REG_MIPS_MAX) - 1)
> +
> +static inline const char *perf_reg_name(int id)
> +{
> +	switch (id) {
> +	case PERF_REG_MIPS_PC:
> +		return "PC";
> +	case PERF_REG_MIPS_R1:
> +		return "$1";
> +	case PERF_REG_MIPS_R2:
> +		return "$2";
> +	case PERF_REG_MIPS_R3:
> +		return "$3";
> +	case PERF_REG_MIPS_R4:
> +		return "$4";
> +	case PERF_REG_MIPS_R5:
> +		return "$5";
> +	case PERF_REG_MIPS_R6:
> +		return "$6";
> +	case PERF_REG_MIPS_R7:
> +		return "$7";
> +	case PERF_REG_MIPS_R8:
> +		return "$8";
> +	case PERF_REG_MIPS_R9:
> +		return "$9";
> +	case PERF_REG_MIPS_R10:
> +		return "$10";
> +	case PERF_REG_MIPS_R11:
> +		return "$11";
> +	case PERF_REG_MIPS_R12:
> +		return "$12";
> +	case PERF_REG_MIPS_R13:
> +		return "$13";
> +	case PERF_REG_MIPS_R14:
> +		return "$14";
> +	case PERF_REG_MIPS_R15:
> +		return "$15";
> +	case PERF_REG_MIPS_R16:
> +		return "$16";
> +	case PERF_REG_MIPS_R17:
> +		return "$17";
> +	case PERF_REG_MIPS_R18:
> +		return "$18";
> +	case PERF_REG_MIPS_R19:
> +		return "$19";
> +	case PERF_REG_MIPS_R20:
> +		return "$20";
> +	case PERF_REG_MIPS_R21:
> +		return "$21";
> +	case PERF_REG_MIPS_R22:
> +		return "$22";
> +	case PERF_REG_MIPS_R23:
> +		return "$23";
> +	case PERF_REG_MIPS_R24:
> +		return "$24";
> +	case PERF_REG_MIPS_R25:
> +		return "$25";
> +
> +	case PERF_REG_MIPS_R28:
> +		return "$28";
> +	case PERF_REG_MIPS_R29:
> +		return "$29";
> +	case PERF_REG_MIPS_R30:
> +		return "$30";
> +	case PERF_REG_MIPS_R31:
> +		return "$31";
> +	default:
> +		break;
> +	}
> +	return NULL;
> +}
> +
> +
> +#endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
> new file mode 100644
> index 0000000..baeccb0
> --- /dev/null
> +++ b/tools/perf/arch/mips/util/Build
> @@ -0,0 +1,2 @@
> +libperf-$(CONFIG_DWARF)		+= dwarf-regs.o
> +libperf-$(CONFIG_LIBUNWIND)	+= unwind-libunwind.o
> diff --git a/tools/perf/arch/mips/util/dwarf-regs.c b/tools/perf/arch/mips/util/dwarf-regs.c
> new file mode 100644
> index 0000000..165e017
> --- /dev/null
> +++ b/tools/perf/arch/mips/util/dwarf-regs.c
> @@ -0,0 +1,37 @@
> +/*
> + * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
> + *
> + * Copyright (C) 2013 Cavium, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <libio.h>
> +#include <dwarf-regs.h>
> +
> +static const char *mips_gpr_names[32] = {
> +	"$0", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9",
> +	"$10", "$11", "$12", "$13", "$14", "$15", "$16", "$17", "$18", "$19",
> +	"$20", "$21", "$22", "$23", "$24", "$25", "$26", "$27", "$28", "$29",
> +	"$30", "$31"
> +};
> +
> +const char *get_arch_regstr(unsigned int n)
> +{
> +	if (n < 32)
> +		return mips_gpr_names[n];
> +	if (n == 64)
> +		return "hi";
> +	if (n == 65)
> +		return "lo";
> +	return NULL;
> +}
> diff --git a/tools/perf/arch/mips/util/unwind-libunwind.c b/tools/perf/arch/mips/util/unwind-libunwind.c
> new file mode 100644
> index 0000000..612949b
> --- /dev/null
> +++ b/tools/perf/arch/mips/util/unwind-libunwind.c
> @@ -0,0 +1,20 @@
> +
> +#include <errno.h>
> +#include <libunwind.h>
> +#include "perf_regs.h"
> +#include "../../util/unwind.h"
> +
> +int unwind__arch_reg_id(int regnum)
> +{
> +	switch (regnum) {
> +	case UNW_MIPS_R1 ... UNW_MIPS_R25:
> +		return regnum - UNW_MIPS_R1 + PERF_REG_MIPS_R1;
> +	case UNW_MIPS_R28 ... UNW_MIPS_R31:
> +		return regnum - UNW_MIPS_R28 + PERF_REG_MIPS_R28;
> +	case UNW_MIPS_PC:
> +		return PERF_REG_MIPS_PC;
> +	default:
> +		pr_err("unwind: invalid reg id %d\n", regnum);
> +		return -EINVAL;
> +	}
> +}
> -- 
> 2.5.5
> 
