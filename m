Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jan 2014 10:58:16 +0100 (CET)
Received: from [195.154.112.97] ([195.154.112.97]:57618 "EHLO hall.aurel32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825722AbaALJ6OK2qTK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Jan 2014 10:58:14 +0100
Received: from pc-198-95-101-190.cm.vtr.net ([190.101.95.198] helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1W2Ho0-0003RM-RF; Sun, 12 Jan 2014 10:58:09 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1W2Hnk-0001Kc-8A; Sun, 12 Jan 2014 10:57:52 +0100
Date:   Sun, 12 Jan 2014 10:57:52 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH V16 02/12] MIPS: Loongson: Add basic Loongson-3 CPU
 support
Message-ID: <20140112095752.GA14181@ohm.rr44.fr>
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com>
 <1389149068-24376-3-git-send-email-chenhc@lemote.com>
 <20140108195838.GA10463@hall.aurel32.net>
 <CAAhV-H4tx=sCk=iUwuCfnCS+rbmtu5Y_UcpAn6JXDoobA+OGrQ@mail.gmail.com>
 <20140109213624.GG11944@hall.aurel32.net>
 <CAAhV-H7+XDYi3i7bp7q0t0oszi8tmAVGtTeAkP+t9VZ6sD3b1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAhV-H7+XDYi3i7bp7q0t0oszi8tmAVGtTeAkP+t9VZ6sD3b1w@mail.gmail.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Sun, Jan 12, 2014 at 05:03:51PM +0800, Huacai Chen wrote:
> On Fri, Jan 10, 2014 at 5:36 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> > On Thu, Jan 09, 2014 at 04:30:54PM +0800, Huacai Chen wrote:
> >> On Thu, Jan 9, 2014 at 3:58 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> >>
> >> > On Wed, Jan 08, 2014 at 10:44:18AM +0800, Huacai Chen wrote:
> >> > > Basic Loongson-3 CPU support include CPU probing and TLB/cache
> >> > > initializing.
> >> > >
> >> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >> > > Signed-off-by: Hongliang Tao <taohl@lemote.com>
> >> > > Signed-off-by: Hua Yan <yanh@lemote.com>
> >> > > ---
> >> > >  arch/mips/include/asm/cpu-type.h |    4 ++
> >> > >  arch/mips/kernel/cpu-probe.c     |   14 ++++++--
> >> > >  arch/mips/mm/c-r4k.c             |   59
> >> > ++++++++++++++++++++++++++++++++++++++
> >> > >  arch/mips/mm/tlb-r4k.c           |    5 ++-
> >> > >  arch/mips/mm/tlbex.c             |    1 +
> >> > >  5 files changed, 77 insertions(+), 6 deletions(-)
> >> > >
> >> > > diff --git a/arch/mips/include/asm/cpu-type.h
> >> > b/arch/mips/include/asm/cpu-type.h
> >> > > index 4a402cc..a591e63 100644
> >> > > --- a/arch/mips/include/asm/cpu-type.h
> >> > > +++ b/arch/mips/include/asm/cpu-type.h
> >> > > @@ -20,6 +20,10 @@ static inline int __pure __get_cpu_type(const int
> >> > cpu_type)
> >> > >       case CPU_LOONGSON2:
> >> > >  #endif
> >> > >
> >> > > +#ifdef CONFIG_SYS_HAS_CPU_LOONGSON3
> >> > > +     case CPU_LOONGSON3:
> >> > > +#endif
> >> > > +
> >> > >  #ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
> >> > >       case CPU_LOONGSON1:
> >> > >  #endif
> >> > > diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> >> > > index c814287..4bc81b2 100644
> >> > > --- a/arch/mips/kernel/cpu-probe.c
> >> > > +++ b/arch/mips/kernel/cpu-probe.c
> >> > > @@ -639,17 +639,23 @@ static inline void cpu_probe_legacy(struct
> >> > cpuinfo_mips *c, unsigned int cpu)
> >> > >                            MIPS_CPU_LLSC;
> >> > >               c->tlbsize = 64;
> >> > >               break;
> >> > > -     case PRID_IMP_LOONGSON2:
> >> > > -             c->cputype = CPU_LOONGSON2;
> >> > > -             __cpu_name[cpu] = "ICT Loongson-2";
> >> > > -
> >> > > +     case PRID_IMP_LOONGSON2: /* Loongson-2/3 have the same PRID_IMP
> >> > field */
> >> >
> >> > What about renaming that as something like PRID_IMP_LOONGSON23 given
> >> > it is for both Loongson 2 and 3?
> >> >
> >> Since Loongson-1 is 32-bit CPU and Loongson-2/3 are 64 bit, can I use
> >> PRID_IMP_LOONGSON_32 and PRID_IMP_LOONGSON_64?
> >> In my opinion these names are better.
> >
> > That would be the best I agree.
> >
> >> >
> >> > >               switch (c->processor_id & PRID_REV_MASK) {
> >> > >               case PRID_REV_LOONGSON2E:
> >> > > +                     c->cputype = CPU_LOONGSON2;
> >> > > +                     __cpu_name[cpu] = "ICT Loongson-2E";
> >> > >                       set_elf_platform(cpu, "loongson2e");
> >> > >                       break;
> >> > >               case PRID_REV_LOONGSON2F:
> >> > > +                     c->cputype = CPU_LOONGSON2;
> >> > > +                     __cpu_name[cpu] = "ICT Loongson-2F";
> >> > >                       set_elf_platform(cpu, "loongson2f");
> >> > >                       break;
> >> >
> >> > As remarked by Aaro Koskinen, changing the names of the Loongson 2 CPUs
> >> > (which is displayedd in /proc/cpuinfo) will break at least
> >> > GCC -march=native option. The name should be left unchanged.
> >> >
> >> Can I keep it as is and then submit a patch to GCC? I think it is important
> >> to distinguish 2E/2F/3A in cpuinfo.
> >
> > I think first the patch has to be integrated to GCC, and then you have
> > to wait at least a few months so that people start using the new
> > version. Then it should be possible to modify this.
> >
> > That said, other programs than GCC might use this information from
> > /proc/cpuinfo and might also break with this change.
> The GCC patch has been accepted yesterday, and the coming V17 patchset
> won't be accept at least in kernel-3.14,
> So, I'll keep the name in V17.

Kernel 3.15 is expected in roughly 6 months, it might still be a bit
tight for the change to propagate, even if I have seen it has been added
to the 4.8 branch. What the others things? Aaro?

Aurelien

-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
