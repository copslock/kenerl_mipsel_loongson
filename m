Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2009 06:11:27 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.183]:35212 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491882AbZGCELT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Jul 2009 06:11:19 +0200
Received: by wa-out-1112.google.com with SMTP id n4so395397wag.0
        for <multiple recipients>; Thu, 02 Jul 2009 21:05:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=mAjDatM+/Kk0Y2fluusm4cNIgeFzLzJ7jgaoItnN3pA=;
        b=FinuFO+O2gnWIBrCsWM6UhF7Y3xjMf5fccyLv/knJfQbjqL6AY9IN1p8Kg8gT4kVBJ
         f0whAkdLaS/+vBCIMjsS6owkI48appVSguwCliiFBLG8WP++A8PWlCEv+K/Hjh9ypIii
         fdMZfpja4bXO4Tkif7Jyhx20YNA4Hzh1Ai778=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=k7FT2dyi8r1bDli+k+KdJNyENb0Jnvz+lIV0tH0JzTi37z+C131+HKVJSYRTFY5NqW
         qHnbhj9vv8fwgXJwXLMOCESlWbgm7gh6j3e0Xt+dT/UN7DYEMS2Z6yGk99Gd46YxZL2f
         N1WdBcRMf7LQIfxXb8vI9u8trDV82gikek/CE=
Received: by 10.114.161.11 with SMTP id j11mr1231672wae.193.1246593923357;
        Thu, 02 Jul 2009 21:05:23 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id l38sm5432479waf.61.2009.07.02.21.05.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 21:05:22 -0700 (PDT)
Subject: Re: [PATCH] [MIPS] Hibernation: only save pages in system ram
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <1246591297.27828.165.camel@falcon>
References: <1246373570-21090-1-git-send-email-wuzhangjin@gmail.com>
	 <20090702232205.GE14804@linux-mips.org> <1246591297.27828.165.camel@falcon>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 03 Jul 2009 12:05:09 +0800
Message-Id: <1246593909.27828.193.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-07-03 at 11:21 +0800, Wu Zhangjin wrote:
> On Fri, 2009-07-03 at 00:22 +0100, Ralf Baechle wrote:
> > On Tue, Jun 30, 2009 at 10:52:50PM +0800, Wu Zhangjin wrote:
> > 
> > > From: Wu Zhangjin <wuzj@lemote.com>
> > > 
> > > when using hibernation(STD) with CONFIG_FLATMEM in linux-mips-64bit, it
> > > fails for the current mips-specific hibernation implementation save the
> > > pages in all of the memory space(except the nosave section) and make
> > > there will be not enough memory left to the STD task itself, and then
> > > fail. in reality, we only need to save the pages in system rams.
> > > 
> > > here is the reason why it fail:
> > > 
> > > kernel/power/snapshot.c:
> > > 
> > > static void mark_nosave_pages(struct memory_bitmap *bm)
> > > {
> > > 		...
> > > 		if (pfn_valid(pfn)) {
> > > 			...
> > > 		}
> > > }
> > > 
> > > arch/mips/include/asm/page.h:
> > > 
> > > 	...
> > > 	#ifdef CONFIG_FLATMEM
> > > 
> > > 	#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> > > 
> > > 	#elif defined(CONFIG_SPARSEMEM)
> > > 
> > > 	/* pfn_valid is defined in linux/mmzone.h */
> > > 	...
> > > 
> > > we can rewrite pfn_valid(pfn) to fix this problem, but I really do not
> > > want to touch such a widely-used macro, so, I used another solution:
> > > 
> > > static struct page *saveable_page(struct zone *zone, unsigned long pfn)
> > > {
> > > 	...
> > > 	if ( .... pfn_is_nosave(pfn)
> > > 		return NULL;
> > > 	...
> > > }
> > > 
> > > and pfn_is_nosave is implemented in arch/mips/power/cpu.c, so, hacking
> > > this one is better.
> > 
> > No - pfn_valid() is broken, so it should be fixed.  Commit
> > 752fbeb2e3555c0d236e992f1195fd7ce30e728d introduced the breakage.  It
> > seemed to assume that the valid range for PFNs doesn't start at 0 but
> > some higher number but got that entirely wrong..
> > 
> > #define ARCH_PFN_OFFSET         PFN_UP(PHYS_OFFSET)
> > #define pfn_valid(pfn)         ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> > 
> > works nicely when PHYS_OFFSET is 0 - as for most MIPS systems and goes
> > horribly wrong otherwise.  So I suggest below patch.
> 
> Just test it with the latest master branch of linux-mips on fulong2e,
> Your patch works well, thanks!
> 
> (BTW: of course, the ide-relative bug is also there even with Bart's
> patch, so, currently, I just revert this part of the ide patch: "ide:
> improve handling of Power Management requests" to test your patch: 
> 
> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index d5f3c77..8c4608c 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -468,12 +468,12 @@ void do_ide_request(struct request_queue *q)
>                 ide_hwif_t *prev_port;
>  repeat:
>                 prev_port = hwif->host->cur_port;
> -
> +/*
>                 if (drive->dev_flags & IDE_DFLAG_BLOCKED)
>                         rq = hwif->rq;
>                 else
>                         WARN_ON_ONCE(hwif->rq);
> -
> +*/
>                 if (drive->dev_flags & IDE_DFLAG_SLEEPING &&
>                     time_after(drive->sleep, jiffies)) {
>                         ide_unlock_port(hwif);
> 
> So, I will try to test Bart's patch with linux-next, I'm cloning it
> currently! perhaps there is something missing in my git repo or the
> linux-mips git repo? because i can not apply bart's patch neither to 
> git repo nor to the master branch of linux-mips git repo directly, even
> if pulled linux-next and Davie's ide-2.6 in.

Sorry, I have missed something in Bart's patch, Can apply it now, so
please ignore the above complaint.

but unfortunately, Bart's patch also not fix the problem of STD, I have
reported my test result in another E-mail thread: "[Bug #13663] suspend
to ram regression (IDE related)", so, please ignore this thread, thanks!

Regards,
Wu Zhangjin

> )
> 
> Regards,
> Wu Zhangjin
> 
> > 
> >   Ralf
> > 
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > 
> >  arch/mips/include/asm/page.h |    9 ++++++++-
> >  1 files changed, 8 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> > index dc0eaa7..96a14a4 100644
> > --- a/arch/mips/include/asm/page.h
> > +++ b/arch/mips/include/asm/page.h
> > @@ -165,7 +165,14 @@ typedef struct { unsigned long pgprot; } pgprot_t;
> >  
> >  #ifdef CONFIG_FLATMEM
> >  
> > -#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> > +#define pfn_valid(pfn)							\
> > +({									\
> > +	unsigned long __pfn = (pfn);					\
> > +	/* avoid <linux/bootmem.h> include hell */			\
> > +	extern unsigned long min_low_pfn;				\
> > +									\
> > +	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
> > +})
> >  
> >  #elif defined(CONFIG_SPARSEMEM)
> >  
