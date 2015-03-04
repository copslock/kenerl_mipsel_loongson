Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 05:20:57 +0100 (CET)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:45783 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006674AbbCDEUzKZSj3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 05:20:55 +0100
Received: by wgha1 with SMTP id a1so44074006wgh.12;
        Tue, 03 Mar 2015 20:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G5OSNL+SNVnM4k9hiZzTbWWuOCFxFd1iTUE9om4l/8M=;
        b=D+dBTQ58O+9S0OAxgWKNg0TS8iRT6gX9tRBxN43Lq+18Z1dbYQZioBSxMc2Azd1C0Y
         zYOm3D8fSX20EXC99R3bL2wT/vN9OpCxvVr345zG4x5MmPao4LW9G8iutxLLrYxAMNv6
         eGDbwL0vCvuYjqg5XZ+vVS/seZanqcRg96zGuXWvSbLj990bENnjj4AW5isKb2zLwnI6
         ok+XaPaRxV7JOnZ+3VGcMlaASZjNCN/pg6VWE4ueW/VpkCTFeZocuZDYZX9TUffGkYBR
         yh2mN1qZrzLvRoQGUCIyBPrPvyMhErmiFuwrEx8GxpKqs69AN0PymaxMmDF7egBdi+x/
         e9rA==
X-Received: by 10.194.60.19 with SMTP id d19mr3506998wjr.133.1425442850246;
        Tue, 03 Mar 2015 20:20:50 -0800 (PST)
Received: from gmail.com (540334ED.catv.pool.telekom.hu. [84.3.52.237])
        by mx.google.com with ESMTPSA id gm2sm5218474wib.5.2015.03.03.20.20.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 20:20:48 -0800 (PST)
Date:   Wed, 4 Mar 2015 05:20:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "x86@kernel.org" <x86@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Borislav Petkov <bp@suse.de>,
        Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
Message-ID: <20150304042044.GA25354@gmail.com>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <20150303073132.GA30602@gmail.com>
 <CAGXu5j+qJLeRx2xx=890OxHp8kjd=ws8zg3_JYPNJd_6p2xoYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+qJLeRx2xx=890OxHp8kjd=ws8zg3_JYPNJd_6p2xoYQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Kees Cook <keescook@chromium.org> wrote:

> On Mon, Mar 2, 2015 at 11:31 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Kees Cook <keescook@chromium.org> wrote:
> >
> >> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> >> ASLR from mmap ASLR, as already done on s390. The architectures
> >> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> >> and x86), have their various forms of arch_mmap_rnd() made available
> >> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> >> arch_randomize_brk() is collapsed as well.
> >>
> >> This is an alternative to the solutions in:
> >> https://lkml.org/lkml/2015/2/23/442
> >
> > Looks good so far:
> >
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> >
> > While reviewing this series I also noticed that the following code
> > could be factored out from architecture mmap code as well:
> >
> >   - arch_pick_mmap_layout() uses very similar patterns across the
> >     platforms, with only few variations. Many architectures use
> >     the same duplicated mmap_is_legacy() helper as well. There's
> >     usually just trivial differences between mmap_legacy_base()
> >     approaches as well.
> 
> I was nervous to start refactoring this code, but it's true: most of 
> it is the same.

Well, it still needs to be done if we want to add new randomization 
features: code fractured over multiple architectures is a receipe for 
bugs, as this series demonstrates. So it first has to be made more 
maintainable.

> >   - arch_mmap_rnd(): the PF_RANDOMIZE checks are needlessly
> >     exposed to the arch routine - the arch routine should only
> >     concentrate on arch details, not generic flags like
> >     PF_RANDOMIZE.
> 
> Yeah, excellent point. I will send a follow-up patch to move this 
> into binfmt_elf instead. I'd like to avoid removing it in any of the 
> other patches since each was attempting a single step in the 
> refactoring.

Finegrained patches are ideal!

> > In theory the mmap layout could be fully parametrized as well: 
> > i.e. no callback functions to architectures by default at all: 
> > just declarations of bits of randomization desired (or, available 
> > address space bits), and perhaps an arch helper to allow 32-bit 
> > vs. 64-bit address space distinctions.
> 
> Yeah, I was considering that too, since each architecture has a 
> nearly identical arch_mmap_rnd() at this point. Only the size of the 
> entropy was changing.
>
> > 'Weird' architectures could provide special routines, but only by 
> > overriding the default behavior, which should be generic, safe and 
> > robust.
> 
> Yeah, quite true. Should entropy size be a #define like 
> ELF_ET_DYN_BASE? Something like ASLR_MMAP_ENTROPY and 
> ASLR_MMAP_ENTROPY_32? [...]

That would work I suspect.

> [...] Is there a common function for determining a compat task? That 
> seemed to be per-arch too. Maybe arch_mmap_entropy()?

Compat flags are a bit of a mess, and since they often tie into arch 
low level assembly code, they are hard to untangle. So maybe as an 
intermediate step add an is_compat() generic method, and make that 
obvious and self-defined function a per arch thing?

But I'm just handwaving here - I suspect it has to be tried to see all 
the complications and to determine whether that's the best structure 
and whether it's a win ... Only one thing is certain: the current code 
is not compact and reviewable enough, and VM bits hiding in 
arch/*/mm/mmap.c tends to reduce net attention paid to these details.

Thanks,

	Ingo
