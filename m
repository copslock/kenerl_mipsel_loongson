Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2011 10:07:10 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:45780 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491086Ab1HVIHG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Aug 2011 10:07:06 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1QvPXE-0003DT-Ci; Mon, 22 Aug 2011 08:07:04 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1QvPX8-0005tD-Md; Mon, 22 Aug 2011 10:06:58 +0200
Date:   Mon, 22 Aug 2011 10:06:58 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: [PATCH] mips/loongson: unify compiler flags and load location
        for Loongson 2E and 2F
Message-ID: <20110822080658.GA2657@mails.so.argh.org>
Mail-Followup-To: Andreas Barth <aba@not.so.argh.org>,
        Matt Turner <mattst88@gmail.com>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
References: <20110821010513.GZ2657@mails.so.argh.org> <CAEdQ38G8VEh+Q0gOZb7_YgvQK6n2f3u=Bep59tZ9hGJfz+C08Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEdQ38G8VEh+Q0gOZb7_YgvQK6n2f3u=Bep59tZ9hGJfz+C08Q@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15592

* Matt Turner (mattst88@gmail.com) [110822 02:20]:
> On Sat, Aug 20, 2011 at 9:05 PM, Andreas Barth <aba@not.so.argh.org> wrote:
> > diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
> > index 29692e5..d6471a5 100644
> > --- a/arch/mips/loongson/Platform
> > +++ b/arch/mips/loongson/Platform
> > @@ -4,10 +4,8 @@
> >
> >  # Only gcc >= 4.4 have Loongson specific support
> >  cflags-$(CONFIG_CPU_LOONGSON2) += -Wa,--trap
> > -cflags-$(CONFIG_CPU_LOONGSON2E) += \
> > -       $(call cc-option,-march=loongson2e,-march=r4600)
> > -cflags-$(CONFIG_CPU_LOONGSON2F) += \
> > -       $(call cc-option,-march=loongson2f,-march=r4600)
> > +cflags-$(CONFIG_CPU_LOONGSON2) += \
> > +       $(call cc-option,-march=r4600)
> >  # Enable the workarounds for Loongson2f
> >  ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
> >   ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
> 
> ... but I don't understand this one.
> 
> So, in the name of simplification, let's just remove the ability to
> compile with -march=loongson2{e,f}? What?

I want to build a kernel that works on both 2e and 2f. Such a kernel
must not be built with 2e or 2f specific code (which are incompatible
to each other).

> Is there some case where a -march=loongson2e kernel won't work on a 2F
> system?

Yes. There are 2E opcodes removed in the 2F. See e.g.
http://media.romanrm.ru/loongson/info/Loongson%202F%20Datasheet.pdf 
  Implementing all the features described in the MIPSIII, Loongson 2E
  has some of custom instructions occupied the MIPS-reserved
  instruction slot.  So in the 2F, these custom-tailored instruction
  opcodes need to remove to the user instruction slot (COP2 or
  Special2).

(I could of course check if a kernel has such opcodes included. But
I'm unhappy to use compiler instructions which might end in invalid
code.


> The commit message should explain this stuff.

Ok.




Andi
