Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jul 2008 00:19:57 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.245]:8425 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20042651AbYGEXTv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 6 Jul 2008 00:19:51 +0100
Received: by rv-out-0708.google.com with SMTP id c5so1632272rvf.24
        for <linux-mips@linux-mips.org>; Sat, 05 Jul 2008 16:19:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:date:from;
        bh=Gfgj7q+mKExEZM1fpL4AKEb+sPPRDjJ2vBHGLK0E3Zg=;
        b=m1VMFR5BBjN/dcRSsnLamECafik/hQrvll+Xldw/oFvhuXcQbziK//qyCtcHDpEUCo
         zlf1xCVpKDkZrEo9xubCNlgC9EIf/4Ac/MjjwlOT6+ebksHzPHeeij6sltkgROxSSyhK
         FttMP+VoSDwc2MTnX+q8Zmi6ysr7dS18QQUTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:date:from;
        b=gfkpS62qo9zPPo9SQfCLVbb1tsj3KPMHRcgVjL1Y1mQE+faSFy+M2tFI5xBJ0V/1rX
         jDbMiWkNJD9R4b75I7OoTndg+w2KwBcEML+zEEU4WhtAp1TYXFV16V3DlPdR+YhAqtSf
         +TDMjXHx0SZpwQV+12cbYWrCR5jZDPrw88R9M=
Received: by 10.140.133.9 with SMTP id g9mr1260760rvd.235.1215299987928;
        Sat, 05 Jul 2008 16:19:47 -0700 (PDT)
Received: from localhost ( [207.47.250.104])
        by mx.google.com with ESMTPS id c20sm3324620rvf.1.2008.07.05.16.19.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 16:19:46 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1KFH2c-0005iq-80; Sat, 05 Jul 2008 17:19:42 -0600
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [MIPS] Fix section mismatches when compiling atlas and decstation defconfigs
Message-Id: <E1KFH2c-0005iq-80@localhost>
Date:	Sat, 05 Jul 2008 17:19:42 -0600
From:	Shane McDonald <mcdonald.shane@gmail.com>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

From: Shane McDonald <mcdonald.shane@gmail.com>

Section mismatches are reported when compiling the default
Atlas configuration and the default Decstation configuration.
This patch resolves those mismatches by defining affected
functions with the __cpuinit attribute, rather than __init.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/mm/c-r3k.c   |    6 +++---
 arch/mips/mm/sc-rm7k.c |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff -uprN -X orig/Documentation/dontdiff orig/arch/mips/mm/c-r3k.c patched/arch/mips/mm/c-r3k.c
--- orig/arch/mips/mm/c-r3k.c	2008-07-04 17:22:25.000000000 -0600
+++ patched/arch/mips/mm/c-r3k.c	2008-07-05 11:56:01.000000000 -0600
@@ -26,7 +26,7 @@
 static unsigned long icache_size, dcache_size;		/* Size in bytes */
 static unsigned long icache_lsize, dcache_lsize;	/* Size in bytes */
 
-unsigned long __init r3k_cache_size(unsigned long ca_flags)
+unsigned long __cpuinit r3k_cache_size(unsigned long ca_flags)
 {
 	unsigned long flags, status, dummy, size;
 	volatile unsigned long *p;
@@ -61,7 +61,7 @@ unsigned long __init r3k_cache_size(unsi
 	return size * sizeof(*p);
 }
 
-unsigned long __init r3k_cache_lsize(unsigned long ca_flags)
+unsigned long __cpuinit r3k_cache_lsize(unsigned long ca_flags)
 {
 	unsigned long flags, status, lsize, i;
 	volatile unsigned long *p;
@@ -90,7 +90,7 @@ unsigned long __init r3k_cache_lsize(uns
 	return lsize * sizeof(*p);
 }
 
-static void __init r3k_probe_cache(void)
+static void __cpuinit r3k_probe_cache(void)
 {
 	dcache_size = r3k_cache_size(ST0_ISC);
 	if (dcache_size)
diff -uprN -X orig/Documentation/dontdiff orig/arch/mips/mm/sc-rm7k.c patched/arch/mips/mm/sc-rm7k.c
--- orig/arch/mips/mm/sc-rm7k.c	2008-07-04 17:22:25.000000000 -0600
+++ patched/arch/mips/mm/sc-rm7k.c	2008-07-05 09:51:34.000000000 -0600
@@ -86,7 +86,7 @@ static void rm7k_sc_inv(unsigned long ad
 /*
  * This function is executed in uncached address space.
  */
-static __init void __rm7k_sc_enable(void)
+static __cpuinit void __rm7k_sc_enable(void)
 {
 	int i;
 
@@ -107,7 +107,7 @@ static __init void __rm7k_sc_enable(void
 	}
 }
 
-static __init void rm7k_sc_enable(void)
+static __cpuinit void rm7k_sc_enable(void)
 {
 	if (read_c0_config() & RM7K_CONF_SE)
 		return;
