Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 23:33:58 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:40606
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994059AbeHUVdtWtr9B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 23:33:49 +0200
Received: by mail-qt0-x242.google.com with SMTP id h4-v6so22056101qtj.7;
        Tue, 21 Aug 2018 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OpHbvujqzwU/eSTwwag6BYuNHRe2zmi+V2gsEgMc+Ws=;
        b=jHCDdiSDTsQHk2MQRz2IfVK5aqulChlsRXorvkkbPENxXlf54DdUSK4VPHq6MrQsq7
         HhutC2kB/h3aPSQOIV7q6endzkFkgPJN225Fa7SlKG/8duVjv4aFQ3752ONNgz1WOpem
         ILXB3AFkYEw412ZWDaD+eRBDtk1AVHMNUW5YHgBfn72K9xorvObk3OlSEIQKiRPuG5mC
         O+K41nuE3U6yCOGvIDvtwBi+8qsKPCVxCz5plvywFzTAJRSlyyWiMCknb+flvXf3t4H5
         3aMvVegQwxFSNxVE49tHfCEZTXwzjcaCjCev+rzaqvi294rW9LFSSMchA7C1TyOma3BM
         jXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OpHbvujqzwU/eSTwwag6BYuNHRe2zmi+V2gsEgMc+Ws=;
        b=LBKTp2rC+X4UQaeOXQCEeeZglSj1+q491TtcjW0Ma1zhWuDq46+hp/JlPL9bQW71Yd
         ZqbYEuR/rMvphMajAieWY4lAFvku56WG3c2X7uZ0V9dvjyVkTUKqRVfa+yYAEmNso7/7
         GRG7SlJQgypD6mwrNwULVZhZ3KDbhvIDn1y61tPUvjkhOIl/9brnXrEgtPaDYSoEGhYG
         IOQb/qnbP027bqGMbjKC3h/jDYlz6NbVtFAirOYAK/LjL99hhzEFnnb+zyDHO4Tmn6bK
         lHkzNOS4eImAM5TIJ+agm+8RtyCmCdzv19vufOyUHmOD7N6hMVsWfqKjV6BuSj1PYjdq
         XHPA==
X-Gm-Message-State: AOUpUlGMkoI+xLe8Uzb7VvCThqyeYRsqCZaXlufnY5YyXkskd+LythHs
        yS6JpAjIMbZc1Ixfre9jxLWUHijdax/rljpxJAk=
X-Google-Smtp-Source: AA+uWPy/m577MeXGDT5D12CqTqgTuGn0CXwr4F3l8x55m+fifvuCb8d/60m05IbOBOlLkwaD+BrF4IypPL7chZ4okII=
X-Received: by 2002:ac8:24b7:: with SMTP id s52-v6mr42633648qts.87.1534887223114;
 Tue, 21 Aug 2018 14:33:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 14:33:42
 -0700 (PDT)
In-Reply-To: <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com> <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 21 Aug 2018 14:33:42 -0700
Message-ID: <CAPhsuW6Oj3nc7Z_K3cu3qm8vs8bdSJf2XTvfM146ht1ZWFTZKA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] perf probe: Support SDT markers having reference
 counter (semaphore)
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
X-archive-position: 65713
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

On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> With this, perf buildid-cache will save SDT markers with reference
> counter in probe cache. Perf probe will be able to probe markers
> having reference counter. Ex,
>
>   # readelf -n /tmp/tick | grep -A1 loop2
>     Name: loop2
>     ... Semaphore: 0x0000000010020036
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
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/perf/util/probe-event.c | 39 ++++++++++++++++++++++++++++++++----
>  tools/perf/util/probe-event.h |  1 +
>  tools/perf/util/probe-file.c  | 34 ++++++++++++++++++++++++++------
>  tools/perf/util/probe-file.h  |  1 +
>  tools/perf/util/symbol-elf.c  | 46 ++++++++++++++++++++++++++++++++-----------
>  tools/perf/util/symbol.h      |  7 +++++++
>  6 files changed, 106 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index f119eb628dbb..e86f8be89157 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1819,6 +1819,12 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
>                         tp->offset = strtoul(fmt2_str, NULL, 10);
>         }
>
> +       if (tev->uprobes) {
> +               fmt2_str = strchr(p, '(');
> +               if (fmt2_str)
> +                       tp->ref_ctr_offset = strtoul(fmt2_str + 1, NULL, 0);
> +       }
> +
>         tev->nargs = argc - 2;
>         tev->args = zalloc(sizeof(struct probe_trace_arg) * tev->nargs);
>         if (tev->args == NULL) {
> @@ -2012,6 +2018,22 @@ static int synthesize_probe_trace_arg(struct probe_trace_arg *arg,
>         return err;
>  }
>
> +static int
> +synthesize_uprobe_trace_def(struct probe_trace_event *tev, struct strbuf *buf)
> +{
> +       struct probe_trace_point *tp = &tev->point;
> +       int err;
> +
> +       err = strbuf_addf(buf, "%s:0x%lx", tp->module, tp->address);
> +
> +       if (err >= 0 && tp->ref_ctr_offset) {
> +               if (!uprobe_ref_ctr_is_supported())
> +                       return -1;
> +               err = strbuf_addf(buf, "(0x%lx)", tp->ref_ctr_offset);
> +       }
> +       return err >= 0 ? 0 : -1;
> +}
> +
>  char *synthesize_probe_trace_command(struct probe_trace_event *tev)
>  {
>         struct probe_trace_point *tp = &tev->point;
> @@ -2041,15 +2063,17 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
>         }
>
>         /* Use the tp->address for uprobes */
> -       if (tev->uprobes)
> -               err = strbuf_addf(&buf, "%s:0x%lx", tp->module, tp->address);
> -       else if (!strncmp(tp->symbol, "0x", 2))
> +       if (tev->uprobes) {
> +               err = synthesize_uprobe_trace_def(tev, &buf);
> +       } else if (!strncmp(tp->symbol, "0x", 2)) {
>                 /* Absolute address. See try_to_find_absolute_address() */
>                 err = strbuf_addf(&buf, "%s%s0x%lx", tp->module ?: "",
>                                   tp->module ? ":" : "", tp->address);
> -       else
> +       } else {
>                 err = strbuf_addf(&buf, "%s%s%s+%lu", tp->module ?: "",
>                                 tp->module ? ":" : "", tp->symbol, tp->offset);
> +       }
> +
>         if (err)
>                 goto error;
>
> @@ -2633,6 +2657,13 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
>  {
>         int i;
>         char *buf = synthesize_probe_trace_command(tev);
> +       struct probe_trace_point *tp = &tev->point;
> +
> +       if (tp->ref_ctr_offset && !uprobe_ref_ctr_is_supported()) {
> +               pr_warning("A semaphore is associated with %s:%s and "
> +                          "seems your kernel doesn't support it.\n",
> +                          tev->group, tev->event);
> +       }
>
>         /* Old uprobe event doesn't support memory dereference */
>         if (!tev->uprobes || tev->nargs == 0 || !buf)
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 45b14f020558..15a98c3a2a2f 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -27,6 +27,7 @@ struct probe_trace_point {
>         char            *symbol;        /* Base symbol */
>         char            *module;        /* Module name */
>         unsigned long   offset;         /* Offset from symbol */
> +       unsigned long   ref_ctr_offset; /* SDT reference counter offset */
>         unsigned long   address;        /* Actual address of the trace point */
>         bool            retprobe;       /* Return probe flag */
>  };
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index b76088fadf3d..aac7817d9e14 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -696,8 +696,16 @@ int probe_cache__add_entry(struct probe_cache *pcache,
>  #ifdef HAVE_GELF_GETNOTE_SUPPORT
>  static unsigned long long sdt_note__get_addr(struct sdt_note *note)
>  {
> -       return note->bit32 ? (unsigned long long)note->addr.a32[0]
> -                : (unsigned long long)note->addr.a64[0];
> +       return note->bit32 ?
> +               (unsigned long long)note->addr.a32[SDT_NOTE_IDX_LOC] :
> +               (unsigned long long)note->addr.a64[SDT_NOTE_IDX_LOC];
> +}
> +
> +static unsigned long long sdt_note__get_ref_ctr_offset(struct sdt_note *note)
> +{
> +       return note->bit32 ?
> +               (unsigned long long)note->addr.a32[SDT_NOTE_IDX_REFCTR] :
> +               (unsigned long long)note->addr.a64[SDT_NOTE_IDX_REFCTR];
>  }
>
>  static const char * const type_to_suffix[] = {
> @@ -775,14 +783,21 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
>  {
>         struct strbuf buf;
>         char *ret = NULL, **args;
> -       int i, args_count;
> +       int i, args_count, err;
> +       unsigned long long ref_ctr_offset;
>
>         if (strbuf_init(&buf, 32) < 0)
>                 return NULL;
>
> -       if (strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
> -                               sdtgrp, note->name, pathname,
> -                               sdt_note__get_addr(note)) < 0)
> +       err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
> +                       sdtgrp, note->name, pathname,
> +                       sdt_note__get_addr(note));
> +
> +       ref_ctr_offset = sdt_note__get_ref_ctr_offset(note);
> +       if (ref_ctr_offset && err >= 0)
> +               err = strbuf_addf(&buf, "(0x%llx)", ref_ctr_offset);
> +
> +       if (err < 0)
>                 goto error;
>
>         if (!note->args)
> @@ -998,6 +1013,7 @@ int probe_cache__show_all_caches(struct strfilter *filter)
>  enum ftrace_readme {
>         FTRACE_README_PROBE_TYPE_X = 0,
>         FTRACE_README_KRETPROBE_OFFSET,
> +       FTRACE_README_UPROBE_REF_CTR,
>         FTRACE_README_END,
>  };
>
> @@ -1009,6 +1025,7 @@ static struct {
>         [idx] = {.pattern = pat, .avail = false}
>         DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
>         DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
> +       DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
>  };
>
>  static bool scan_ftrace_readme(enum ftrace_readme type)
> @@ -1064,3 +1081,8 @@ bool kretprobe_offset_is_supported(void)
>  {
>         return scan_ftrace_readme(FTRACE_README_KRETPROBE_OFFSET);
>  }
> +
> +bool uprobe_ref_ctr_is_supported(void)
> +{
> +       return scan_ftrace_readme(FTRACE_README_UPROBE_REF_CTR);
> +}
> diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
> index 63f29b1d22c1..2a249182f2a6 100644
> --- a/tools/perf/util/probe-file.h
> +++ b/tools/perf/util/probe-file.h
> @@ -69,6 +69,7 @@ struct probe_cache_entry *probe_cache__find_by_name(struct probe_cache *pcache,
>  int probe_cache__show_all_caches(struct strfilter *filter);
>  bool probe_type_is_available(enum probe_type type);
>  bool kretprobe_offset_is_supported(void);
> +bool uprobe_ref_ctr_is_supported(void);
>  #else  /* ! HAVE_LIBELF_SUPPORT */
>  static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
>  {
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 29770ea61768..0281d5e2cd67 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1947,6 +1947,34 @@ void kcore_extract__delete(struct kcore_extract *kce)
>  }
>
>  #ifdef HAVE_GELF_GETNOTE_SUPPORT
> +
> +static void sdt_adjust_loc(struct sdt_note *tmp, GElf_Addr base_off)
> +{
> +       if (!base_off)
> +               return;
> +
> +       if (tmp->bit32)
> +               tmp->addr.a32[SDT_NOTE_IDX_LOC] =
> +                       tmp->addr.a32[SDT_NOTE_IDX_LOC] + base_off -
> +                       tmp->addr.a32[SDT_NOTE_IDX_BASE];
> +       else
> +               tmp->addr.a64[SDT_NOTE_IDX_LOC] =
> +                       tmp->addr.a64[SDT_NOTE_IDX_LOC] + base_off -
> +                       tmp->addr.a64[SDT_NOTE_IDX_BASE];
> +}
> +
> +static void sdt_adjust_refctr(struct sdt_note *tmp, GElf_Addr base_addr,
> +                             GElf_Addr base_off)
> +{
> +       if (!base_off)
> +               return;
> +
> +       if (tmp->bit32 && tmp->addr.a32[SDT_NOTE_IDX_REFCTR])
> +               tmp->addr.a32[SDT_NOTE_IDX_REFCTR] -= (base_addr - base_off);
> +       else if (tmp->addr.a64[SDT_NOTE_IDX_REFCTR])
> +               tmp->addr.a64[SDT_NOTE_IDX_REFCTR] -= (base_addr - base_off);
> +}
> +
>  /**
>   * populate_sdt_note : Parse raw data and identify SDT note
>   * @elf: elf of the opened file
> @@ -1964,7 +1992,6 @@ static int populate_sdt_note(Elf **elf, const char *data, size_t len,
>         const char *provider, *name, *args;
>         struct sdt_note *tmp = NULL;
>         GElf_Ehdr ehdr;
> -       GElf_Addr base_off = 0;
>         GElf_Shdr shdr;
>         int ret = -EINVAL;
>
> @@ -2060,17 +2087,12 @@ static int populate_sdt_note(Elf **elf, const char *data, size_t len,
>          * base address in the description of the SDT note. If its different,
>          * then accordingly, adjust the note location.
>          */
> -       if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_BASE_SCN, NULL)) {
> -               base_off = shdr.sh_offset;
> -               if (base_off) {
> -                       if (tmp->bit32)
> -                               tmp->addr.a32[0] = tmp->addr.a32[0] + base_off -
> -                                       tmp->addr.a32[1];
> -                       else
> -                               tmp->addr.a64[0] = tmp->addr.a64[0] + base_off -
> -                                       tmp->addr.a64[1];
> -               }
> -       }
> +       if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_BASE_SCN, NULL))
> +               sdt_adjust_loc(tmp, shdr.sh_offset);
> +
> +       /* Adjust reference counter offset */
> +       if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_PROBES_SCN, NULL))
> +               sdt_adjust_refctr(tmp, shdr.sh_addr, shdr.sh_offset);
>
>         list_add_tail(&tmp->note_list, sdt_notes);
>         return 0;
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index f25fae4b5743..20f49779116b 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -379,12 +379,19 @@ int get_sdt_note_list(struct list_head *head, const char *target);
>  int cleanup_sdt_note_list(struct list_head *sdt_notes);
>  int sdt_notes__get_count(struct list_head *start);
>
> +#define SDT_PROBES_SCN ".probes"
>  #define SDT_BASE_SCN ".stapsdt.base"
>  #define SDT_NOTE_SCN  ".note.stapsdt"
>  #define SDT_NOTE_TYPE 3
>  #define SDT_NOTE_NAME "stapsdt"
>  #define NR_ADDR 3
>
> +enum {
> +       SDT_NOTE_IDX_LOC = 0,
> +       SDT_NOTE_IDX_BASE,
> +       SDT_NOTE_IDX_REFCTR,
> +};
> +
>  struct mem_info *mem_info__new(void);
>  struct mem_info *mem_info__get(struct mem_info *mi);
>  void   mem_info__put(struct mem_info *mi);
> --
> 2.14.4
>
