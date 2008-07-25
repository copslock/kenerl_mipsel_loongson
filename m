Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 20:22:29 +0100 (BST)
Received: from wilson.telenet-ops.be ([195.130.132.42]:11965 "EHLO
	wilson.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28580610AbYGYTW0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jul 2008 20:22:26 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by wilson.telenet-ops.be (Postfix) with SMTP id 90BB434009;
	Fri, 25 Jul 2008 21:22:25 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by wilson.telenet-ops.be (Postfix) with ESMTP id 3E0233401E;
	Fri, 25 Jul 2008 21:22:22 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m6PJMMVQ014561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 25 Jul 2008 21:22:22 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m6PJMK0Z014558;
	Fri, 25 Jul 2008 21:22:20 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 25 Jul 2008 21:22:20 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	ralf@linux-mips.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux-m68k@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-arch@vger.kernel.org
Subject: Re: [patch 29/29] initrd: Fix virtual/physical mix-up in overwrite
 test
In-Reply-To: <20080726.012731.122621958.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0807252104460.11082@anakin>
References: <20080717191758.556975996@mail.of.borg> <20080725.003526.39154055.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64.0807242032430.701@anakin> <20080726.012731.122621958.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463808415-4157885-1217013740=:11082"
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808415-4157885-1217013740=:11082
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 26 Jul 2008, Atsushi Nemoto wrote:
> On Thu, 24 Jul 2008 20:49:27 +0200 (CEST), Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Because an argument of mips virt_to_phys() is an pointer and
> > > initrd_start is unsigned long.  It seems most (all?) arch's
> > > virt_to_phys() casts its argument to unsigned long internally.  Should
> > > mips follow?
> > 
> > Alternatively, as initrd_start is really a virtual kernel address,
> > perhaps it should be changed from unsigned long to void * instead?
> > 
> > It's cast to `void *' in several place. arch/xtensa/kernel/setup.c even
> > has `extern void *initrd_start' to fool around this?
> 
> I agree it would make code cleaner, but the conversion might be
> somewhat hard.
> 
> If we converted initrd_start (and initrd_end) to void *, we should
> also convert INITRD_START, free_initrd_mem(), some other arch specific
> local/global variables and printk format strings.  Also code like
> "initrd_start & PAGE_MASK" should be changed too...
> 
> Is it worth to do?

Maybe not.

Several free_initrd_mem() implementations (including the mips one, which
has to call virt_to_phys()) just cast the parameters to `void *'.
Others call free_area() or free_init_pages() (other callers of these have to
cast `void *' to `unsigned long'!).

Further, we have:

    memset((void *)initrd_start, 0, initrd_end - initrd_start);

I agree `unsigned long' is nicer for `for (; start < end; start +=
PAGE_SIZE)' loops and `initrd_start & PAGE_MASK' (don't we have a macro
for that?), though.

So there's definitely room for a small janitors project...

Probably the best short term solution is to make mips' virt_to_page()
cast to `unsigned long' internally, like the other platforms.

Alternatively, you can try the patch below (compile-tested on mips :-),
which does add a cast to the generic code.

Subject: [PATCH] initrd: cast `initrd_start' to `void *'

commit fb6624ebd912e3d6907ca6490248e73368223da9 (initrd: Fix virtual/physical
mix-up in overwrite test) introduced the compiler warning below on mips,
as its virt_to_page() doesn't cast the passed address to unsigned long
internally, unlike on most other architectures:

init/main.c: In function ‘start_kernel’:
init/main.c:633: warning: passing argument 1 of ‘virt_to_phys’ makes pointer from integer without a cast
init/main.c:636: warning: passing argument 1 of ‘virt_to_phys’ makes pointer from integer without a cast

For now, kill the warning by explicitly casting initrd_start to `void *', as
that's the type it should really be.

Noticed by Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

diff --git a/init/main.c b/init/main.c
index 756eca4..525b2ac 100644
--- a/init/main.c
+++ b/init/main.c
@@ -630,10 +630,11 @@ asmlinkage void __init start_kernel(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
-	    page_to_pfn(virt_to_page(initrd_start)) < min_low_pfn) {
+	    page_to_pfn(virt_to_page((void *)initrd_start)) < min_low_pfn) {
 		printk(KERN_CRIT "initrd overwritten (0x%08lx < 0x%08lx) - "
 		    "disabling it.\n",
-		    page_to_pfn(virt_to_page(initrd_start)), min_low_pfn);
+		    page_to_pfn(virt_to_page((void *)initrd_start)),
+		    min_low_pfn);
 		initrd_start = 0;
 	}
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---1463808415-4157885-1217013740=:11082--
