Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 02:09:49 +0200 (CEST)
Received: from mail-ot1-x344.google.com ([IPv6:2607:f8b0:4864:20::344]:40475
        "EHLO mail-ot1-x344.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994542AbeJMAJoF0vMH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 02:09:44 +0200
Received: by mail-ot1-x344.google.com with SMTP id w67so13948362ota.7
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 17:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bkp1b3yp9z/uWXQetbOuaWLTZ1A7P1tg/9UbWkaLl2U=;
        b=cH0qqB3xp23UP5zCLNHJdfLzwXH7r0jEYiv6Fhmz84qb+A1HG2VB4uhPK6actazg2v
         HCK8L9nc7sKOgKKifRc3kWRetfRH43bJ4uIslFeRhr9hWqu/POfn0D1N230NRboPPDbK
         QVrq6r3q9K66gJgvb0rA1j/ZopvqhVU6Pp+6E7JXafPP9q3YilHPXLhMQlyXxr5XAd5r
         nBr2FLrSHMaswOgEjVuwyvIlzcuGzFQtu0h1fCik6yu9No3T2Zp/8id7XRicCx2lfQeW
         dumipPxVWTeQEl9uxEjZOhkKevgyUD5QEjLkITDYs/+2VKUjsyoSL4vY1z3QaHuzR/Gl
         zGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bkp1b3yp9z/uWXQetbOuaWLTZ1A7P1tg/9UbWkaLl2U=;
        b=OFtYqf0a47iU5gHjMowPNdJ1acstsrzzF3SLxFV0PEU12G0QBttmozbEybQoiFGA4V
         UHvj70zIBDU2lnC8nd0fJGNUuKsW/sebwAdHF7IAlKsftU7VV36z1SQZ/KXrmgaIBiyq
         2v0kgDsWgeHz9YjQd6FvEcdkZo0ejxrCeg4p35S+/xFChoDjrlXBd5wCTg5qH8+uhBBV
         QDYxVAmk68T/+SwVaLWsgdZVXyP7ja+qeDmqNXpcRD6wEmDvX7KwRGjSQybxMfzFkg3k
         QYwJSdszvNLaXxcGo3Fq3ILYAQoRheEq1FfJsQPZoq3MJ+lQvp1otiE37nFKfz4Tz9Oh
         z01Q==
X-Gm-Message-State: ABuFfojv5s/MeRDSuPTvcL3vLo6xXvDLxOgo2cqSFwy3rUXIsf3c6CKq
        FShNWMv6Fk5NitY3l8c+mAKMEfWbJoA4InyJ9zzlXg==
X-Google-Smtp-Source: ACcGV639M41DQtJ3Bzi3FPu0+wsilAuqX9fxY3z3OebtRwmZSMx/ZNfJJHLHlwhGi7OSBLGGl7Zp8YllhCcioSPxoiQ=
X-Received: by 2002:a9d:5733:: with SMTP id p48mr4824449oth.292.1539389376689;
 Fri, 12 Oct 2018 17:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com> <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
 <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
 <CAG48ez0XfGFAWDYa75COMPCsKqqGfBFOtcNuGD4_dubGf2YeAQ@mail.gmail.com> <657e6d0ada18e8ca0350bc6b3a80c49b3c0b341c.camel@intel.com>
In-Reply-To: <657e6d0ada18e8ca0350bc6b3a80c49b3c0b341c.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 13 Oct 2018 02:09:09 +0200
Message-ID: <CAG48ez383rjt+v_DvLF902X33od_SwMh8dZ-6=w1DZ-YPZ_U9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
To:     rick.p.edgecombe@intel.com
Cc:     linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, jeyu@kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jannh@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jannh@google.com
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

On Sat, Oct 13, 2018 at 2:04 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Fri, 2018-10-12 at 19:22 +0200, Jann Horn wrote:
> > On Fri, Oct 12, 2018 at 7:04 PM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > > On Fri, 2018-10-12 at 02:35 +0200, Jann Horn wrote:
> > > > Why all the rbtree stuff instead of stashing a pointer in struct
> > > > vmap_area, or something like that?
> > >
> > > Since the tracking was not for all vmalloc usage, the intention was to not
> > > bloat
> > > the structure for other usages likes stacks. I thought usually there
> > > wouldn't be
> > > nearly as much module space allocations as there would be kernel stacks, but
> > > I
> > > didn't do any actual measurements on the tradeoffs.
> >
> > I imagine that one extra pointer in there - pointing to your struct
> > mod_alloc_user - would probably not be terrible. 8 bytes more per
> > kernel stack shouldn't be so bad?
>
> I looked into this and it starts to look a little messy. The nommu.c version of
> vmalloc doesn't use or expose access to vmap_area or vm_struct. So it starts to
> look like a bunch of IFDEFs to remove the rlimit in the nommu case or making a
> stand in that maintains pretend vm struct's in nommu.c. I had actually
> previously tried to at least pull the allocations size from vmalloc structs, but it broke on nommu.
>
> Thought I would check back and see. How important do you think this is?

I don't think it's important - I just thought that it would be nice to
avoid the extra complexity if it is easily avoidable.
