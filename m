Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 20:44:20 +0100 (BST)
Received: from ms-smtp-03.rdc-nyc.rr.com ([24.29.109.7]:6044 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by ftp.linux-mips.org with ESMTP
	id S20038647AbWJRToS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 20:44:18 +0100
Received: from amiga (cpe-74-68-39-174.nj.res.rr.com [74.68.39.174])
	by ms-smtp-03.rdc-nyc.rr.com (8.13.6/8.13.6) with ESMTP id k9IJiFTW002212
	for <linux-mips@linux-mips.org>; Wed, 18 Oct 2006 15:44:16 -0400 (EDT)
Date:	Wed, 18 Oct 2006 15:45:50 -0400
From:	Antonio SJ Musumeci <bile@landofbile.com>
To:	linux-mips@linux-mips.org
Subject: Re: patch: include/asm-mips/system.h __cmpxchg64 bugfix and cleanup
Message-ID: <20061018154550.5ac7a0fb@amiga>
In-Reply-To: <20061018184159.GC4051@networkno.de>
References: <200610121802.k9CI26I5017308@ms-smtp-01.rdc-nyc.rr.com>
 <20061013104250.GA16820@linux-mips.org>
 <452F9A41.4020505@landofbile.com>
 <20061013141101.GA19260@linux-mips.org>
 <20061013151841.3a902627@amiga>
 <20061015184226.GA3259@linux-mips.org>
 <20061018140818.3e40b0a4@amiga>
 <20061018184159.GC4051@networkno.de>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <bile@landofbile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bile@landofbile.com
Precedence: bulk
X-list: linux-mips

It's not a good style... you shouldn't be relying on optimization to
protect you from bad coding practices. It goes against the
style of the other macros defined by the config and leads to bugs like
this:

Signed-off-by: Antonio SJ Musumeci <bile@landofbile.com>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index cc895da..4084dc3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -842,7 +842,7 @@ static void __init probe_pcache(void)
                c->dcache.ways = 4;
                c->dcache.waybit = __ffs(dcache_size / c->dcache.ways);

-#if !defined(CONFIG_SMP) || !defined(RM9000_CDEX_SMP_WAR)
+#if !defined(CONFIG_SMP) || !RM9000_CDEX_SMP_WAR
                c->options |= MIPS_CPU_CACHE_CDEX_P;
 #endif
                c->options |= MIPS_CPU_PREFETCH;



On Wed, 18 Oct 2006 19:41:59 +0100
Thiemo Seufer <ths@networkno.de> wrote:

> Antonio SJ Musumeci wrote:
> > I'm not talking about that. This patch explains it. Moving
> > the conditional compilation from the optimizer to the preprocessor.
> > I see no reason to be using hard coded 1's and 0's in runtime logic.
> 
> It is easier to read than a ifdef maze, and the net result is the
> same.
> 
> 
> Thiemo
> 
> 
