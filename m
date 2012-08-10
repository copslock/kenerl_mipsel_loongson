Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2012 12:34:02 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:39353 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903556Ab2HJKd6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2012 12:33:58 +0200
Received: by yhjj52 with SMTP id j52so1501436yhj.36
        for <multiple recipients>; Fri, 10 Aug 2012 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=KDR44Y4DP+chboZ5Ec702S/DNMGitC8I/mnwNYlAkq4=;
        b=lMK63xD58ct38Vy/QHpG4Es8OhxN7+6o3wfojfJlXPorvC4IGFKyMh113IKwOXMiNv
         QWYkLUh2S6IjOUXck7pRPHhvaLxtqZNza2R19or2FK8Dwmn4ImLVJRf6uZ0Q9QVa9LKf
         VjfYqFOBQ/C/A0Jm7I4smoIAEZ/ao5FLlHeMSMQ1Smn21RuoK4kn1FGJyB3gMRq2qHCG
         OQDGG2vAMg1oPTcZl0yE8kmljDrIdmJbSJ6+yPVTAmyapUdUzMRqKcKkQsd7TyFaWllC
         ep/y1moZgjPYvETy6cQOs/Or5OrGtZ4I2pR1gIdgt21Noo1GlVkCiXpF5PXOcZEuz1eZ
         wmHA==
Received: by 10.66.73.7 with SMTP id h7mr5333887pav.34.1344594831906;
        Fri, 10 Aug 2012 03:33:51 -0700 (PDT)
Received: from hades (111-243-156-32.dynamic.hinet.net. [111.243.156.32])
        by mx.google.com with ESMTPS id pi7sm3099179pbb.56.2012.08.10.03.33.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2012 03:33:50 -0700 (PDT)
Date:   Fri, 10 Aug 2012 18:33:34 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: init module specific mips_hi16_list to NULL
Message-ID: <20120810103334.GA1263@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34087
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

MIPS: init module specific mips_hi16_list to NULL

mips_hi16_list was moved from global to mod_arch_specific. While
global, it was bss initialized automatically, when moved to
mod_arch_specific, we have to do the zero initialization.

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
