Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 09:57:09 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:27622 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22563786AbYJ1J5A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 09:57:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9S9uuZ9006402;
	Tue, 28 Oct 2008 09:56:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9S9utlr006400;
	Tue, 28 Oct 2008 09:56:55 GMT
Date:	Tue, 28 Oct 2008 09:56:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/36] MIPSR2 ebase isn't just CAC_BASE
Message-ID: <20081028095655.GB18610@linux-mips.org>
References: <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:02:43PM -0700, David Daney wrote:

> On mips{32,64}r2, the ebase isn't just CAC_BASE, but also the part of
> read_c0_ebase() too.

That's a standard R2 feature - yet you were hiding it behind some ifdef
Cavium.  No good.  The patch was also missing another location to fix
up, set_uncached_handler().

Another thing I noticed is that we don't use write_c0_ebase(), so the
firmware better setup this correctly or we crash and burn.  We better
should initialize that right ...

So below my version which solves the first mentioned problem.  Just like
the bitops patch I posted earlier today this patch has become entirely
unrelated to the rest of the series so can applied before or after the
rest of the series.

  Ralf

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/kernel/traps.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-mips/arch/mips/kernel/traps.c
===================================================================
--- linux-mips.orig/arch/mips/kernel/traps.c
+++ linux-mips/arch/mips/kernel/traps.c
@@ -1576,6 +1576,8 @@ void __cpuinit set_uncached_handler(unsi
 #ifdef CONFIG_64BIT
 	unsigned long uncached_ebase = TO_UNCAC(ebase);
 #endif
+	if (cpu_has_mips_r2)
+		ebase += (read_c0_ebase() & 0x3ffff000);
 
 	if (!addr)
 		panic(panic_null_cerr);
@@ -1609,8 +1611,11 @@ void __init trap_init(void)
 
 	if (cpu_has_veic || cpu_has_vint)
 		ebase = (unsigned long) alloc_bootmem_low_pages(0x200 + VECTORSPACING*64);
-	else
+	else {
 		ebase = CAC_BASE;
+		if (cpu_has_mips_r2)
+			ebase += (read_c0_ebase() & 0x3ffff000);
+	}
 
 	per_cpu_trap_init();
 
@@ -1718,11 +1723,11 @@ void __init trap_init(void)
 
 	if (cpu_has_vce)
 		/* Special exception: R4[04]00 uses also the divec space. */
-		memcpy((void *)(CAC_BASE + 0x180), &except_vec3_r4000, 0x100);
+		memcpy((void *)(ebase + 0x180), &except_vec3_r4000, 0x100);
 	else if (cpu_has_4kex)
-		memcpy((void *)(CAC_BASE + 0x180), &except_vec3_generic, 0x80);
+		memcpy((void *)(ebase + 0x180), &except_vec3_generic, 0x80);
 	else
-		memcpy((void *)(CAC_BASE + 0x080), &except_vec3_generic, 0x80);
+		memcpy((void *)(ebase + 0x080), &except_vec3_generic, 0x80);
 
 	signal_init();
 #ifdef CONFIG_MIPS32_COMPAT
