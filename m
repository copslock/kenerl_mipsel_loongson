Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2012 16:50:08 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34588 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903736Ab2HJOuE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2012 16:50:04 +0200
Received: by pbbrq8 with SMTP id rq8so1389971pbb.36
        for <multiple recipients>; Fri, 10 Aug 2012 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=O62PrF/a1dgPfsStQH2Ig1vO/Mku2KfWlVK9tSLdPqA=;
        b=Ushvb1OCh+QoGEWT9xxvbYUF2+NmWDZYjcgr5cofNs9+aCCJ9PStUjN8wQsjSXNAwE
         f3TT1hyLF+0JADCIXkAaitywyaGMcgZ1a/IoMYO4bb38mZJeD0I8cMLpJtiCAYiC3J/N
         O3RtCt9pqi1xG5AuYvEv/7dswY+WB0qya8o8sj3KMTtSJbEVepaMAZJ2+ZfdAKoQz9Y5
         /rk8oy7vGI6GxIloyLrfN4KBn+VBMZiy2EPnjjFUHZj1VLa6Ax6E9Au2UDZkpOKRiZuR
         /P28WH83M9Mu+1kHLLMgZNEByzo4AjCyAtVPNF9ajVUb/0y2wPggf3BVLg4JoSVAtTm5
         RU1A==
Received: by 10.68.134.161 with SMTP id pl1mr13161925pbb.29.1344610197264;
        Fri, 10 Aug 2012 07:49:57 -0700 (PDT)
Received: from hades (111-243-156-32.dynamic.hinet.net. [111.243.156.32])
        by mx.google.com with ESMTPS id ph1sm3473476pbb.45.2012.08.10.07.49.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2012 07:49:41 -0700 (PDT)
Date:   Fri, 10 Aug 2012 22:49:35 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH v2] MIPS: init module specific mips_hi16_list to NULL
Message-ID: <20120810144935.GA1395@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

In commit 6c06adb3838d03a20af2e2effc145121444c3189 (lmo) [MIPS: Fix
race condition in module relocation code.], mips_hi16_list was
moved from global to mod_arch_specific to handle parallel module
loading. While global, it was bss initialized to zero, when moved to
mod_arch_specific, we have to do the zero initialization manually.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/kernel/module.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 8b29976..8e1fb80 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -276,6 +276,7 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
 
+	me->arch.r_mips_hi16_list = NULL;
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-- 
1.7.4.4
