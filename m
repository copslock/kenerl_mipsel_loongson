Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2010 21:48:21 +0100 (CET)
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:44799 "EHLO
        ppsw-6.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492838Ab0CYUsP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Mar 2010 21:48:15 +0100
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:55087)
        by ppsw-6.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
        with esmtpa (EXTERNAL:aia21) id 1NutyO-0000sV-L2 (Exim 4.70)
        (return-path <aia21@hermes.cam.ac.uk>); Thu, 25 Mar 2010 20:48:12 +0000
Received: from aia21 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
        with local-esmtp id 1NutyO-0002As-GP (Exim 4.67)
        (return-path <aia21@hermes.cam.ac.uk>); Thu, 25 Mar 2010 20:48:12 +0000
Date:   Thu, 25 Mar 2010 20:48:12 +0000 (GMT)
From:   Anton Altaparmakov <aia21@cam.ac.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Chris Dearman <chris@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix __vmalloc(), etc on MIPS for non-GPL modules
Message-ID: <Pine.LNX.4.64.1003252017360.17596@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <aia21@hermes.cam.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aia21@cam.ac.uk
Precedence: bulk
X-list: linux-mips

Hi,

The commit 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0 which can be seen 
here:

http://kerneltrap.org/mailarchive/git-commits-head/2008/4/28/1639134

Breaks all non-GPL modules that use __vmalloc() or any of the vmap(), 
vm_map_ram(), etc functions on MIPS architecture.

All those functions are EXPORT_SYMBOL() so are meant to be allowed to be 
used by non-GPL kernel modules.  These calls all take page protection as 
an argument which is normally a constant like PAGE_KERNEL.

This commit causes all protection constants like PAGE_KERNEL to not be 
constants and instead to contain the GPL-only symbol 
_page_cachable_default.

This means that all calls to __vmalloc(), vmap(), etc, cause non-GPL 
modules to fail to link with the complaint that they are trying to use the 
GPL-only symbol _page_cachable_default...

I therefore propose that the EXPORT_SYMBOL_GPL(_page_cachable_default) is 
changed to EXPORT_SYMBOL(_page_cachable_default) to re-instate the 
ability for non-GPL modules to call __vmalloc(), vmap(), vm_map_ram(), 
and such like.

Here is a patch that does this.  If you approve, please apply it.

Thanks a lot in advance for your consideration.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/

---
[PATCH] Fix __vmalloc(), vmap(), vm_map_ram(), etc on MIPS for non-GPL modules.

Commit 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0 broke these functions for 
non-GPL modules by causing the page protection constants not to be 
constants any more and instead to include a GPL-only symbol and as these 
functions take a page protection argument this causes them to not be 
callable from non-GPL modules any more even though the functions are 
EXPORT_SYMBOL().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index be8627b..12af739 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -133,7 +133,7 @@ void __update_cache(struct vm_area_struct *vma, 
unsigned lon
 }
 
 unsigned long _page_cachable_default;
-EXPORT_SYMBOL_GPL(_page_cachable_default);
+EXPORT_SYMBOL(_page_cachable_default);
 
 static inline void setup_protection_map(void)
 {
