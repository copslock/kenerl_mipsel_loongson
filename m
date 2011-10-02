Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Oct 2011 09:26:25 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:43918 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491090Ab1JBH0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Oct 2011 09:26:19 +0200
Received: by wyi11 with SMTP id 11so2926509wyi.36
        for <multiple recipients>; Sun, 02 Oct 2011 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=RnzzuiM1xlTgkKgoGcttznR78IK9iRhzSWhPQX/QtcA=;
        b=woP3lIZ2cNdBnHFVlhAGJz/H+ww1JCbE1IzVqKl/Tu+Ai0x1lU1XBai0KgMgwag61f
         q1WvKhrmUUXApybqZP/LRzDC0Bp7v91JtgMruIpTdQ4Y92UorPPVAXvnY7EzhZW1dteh
         2HslDxrj+3Cw+bl1XphX46OdLUhoLWI01QGPg=
MIME-Version: 1.0
Received: by 10.216.198.84 with SMTP id u62mr11990528wen.13.1317540374092;
 Sun, 02 Oct 2011 00:26:14 -0700 (PDT)
Received: by 10.216.73.193 with HTTP; Sun, 2 Oct 2011 00:26:14 -0700 (PDT)
Date:   Sun, 2 Oct 2011 15:26:14 +0800
Message-ID: <CAJd=RBAc8Zv1JZfrAx2Ajj7fdJv=oA+eYHVBLfcFNOoZNyG7fg@mail.gmail.com>
Subject: [RFC] mark Netlogic XLR chip as SMT capable
From:   Hillf Danton <dhillf@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 433

Netlogic XLR chip has multiple cores. Each core includes four integrated
hardware threads, and they share L1 data and instruction caches.

If XLR chip is marked to be SMT capable, linux scheduler then could do more,
say idle load balancing.

Any comment is welcom, thanks.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/netlogic/xlr/smp.c	Sun Oct  2 14:15:28 2011
+++ b/arch/mips/netlogic/xlr/smp.c	Sun Oct  2 14:15:58 2011
@@ -176,6 +176,7 @@ void __init nlm_smp_setup(void)

 void nlm_prepare_cpus(unsigned int max_cpus)
 {
+	smp_num_siblings = 4;
 }

 struct plat_smp_ops nlm_smp_ops = {
--- a/arch/mips/kernel/smp.c	Sun Oct  2 14:12:09 2011
+++ b/arch/mips/kernel/smp.c	Sun Oct  2 14:14:58 2011
@@ -73,7 +73,12 @@ static inline void set_cpu_sibling_map(i

 	if (smp_num_siblings > 1) {
 		for_each_cpu_mask(i, cpu_sibling_setup_map) {
-			if (cpu_data[cpu].core == cpu_data[i].core) {
+			if (current_cpu_type() == CPU_XLR) {
+				if (((i>>2) & 0x7) == ((cpu>>2) & 0x7))
+					goto set;
+			}
+			else if (cpu_data[cpu].core == cpu_data[i].core) {
+set:
 				cpu_set(i, cpu_sibling_map[cpu]);
 				cpu_set(cpu, cpu_sibling_map[i]);
 			}
