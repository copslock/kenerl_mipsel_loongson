Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 19:58:41 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:51158 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491036Ab0AVS6h convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2010 19:58:37 +0100
Received: by pzk35 with SMTP id 35so1074185pzk.22
        for <linux-mips@linux-mips.org>; Fri, 22 Jan 2010 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P8RunPtJMhiRR/9cnZ6FMJ9g5s6XdqLiBHi/WnBUGpo=;
        b=lXiiUjYZ7tQxnvpiUUgPiZIW345fVUWZFImwGWZ9VQIEO8AKusJ42cVPHmgbxqY2an
         1cPW/UtLYrvCz+oS0lSkx3+yKPDKPyyuCKl8Y+83GqBX8LXV+TCS91cg1uGaCPQZ4kpJ
         rVwl+OLKMfma1DVNpJ34C4MWUm8jX7ZYQysH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QEzSEhKeS2UGFGjk1Hvv0GNGSEHl/vXuYamBkE89MTzcH6TWqnrLLKjH2sJNHEjXMO
         Sghznu57Zb9cXGw02seE3us/1POsUuxjr2PfLMZdWD1YnkpXotpzy7oQvZz5H+/Na+NL
         6c3nhraei7N54wxYro5QJp7hUhwLANXJdjslI=
MIME-Version: 1.0
Received: by 10.141.89.10 with SMTP id r10mr550755rvl.69.1264139401934; Thu, 
        21 Jan 2010 21:50:01 -0800 (PST)
In-Reply-To: <20100122053711.GB3761@localhost>
References: <20100122032102.137106635@intel.com>
         <20100122033004.193166010@intel.com>
         <7b6bb4a51001212115j741e91c4p61f3f1d6e2ec1de4@mail.gmail.com>
         <20100122053711.GB3761@localhost>
Date:   Fri, 22 Jan 2010 13:50:01 +0800
Message-ID: <7b6bb4a51001212150h32f62e53ga230b381ce5da126@mail.gmail.com>
Subject: Re: [PATCH 1/3] resources: introduce generic page_is_ram()
From:   Xiaotian Feng <xtfeng@gmail.com>
To:     Wu Fengguang <fengguang.wu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        "Zheng, Shaohui" <shaohui.zheng@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 25623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xtfeng@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14189

On Fri, Jan 22, 2010 at 1:37 PM, Wu Fengguang <fengguang.wu@intel.com> wrote:
> On Thu, Jan 21, 2010 at 10:15:50PM -0700, Xiaotian Feng wrote:
>> On Fri, Jan 22, 2010 at 11:21 AM, Wu Fengguang <fengguang.wu@intel.com> wrote:
>> > It's based on walk_system_ram_range(), for archs that don't have
>> > their own page_is_ram().
>> >
>> > The static verions in MIPS and SCORE are also made global.
>> >
>> > CC: Chen Liqin <liqin.chen@sunplusct.com>
>> > CC: Lennox Wu <lennox.wu@gmail.com>
>> > CC: Ralf Baechle <ralf@linux-mips.org>
>> > CC: Américo Wang <xiyou.wangcong@gmail.com>
>> > CC: linux-mips@linux-mips.org
>> > CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>> > CC: Yinghai Lu <yinghai@kernel.org>
>> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
>> > ---
>> >  arch/mips/mm/init.c    |    2 +-
>> >  arch/score/mm/init.c   |    2 +-
>> >  include/linux/ioport.h |    2 ++
>> >  kernel/resource.c      |   11 +++++++++++
>> >  4 files changed, 15 insertions(+), 2 deletions(-)
>> >
>> > --- linux-mm.orig/kernel/resource.c     2010-01-22 11:20:34.000000000 +0800
>> > +++ linux-mm/kernel/resource.c  2010-01-22 11:20:35.000000000 +0800
>> > @@ -327,6 +327,17 @@ int walk_system_ram_range(unsigned long
>> >
>> >  #endif
>> >
>> > +#define PAGE_IS_RAM    24
>> > +static int __is_ram(unsigned long pfn, unsigned long nr_pages, void *arg)
>> > +{
>> > +       return PAGE_IS_RAM;
>> > +}
>> > +int __attribute__((weak)) page_is_ram(unsigned long pfn)
>> > +{
>> > +       return PAGE_IS_RAM == walk_system_ram_range(pfn, 1, NULL, __is_ram);
>> > +}
>> > +#undef PAGE_IS_RAM
>> > +
>>
>> I'm not sure, but any build test for powerpc/mips/score?
>
> Sorry, no build tests yet:
>
>        /bin/sh: score-linux-gcc: command not found
>
> I just make the mips/score page_is_ram() non-static and assume that
> will make it compile.
>
>> walk_system_ram_range is defined when CONFIG_ARCH_HAS_WALK_MEMORY is not set.
>> Is it safe when CONFIG_ARCH_HAS_WALK_MEMORY is set for some powerpc archs?
>
> Good question. Grep shows that CONFIG_ARCH_HAS_WALK_MEMORY is only
> defined for powerpc, and it has its own page_is_ram() as well as
> walk_system_ram_range().
>
> walk_system_ram_range() must be defined somewhere because it is
> expected to be generic routine: exported and called from both
> in-kernel and out-of-tree code.
>

Yes, powerpc has its own walk_system_ram_range() and page_is_ram() ;-)

Would it be better if moving the weak attribute page_is_ram() into #if
!defined(CONFIG_ARCH_HAS_WALK_MEMORY) ?

> Thanks,
> Fengguang
>
