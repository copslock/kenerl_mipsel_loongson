Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2003 01:39:35 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:52467 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225428AbTJBAjd>;
	Thu, 2 Oct 2003 01:39:33 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h920dVO29910;
	Wed, 1 Oct 2003 17:39:31 -0700
Date: Wed, 1 Oct 2003 17:39:31 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Craig Mautner <craig.mautner@alumni.ucsd.edu>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: schedule() BUG
Message-ID: <20031001173931.B26517@mvista.com>
References: <JKEMLDJFFLGLICKLLEFJMEEOCOAA.craig.mautner@alumni.ucsd.edu> <20031001165023.A26517@mvista.com> <20031002000930.GA3264@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031002000930.GA3264@linux-mips.org>; from ralf@linux-mips.org on Thu, Oct 02, 2003 at 02:09:31AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 02, 2003 at 02:09:31AM +0200, Ralf Baechle wrote:
> On Wed, Oct 01, 2003 at 04:50:23PM -0700, Jun Sun wrote:
> 
> > This is an known problem.  Please try the attached patch.
> 
> No patch attached :-)
>

Doh!  Here you go.

Jun

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmalloc-fault-with-no-active-mm.patch"

diff -Nru link/arch/mips/mm/fault.c.orig link/arch/mips/mm/fault.c
--- link/arch/mips/mm/fault.c.orig	Fri May 10 18:50:08 2002
+++ link/arch/mips/mm/fault.c	Fri May 23 10:39:10 2003
@@ -260,7 +260,7 @@
 		pgd_t *pgd, *pgd_k;
 		pmd_t *pmd, *pmd_k;
 
-		pgd = tsk->active_mm->pgd + offset;
+		pgd = (pgd_t *) pgd_current[smp_processor_id()] + offset;
 		pgd_k = init_mm.pgd + offset;
 
 		if (!pgd_present(*pgd)) {

--tThc/1wpZn/ma/RB--
