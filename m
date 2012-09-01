Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2012 17:01:25 +0200 (CEST)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:53916 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903297Ab2IAPBS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Sep 2012 17:01:18 +0200
Received: by vcbfl15 with SMTP id fl15so4526389vcb.36
        for <multiple recipients>; Sat, 01 Sep 2012 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=r0OZiZ0zzPsK9c0N9CexNfLBdMDybaQwdYOZBEHUTjI=;
        b=vuk/HxXIuDo3AZngAm4HjbBaVpDA2D48hGF8ib0r46J2ELq+F8QbIvq2I0aC7sqkbb
         8/vSYooc2QdmPAFIVf98g+L2sKWQJ5oaU8RgXSVrTqxea42/KRCWpDIsqKrjykIT466m
         TwJYhWWLGTlh1tKxvaoEvb/XkKvjManHSb42yiJzvhFOmevy2lKgh4ULHYSgyhBNUxZg
         RFskidxejfXfeMeA8pHEp+9fw06ccB5VOCo10MuX2lUKqgtLyAgUeHYxZ3TL72jxPOXZ
         zteBNqq5VF+1dtaiajUDIqBoh0PnpLYbHEFUOspDHhY7kdVmrbohcPhbJ3ZP13CI87cV
         xQKg==
MIME-Version: 1.0
Received: by 10.52.70.46 with SMTP id j14mr6391340vdu.42.1346511672850; Sat,
 01 Sep 2012 08:01:12 -0700 (PDT)
Received: by 10.220.96.148 with HTTP; Sat, 1 Sep 2012 08:01:12 -0700 (PDT)
Date:   Sat, 1 Sep 2012 23:01:12 +0800
Message-ID: <CAJd=RBDuFF409=DQS-iErAT57K6x0yff+2a-7ReXQQOqyOxsFA@mail.gmail.com>
Subject: [patch] MIPS: align address to HPAGE_SIZE when updating mmu for thp
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Hillf Danton <dhillf@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
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

Make certain that we are always handling head page in all cases if address
is aligned to HPAGE_SIZE.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/include/asm/pgtable.h	Sat Sep  1 22:27:12 2012
+++ b/arch/mips/include/asm/pgtable.h	Sat Sep  1 22:38:02 2012
@@ -546,7 +546,7 @@ static inline pmd_t pmdp_get_and_clear(s
 static inline void update_mmu_thp(struct vm_area_struct *vma,
 					unsigned long addr, pmd_t *pmdp)
 {
-	update_mmu_cache(vma, addr, (pte_t *)pmdp);
+	update_mmu_cache(vma, addr & HPAGE_PMD_MASK, (pte_t *)pmdp);
 }

 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
--
