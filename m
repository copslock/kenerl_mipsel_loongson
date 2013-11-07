Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 19:36:15 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:65080 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823013Ab3KGSgMNC9L5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Nov 2013 19:36:12 +0100
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
        by relay1.mentorg.com with esmtp 
        id 1VeUR2-0002YW-Kc from Maciej_Rozycki@mentor.com ; Thu, 07 Nov 2013 10:36:04 -0800
Received: from SVR-IES-FEM-02.mgc.mentorg.com ([137.202.0.106]) by SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Nov 2013 10:36:03 -0800
Received: from [172.30.64.129] (137.202.0.76) by
 SVR-IES-FEM-02.mgc.mentorg.com (137.202.0.106) with Microsoft SMTP Server id
 14.2.247.3; Thu, 7 Nov 2013 18:36:02 +0000
Date:   Thu, 7 Nov 2013 18:35:54 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: copy_to_user_page: Avoid ptrace(2) I-cache
 incoherency
Message-ID: <alpine.DEB.1.10.1311071758410.21686@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 07 Nov 2013 18:36:03.0786 (UTC) FILETIME=[36C15AA0:01CEDBE8]
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

We currently support no MIPS processor that has its I-cache coherent with 
the D-cache, no such processor may even exist.  We apparently have two 
configurations that have fully coherent D-caches and therefore set 
cpu_has_ic_fills_f_dc, and these are the Alchemy and NetLogic processor 
families.  I have checked relevant CPU documentation I was able to track 
down and in both cases the respective documents[1][2] clearly state that 
the I-cache provides no hardware coherency and whenever instructions in 
memory are modified then the I-cache has to be synchronized by software 
even though the D-caches are fully coherent.

Therefore we cannot ever avoid the call to flush_cache_page in 
copy_to_user_page and here is a change that reflects this observation.  
The implementation of flush_cache_page may then choose freely whether it 
needs to perform a full cache synchronization with D-cache writeback and 
invalidation requests or whether a lone I-cache invalidation will suffice.  
The c-r4k.c implementation already respects the setting of 
cpu_has_ic_fills_f_dc and avoids touching the D-cache unless necessary.

The lack of I-cache synchronization is typically seen in debugging 
sessions e.g. with GDB where software breakpoints are used.  When such a 
breakpoint is hit and subsequently replaced using a ptrace(2) call with 
the original instruction, the BREAK instruction previously executed 
sometimes remains in the I-cache and causes the breakpoint just removed to 
hit again regardless, resulting in a spurious SIGTRAP signal delivery that 
debuggers typically complain about (e.g. "Program received signal SIGTRAP, 
Trace/breakpoint trap" in the case of GDB).  Of course the I-cache line 
containing the BREAK instruction may have since been randomly replaced, in 
which case no problem occurs.

[1] "AMD Alchemy Au1200 Processor Data Book", AMD Alchemy, January, 2005, 
    Publication ID: 32798A

[2] "XLP Processor Family Programming Reference Manual", NetLogic 
    Microsystems, Revision Level 1.10, February, 2011, Document Number 
    10724V110PM-CR (regrettably not publicly available)

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Ralf,

 Please apply.  I've seen these SIGTRAPs in some NetLogic GDB testing and 
the removal of this cpu_has_ic_fills_f_dc condition from copy_to_user_page 
is really necessary; also the Au1200 document is very explicit about the 
requirement of I-cache invalidation in software (see Section 2.3.7.3 
"Instruction Cache Coherency").

  Maciej

linux-mips-exec-cache-sync.diff
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3e0eb5f..1251d86 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -239,7 +239,7 @@ void copy_to_user_page(struct vm_area_struct *vma,
 		if (cpu_has_dc_aliases)
 			SetPageDcacheDirty(page);
 	}
-	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
+	if (vma->vm_flags & VM_EXEC)
 		flush_cache_page(vma, vaddr, page_to_pfn(page));
 }
 
