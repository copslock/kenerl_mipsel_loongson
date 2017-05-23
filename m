Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 14:40:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50119 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993905AbdEWMkJ45TWF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 14:40:09 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 52C6694233E8B;
        Tue, 23 May 2017 13:40:01 +0100 (IST)
Received: from [10.20.78.51] (10.20.78.51) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 23 May 2017
 13:40:02 +0100
Date:   Tue, 23 May 2017 13:39:23 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 3/4] MIPS16e2: Report ASE presence in /proc/cpuinfo
In-Reply-To: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1705230230220.2590@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.51]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
 Submitted third in the series so that the presence of "mips16e2" in 
/proc/cpuinfo not only indicates the hardware feature, but our correct 
unaligned emulation as well.

 There's a `checkpatch.pl' error reported for the unusual formatting, 
however it is consistent with surrounding code and I do not think we 
want to make this statement an oddball.

  Maciej

linux-mips16e2-ase-report.diff
Index: linux-sfr-test/arch/mips/kernel/proc.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/proc.c	2017-05-22 22:42:16.000000000 +0100
+++ linux-sfr-test/arch/mips/kernel/proc.c	2017-05-22 22:56:31.000000000 +0100
@@ -109,6 +109,7 @@ static int show_cpuinfo(struct seq_file 
 
 	seq_printf(m, "ASEs implemented\t:");
 	if (cpu_has_mips16)	seq_printf(m, "%s", " mips16");
+	if (cpu_has_mips16e2)	seq_printf(m, "%s", " mips16e2");
 	if (cpu_has_mdmx)	seq_printf(m, "%s", " mdmx");
 	if (cpu_has_mips3d)	seq_printf(m, "%s", " mips3d");
 	if (cpu_has_smartmips)	seq_printf(m, "%s", " smartmips");
