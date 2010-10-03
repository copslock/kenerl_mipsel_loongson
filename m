Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2010 17:03:47 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:63741 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492037Ab0JCPDn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Oct 2010 17:03:43 +0200
Received: by wwe15 with SMTP id 15so1312600wwe.24
        for <multiple recipients>; Sun, 03 Oct 2010 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:in-reply-to:references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ooIAa4QcA6OToTflPbblyXzLDwTGq+CIS/blyXaeln8=;
        b=QssdQIsmrAHW4dNriLkQ95UtujWQFkQMKStDrV5XdXoM3V6Q6p3hnsdeV8v6XfBM3z
         BsSTeDMRKG33c2HgFaTHWuNRuSotEN3KFSHQpF6+7KAYP6xaImnOWhpgzVsvHKvL3ySm
         vicGg8Ucf4EboovX07DpsIp5+5d8ODw/DEauE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=mCDGUSazkfDZPAEppc6QD6beysHIrYHftzGPfzCV7gwN+1nz2bol3H+HBxttCZ/agc
         9dJDWtQd+7CVeZzbTY3Wf8RTNHYenXjFDGzSo4XH44BJxfpNphX8yEQL7mao8PDwfqKe
         MEqNIFntxauMgYqLw8r6dh2GbzfYzLhyh7/T0=
Received: by 10.227.128.144 with SMTP id k16mr6502218wbs.196.1286118216512;
        Sun, 03 Oct 2010 08:03:36 -0700 (PDT)
Received: from pixies.home.jungo.com (wall-ext.jungo.com [194.90.113.98])
        by mx.google.com with ESMTPS id g9sm3177068wbh.7.2010.10.03.08.03.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 08:03:35 -0700 (PDT)
Message-ID: <4ca89b47.893ae30a.2b4d.ffff8a21@mx.google.com>
Date:   Sun, 3 Oct 2010 17:03:31 +0200
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     wuzhangjin@gmail.com, linux-mips@linux-mips.org,
        alex@digriz.org.uk, manuel.lauss@googlemail.com, sam@ravnborg.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix vmlinuz to flush the caches after kernel
 decompression
In-Reply-To: <20100921101105.GA32343@linux-mips.org>
References: <4c7e1a3a.c83ddf0a.5918.ffffcf6a@mx.google.com>
        <20100921101105.GA32343@linux-mips.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.18.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <shmulik.ladkani@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shmulik.ladkani@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 21 Sep 2010 11:11:05 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:

> 
> Correct - but it's also a can of worms which is why I intentionally
> ignored the issue so far.  An I-cache is refilled from L2/L3 (if available)
> or memory.  The large amounts of data written by the CPU during
> decompression of the kernel virtually guarantee that all code will be
> written back to L2/L3 or memory and the I-cache has been flushed by
> firmware before the decompressor was entered.
> 
> Does this assumption fail for you?

Yes.
Indeed, decompressed code has been written-back to memory.
However, there was no flushing of the I-cache by the firmware; actually, there
was no firmware involved - I've tried to boot a kernel from a running kernel
(the "first" kernel acting as a bootloader).
The first kernel could have flushed the I-cache before passing execution to
the decompressor; however I thought it's more appropriate if the decompressor
takes care of that, as the decompressor is the one who actually writes the
instructions of the "second" kernel.

> > The patch implements L1 cache flushing, for r4k style caches - suitable for
> > all MIPS32 CPUs (and probably for other CPUs too).
> 
> No - you only compile the code for MIPS32 CPUs and check for MIPS_CONF_M
> which - at least with this meaning - only exists on MIPS32 and MIPS64 CPUs.

Ok, will fix Makefile and git log appropriately in V2.

> > +#define INDEX_BASE CKSEG0
> > +
> > +extern void puts(const char *s);
> > +extern void puthex(unsigned long long val);
> > +
> > +#define cache_op(op, addr)			\
> > +	__asm__ __volatile__(			\
> > +	"	.set push		\n"	\
> > +	"	.set noreorder		\n"	\
> > +	"	.set mips3		\n"	\
> > +	"	cache %1, 0(%0)		\n"	\
> > +	"	.set pop		\n"	\
> > +	:					\
> > +	: "r" (addr), "i" (op))
> 
> This duplicates the definition of arch/mips/include/asm/r4kcache.h.  Why?

Ok, will include r4kcache.h instead.

Actually, I really wanted to use the blast_XXX macros of r4kcache.h instead
of re-implementing, but it required an initialized 'cpu_data' structure
and overloaded 'smp_processor_id' (or some other trick to have a valid
'current_cpu_data'); IMO this was not suitable for a small decompressor
executable.

> > +#define cache_all_index_op(cachesz, linesz, op) do {			\
> > +	unsigned long addr = INDEX_BASE;				\
> > +	for (; addr < INDEX_BASE + (cachesz); addr += (linesz))		\
> > +		cache_op(op, addr);					\
> > +} while (0)
> 
> For consistence in formatting please move the "do {" to the beginning of
> the next line.

Ok.

> > +void cache_flush(void)
> > +{
> > +	volatile unsigned long config1;
> 
> I don't know why you're using volatile here - but it won't work as you
> intended.  Just drop the keyword.

Ok, will remove volatile keyword.
My intention was to avoid any compilation optimization of read_c0_config1,
as sometimes, when code was organized differently, I got 0xffffffff.

> > +	unsigned long tmp;
> > +	unsigned long line_size;
> > +	unsigned long ways;
> > +	unsigned long sets;
> > +	unsigned long cache_size;
> 
> Make these int variables.  The code here is fine for MIPS64 as well but
> there is no point in having 64-bit variables and multiplies.

Ok.

> Eww...  You copied (my ...) old sin from c-r4k.c and use all the magic
> numbers.

I didn't feel well about it either; there's no simple way to refactor the
c-r4k.c code.

> Anyway, does this actually fix a bug for you or is it more a theoretical
> convern?

Yes, this was necessary, but could have been solved differently - as described
in my first comment. 
If it's guaranteed that the entity executing the decompressor (firmware,
bootloader, etc...) is resposible for flushing the caches, then this fix is
not needed.
Please let me know your approach on this; I'll resubmit a V2 of the patch if
necessary.

-- 
Shmulik Ladkani
