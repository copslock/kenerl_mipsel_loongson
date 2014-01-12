Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jan 2014 10:04:01 +0100 (CET)
Received: from mail-bk0-f43.google.com ([209.85.214.43]:63107 "EHLO
        mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816233AbaALJD5HLnlf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jan 2014 10:03:57 +0100
Received: by mail-bk0-f43.google.com with SMTP id mz12so2075061bkb.30
        for <multiple recipients>; Sun, 12 Jan 2014 01:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TsjT61NRFGdesAMLfkoMzoh/I9MBtd8iri1u9YlD5pA=;
        b=R22JYIO8n57ZPsQr60kF0Gs7kpZVmEhHDkEcl1t86zZBTjJr82i46JaHT/MCwTVW26
         am4qqeAghJno2eetJhfMl1OAjtXdaINYegh1PKGooBQtl8CuLud2nmdlQ18iqmrsIi6i
         DUZdrRclqUwnVEdw6ZtVs1NRWFb1tvBvOZsFsIu6mrOgE/wEH11TdV0E1j8HKMhRCLUt
         +XpwTfZL4rC83xbSAfI0uQWrdR5ey7kGJSsZ/goeI/WaasgZPndVZY/F2iHkE3pqJcsq
         roqbr+jpA1fP3TZfwaY9C0EJVgVe3lMdbtK5muJEOqxLfWa2bp9L2lhcvcHci7dQrhvY
         ogxA==
MIME-Version: 1.0
X-Received: by 10.205.18.73 with SMTP id qf9mr6517690bkb.12.1389517431417;
 Sun, 12 Jan 2014 01:03:51 -0800 (PST)
Received: by 10.204.169.76 with HTTP; Sun, 12 Jan 2014 01:03:51 -0800 (PST)
In-Reply-To: <20140109213624.GG11944@hall.aurel32.net>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
        <1389149068-24376-3-git-send-email-chenhc@lemote.com>
        <20140108195838.GA10463@hall.aurel32.net>
        <CAAhV-H4tx=sCk=iUwuCfnCS+rbmtu5Y_UcpAn6JXDoobA+OGrQ@mail.gmail.com>
        <20140109213624.GG11944@hall.aurel32.net>
Date:   Sun, 12 Jan 2014 17:03:51 +0800
X-Google-Sender-Auth: VYoJTW8IbCHYPK1OKnslZ9oQRgo
Message-ID: <CAAhV-H7+XDYi3i7bp7q0t0oszi8tmAVGtTeAkP+t9VZ6sD3b1w@mail.gmail.com>
Subject: Re: [PATCH V16 02/12] MIPS: Loongson: Add basic Loongson-3 CPU support
From:   Huacai Chen <chenhc@lemote.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On Fri, Jan 10, 2014 at 5:36 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> On Thu, Jan 09, 2014 at 04:30:54PM +0800, Huacai Chen wrote:
>> On Thu, Jan 9, 2014 at 3:58 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
>>
>> > On Wed, Jan 08, 2014 at 10:44:18AM +0800, Huacai Chen wrote:
>> > > Basic Loongson-3 CPU support include CPU probing and TLB/cache
>> > > initializing.
>> > >
>> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> > > Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> > > Signed-off-by: Hua Yan <yanh@lemote.com>
>> > > ---
>> > >  arch/mips/include/asm/cpu-type.h |    4 ++
>> > >  arch/mips/kernel/cpu-probe.c     |   14 ++++++--
>> > >  arch/mips/mm/c-r4k.c             |   59
>> > ++++++++++++++++++++++++++++++++++++++
>> > >  arch/mips/mm/tlb-r4k.c           |    5 ++-
>> > >  arch/mips/mm/tlbex.c             |    1 +
>> > >  5 files changed, 77 insertions(+), 6 deletions(-)
>> > >
>> > > diff --git a/arch/mips/include/asm/cpu-type.h
>> > b/arch/mips/include/asm/cpu-type.h
>> > > index 4a402cc..a591e63 100644
>> > > --- a/arch/mips/include/asm/cpu-type.h
>> > > +++ b/arch/mips/include/asm/cpu-type.h
>> > > @@ -20,6 +20,10 @@ static inline int __pure __get_cpu_type(const int
>> > cpu_type)
>> > >       case CPU_LOONGSON2:
>> > >  #endif
>> > >
>> > > +#ifdef CONFIG_SYS_HAS_CPU_LOONGSON3
>> > > +     case CPU_LOONGSON3:
>> > > +#endif
>> > > +
>> > >  #ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
>> > >       case CPU_LOONGSON1:
>> > >  #endif
>> > > diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>> > > index c814287..4bc81b2 100644
>> > > --- a/arch/mips/kernel/cpu-probe.c
>> > > +++ b/arch/mips/kernel/cpu-probe.c
>> > > @@ -639,17 +639,23 @@ static inline void cpu_probe_legacy(struct
>> > cpuinfo_mips *c, unsigned int cpu)
>> > >                            MIPS_CPU_LLSC;
>> > >               c->tlbsize = 64;
>> > >               break;
>> > > -     case PRID_IMP_LOONGSON2:
>> > > -             c->cputype = CPU_LOONGSON2;
>> > > -             __cpu_name[cpu] = "ICT Loongson-2";
>> > > -
>> > > +     case PRID_IMP_LOONGSON2: /* Loongson-2/3 have the same PRID_IMP
>> > field */
>> >
>> > What about renaming that as something like PRID_IMP_LOONGSON23 given
>> > it is for both Loongson 2 and 3?
>> >
>> Since Loongson-1 is 32-bit CPU and Loongson-2/3 are 64 bit, can I use
>> PRID_IMP_LOONGSON_32 and PRID_IMP_LOONGSON_64?
>> In my opinion these names are better.
>
> That would be the best I agree.
>
>> >
>> > >               switch (c->processor_id & PRID_REV_MASK) {
>> > >               case PRID_REV_LOONGSON2E:
>> > > +                     c->cputype = CPU_LOONGSON2;
>> > > +                     __cpu_name[cpu] = "ICT Loongson-2E";
>> > >                       set_elf_platform(cpu, "loongson2e");
>> > >                       break;
>> > >               case PRID_REV_LOONGSON2F:
>> > > +                     c->cputype = CPU_LOONGSON2;
>> > > +                     __cpu_name[cpu] = "ICT Loongson-2F";
>> > >                       set_elf_platform(cpu, "loongson2f");
>> > >                       break;
>> >
>> > As remarked by Aaro Koskinen, changing the names of the Loongson 2 CPUs
>> > (which is displayedd in /proc/cpuinfo) will break at least
>> > GCC -march=native option. The name should be left unchanged.
>> >
>> Can I keep it as is and then submit a patch to GCC? I think it is important
>> to distinguish 2E/2F/3A in cpuinfo.
>
> I think first the patch has to be integrated to GCC, and then you have
> to wait at least a few months so that people start using the new
> version. Then it should be possible to modify this.
>
> That said, other programs than GCC might use this information from
> /proc/cpuinfo and might also break with this change.
The GCC patch has been accepted yesterday, and the coming V17 patchset
won't be accept at least in kernel-3.14,
So, I'll keep the name in V17.

>
>> >
>> > > +             case PRID_REV_LOONGSON3A:
>> > > +                     c->cputype = CPU_LOONGSON3;
>> > > +                     __cpu_name[cpu] = "ICT Loongson-3A";
>> > > +                     set_elf_platform(cpu, "loongson3a");
>> > > +                     break;
>> > >               }
>> > >
>> > >               set_isa(c, MIPS_CPU_ISA_III);
>> > > diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>> > > index 73f02da..cc02527 100644
>> > > --- a/arch/mips/mm/c-r4k.c
>> > > +++ b/arch/mips/mm/c-r4k.c
>> > > @@ -348,6 +348,7 @@ static inline void local_r4k___flush_cache_all(void
>> > * args)
>> > >  {
>> > >       switch (current_cpu_type()) {
>> > >       case CPU_LOONGSON2:
>> > > +     case CPU_LOONGSON3:
>> > >       case CPU_R4000SC:
>> > >       case CPU_R4000MC:
>> > >       case CPU_R4400SC:
>> > > @@ -1003,6 +1004,33 @@ static void probe_pcache(void)
>> > >               c->dcache.waybit = 0;
>> > >               break;
>> > >
>> > > +     case CPU_LOONGSON3:
>> > > +             config1 = read_c0_config1();
>> > > +             lsize = (config1 >> 19) & 7;
>> > > +             if (lsize)
>> > > +                     c->icache.linesz = 2 << lsize;
>> > > +             else
>> > > +                     c->icache.linesz = 0;
>> >
>> > Sorry to not have seen that before, but it can also be written as:
>> >
>> >         c->icache.linesz = lsize ? (2 << lsize) : 0;
>> >
>> > That said the current version is also fine, so as you prefer.
>> >
>> > > +             c->icache.sets = 64 << ((config1 >> 22) & 7);
>> > > +             c->icache.ways = 1 + ((config1 >> 16) & 7);
>> > > +             icache_size = c->icache.sets *
>> > > +                                       c->icache.ways *
>> > > +                                       c->icache.linesz;
>> > > +             c->icache.waybit = 0;
>> > > +
>> > > +             lsize = (config1 >> 10) & 7;
>> > > +             if (lsize)
>> > > +                     c->dcache.linesz = 2 << lsize;
>> > > +             else
>> > > +                     c->dcache.linesz = 0;
>> > > +             c->dcache.sets = 64 << ((config1 >> 13) & 7);
>> > > +             c->dcache.ways = 1 + ((config1 >> 7) & 7);
>> > > +             dcache_size = c->dcache.sets *
>> > > +                                       c->dcache.ways *
>> > > +                                       c->dcache.linesz;
>> > > +             c->dcache.waybit = 0;
>> > > +             break;
>> > > +
>> > >       default:
>> > >               if (!(config & MIPS_CONF_M))
>> > >                       panic("Don't know how to probe P-caches on this
>> > cpu.");
>> > > @@ -1222,6 +1250,33 @@ static void __init loongson2_sc_init(void)
>> > >       c->options |= MIPS_CPU_INCLUSIVE_CACHES;
>> > >  }
>> > >
>> > > +static void __init loongson3_sc_init(void)
>> > > +{
>> > > +     struct cpuinfo_mips *c = &current_cpu_data;
>> > > +     unsigned int config2, lsize;
>> > > +
>> > > +     config2 = read_c0_config2();
>> > > +     lsize = (config2 >> 4) & 15;
>> > > +     if (lsize)
>> > > +             c->scache.linesz = 2 << lsize;
>> > > +     else
>> > > +             c->scache.linesz = 0;
>> > > +     c->scache.sets = 64 << ((config2 >> 8) & 15);
>> > > +     c->scache.ways = 1 + (config2 & 15);
>> > > +
>> > > +     scache_size = c->scache.sets *
>> > > +                               c->scache.ways *
>> > > +                               c->scache.linesz;
>> > > +     /* Loongson-3 has 4 cores, 1MB scache for each. scaches are shared
>> > */
>> > > +     scache_size *= 4;
>> > > +     c->scache.waybit = 0;
>> > > +     pr_info("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
>> > > +            scache_size >> 10, way_string[c->scache.ways],
>> > c->scache.linesz);
>> > > +     if (scache_size)
>> > > +             c->options |= MIPS_CPU_INCLUSIVE_CACHES;
>> > > +     return;
>> > > +}
>> > > +
>> > >  extern int r5k_sc_init(void);
>> > >  extern int rm7k_sc_init(void);
>> > >  extern int mips_sc_init(void);
>> > > @@ -1274,6 +1329,10 @@ static void setup_scache(void)
>> > >               loongson2_sc_init();
>> > >               return;
>> > >
>> > > +     case CPU_LOONGSON3:
>> > > +             loongson3_sc_init();
>> > > +             return;
>> > > +
>> > >       case CPU_XLP:
>> > >               /* don't need to worry about L2, fully coherent */
>> > >               return;
>> > > diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
>> > > index da3b0b9..298f281 100644
>> > > --- a/arch/mips/mm/tlb-r4k.c
>> > > +++ b/arch/mips/mm/tlb-r4k.c
>> > > @@ -53,13 +53,14 @@ extern void build_tlb_refill_handler(void);
>> > >  #endif /* CONFIG_MIPS_MT_SMTC */
>> > >
>> > >  /*
>> > > - * LOONGSON2 has a 4 entry itlb which is a subset of dtlb,
>> > > - * unfortrunately, itlb is not totally transparent to software.
>> > > + * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
>> > > + * unfortunately, itlb is not totally transparent to software.
>> > >   */
>> > >  static inline void flush_itlb(void)
>> > >  {
>> > >       switch (current_cpu_type()) {
>> > >       case CPU_LOONGSON2:
>> > > +     case CPU_LOONGSON3:
>> > >               write_c0_diag(4);
>> > >               break;
>> > >       default:
>> > > diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> > > index 183f2b5..f89124c 100644
>> > > --- a/arch/mips/mm/tlbex.c
>> > > +++ b/arch/mips/mm/tlbex.c
>> > > @@ -579,6 +579,7 @@ static void build_tlb_write_entry(u32 **p, struct
>> > uasm_label **l,
>> > >       case CPU_BMIPS4380:
>> > >       case CPU_BMIPS5000:
>> > >       case CPU_LOONGSON2:
>> > > +     case CPU_LOONGSON3:
>> > >       case CPU_R5500:
>> > >               if (m4kc_tlbp_war())
>> > >                       uasm_i_nop(p);
>> > > --
>> > > 1.7.7.3
>> > >
>> > >
>> >
>> > --
>> > Aurelien Jarno                          GPG: 1024D/F1BCDB73
>> > aurelien@aurel32.net                 http://www.aurel32.net
>> >
>> >
>
> --
> Aurelien Jarno                          GPG: 1024D/F1BCDB73
> aurelien@aurel32.net                 http://www.aurel32.net
>
