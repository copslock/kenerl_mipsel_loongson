Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2003 00:51:27 +0000 (GMT)
Received: from p508B4F8C.dip.t-dialin.net ([IPv6:::ffff:80.139.79.140]:7552
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225460AbTJaAvZ>; Fri, 31 Oct 2003 00:51:25 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9V0pONK011613;
	Fri, 31 Oct 2003 01:51:24 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9V0pMev011612;
	Fri, 31 Oct 2003 01:51:22 +0100
Date: Fri, 31 Oct 2003 01:51:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: new build failed
Message-ID: <20031031005122.GE803@linux-mips.org>
References: <Pine.GSO.4.44.0310301223570.22021-200000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310301223570.22021-200000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 30, 2003 at 12:29:13PM -0500, David Kesselring wrote:

> I just checked out the latest source from linux-mips and if failed to
> compile. Specifically this was a CVS update to a full build I checked out
> last month. It shouldn't matter, should it?
> Anyway here is the error and the .config file.

Ah, the one configuration I missed to test ...  Fix below,

  Ralf

Index: arch/mips/mm/tlbex-mips32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/Attic/tlbex-mips32.S,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 tlbex-mips32.S
--- arch/mips/mm/tlbex-mips32.S	28 Mar 2003 19:29:53 -0000	1.1.2.1
+++ arch/mips/mm/tlbex-mips32.S	31 Oct 2003 00:51:06 -0000
@@ -102,7 +102,7 @@
 #endif	
 	nop
 	mfc0	k0, CP0_BADVADDR		# Get faulting address
-	srl	k0, k0, PGDIR_SHIFT		# get pgd only bits
+	srl	k0, k0, _PGDIR_SHIFT		# get pgd only bits
 
 	sll	k0, k0, 2
 	addu	k1, k1, k0			# add in pgd offset
@@ -168,7 +168,7 @@
 #define LOAD_PTE(pte, ptr) \
 	GET_PGD(pte, ptr)          \
 	mfc0	pte, CP0_BADVADDR; \
-	srl	pte, pte, PGDIR_SHIFT; \
+	srl	pte, pte, _PGDIR_SHIFT; \
 	sll	pte, pte, 2; \
 	addu	ptr, ptr, pte; \
 	mfc0	pte, CP0_BADVADDR; \
