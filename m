Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 17:39:33 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:39810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990718AbdL1QjWOJusB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Dec 2017 17:39:22 +0100
Received: from gandalf.local.home (cpe-172-100-180-131.stny.res.rr.com [172.100.180.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E1D9218B1;
        Thu, 28 Dec 2017 16:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1D9218B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date:   Thu, 28 Dec 2017 11:39:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH v6 8/8] x86/kernel: jump_table: use relative references
Message-ID: <20171228113915.47838609@gandalf.local.home>
In-Reply-To: <CAKv+Gu9Gza=RN_v_H-G7m7-qKg9B4Xf4GFvd_H-Gut-V3eabmA@mail.gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
        <20171227085033.22389-9-ard.biesheuvel@linaro.org>
        <20171228111926.28e82877@gandalf.local.home>
        <CAKv+Gu9Gza=RN_v_H-G7m7-qKg9B4Xf4GFvd_H-Gut-V3eabmA@mail.gmail.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <SRS0=oC7H=DY=goodmis.org=rostedt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61674
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

On Thu, 28 Dec 2017 16:26:07 +0000
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 28 December 2017 at 16:19, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 27 Dec 2017 08:50:33 +0000
> > Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >  
> >>  static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
> >>  {
> >> -     return entry->code;
> >> +     return (jump_label_t)&entry->code + entry->code;  
> >
> > I'm paranoid about doing arithmetic on abstract types. What happens in
> > the future if jump_label_t becomes a pointer? You will get a different
> > result.
> >  
> 
> In general, I share your concern. In this case, however, jump_label_t
> is typedef'd three lines up and is never used anywhere else.

I would agree if this was in a .c file, but it's in a header file,
which causes me to be more paranoid.

> 
> > Could we switch these calculations to something like:
> >
> >         return (jump_label_t)((long)&entrty->code + entry->code);
> >  
> 
> jump_label_t is local to this .h file, so it can be defined as u32 or
> u64 depending on the word size. I don't mind adding the extra cast,
> but I am not sure if your paranoia is justified in this particular
> case. Perhaps we should just use 'unsigned long' throughout?

Actually, that may be better. Have the return value be jump_label_t,
but the cast be "unsigned long". That way it should always work.

static inline jump_label_t jump_entry_code(...)
{
	return (unsigned long)&entry->code + entry->code;
}


-- Steve
