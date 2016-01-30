Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 06:19:24 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35511 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009408AbcA3FRosmgEt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 06:17:44 +0100
Received: by mail-pa0-f67.google.com with SMTP id gi1so4521476pac.2;
        Fri, 29 Jan 2016 21:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n3NMpLzvZ6vGSOeSFJI+1sx6dZJjbQgOjnRvni8L3BI=;
        b=mF33iesVH12eRI0wsy84HIhc6K0L1HVqRuIhUVJZJgf7goGg8HxcRCgZsp5viJv6cL
         873/kkohLV8EPv8/CxqmNj/6x0Gs3y33GV78K8FkDnbfe06wIsJ+tlcgKad+ZAl7R03q
         vwcUar6RHc+Tf4QwxOm9AeIJHkbCHlGaw0Z1ZtnW4qzN/QWE2LNczBwNxKVLK+h3PW/r
         8FvuNcapxCfK3cDLPQxM6rSD0lu1B+o4CjUPuHnqStd30StISRXqePHE02gJnGlwjy6a
         5zcc3LNNihAoZi9GPCR8RCXRRA4v23vla+Gmi7arGGkYcPDLIDBFMJE2RnCPK2tx4kFA
         FZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n3NMpLzvZ6vGSOeSFJI+1sx6dZJjbQgOjnRvni8L3BI=;
        b=cWnM4JDlLtILrVQOUim1VjiNZCuW3TV5yEUjuaLkoyL5PUJEZx2TxpK+aTO6fww+hU
         J5UAqaP5jCExl1RuMdJsmZ3mW7fhtK8pQet/PQRY1pnvdUVBfhEuv30lP+yBM1Yf6M6z
         x8uvZlmriq01YqLKOMi6aWAPFVM6kvWB+ECdjJzmNsU5jGL02HfJj351lB6Cekc8McPi
         cSL+PWul+Gdr0BE85uLTkjAlOp/wmwFw5vBiEmPTeZKNguEFVITOfuTeuavVLvVHwhM6
         kEb5Tcf2L/piHpxcBv+WbQTUHnsek75y1ToCBRwPPVc8H23OluArTus+mmSw/h/Q0r7b
         rE4Q==
X-Gm-Message-State: AG10YOR8uU93W2wZ8B7rFR3x4yrhum+XNXHz9S/HCo5TKUby5XLhO06ci+4zjzwyiaXhGg==
X-Received: by 10.66.142.168 with SMTP id rx8mr19352444pab.16.1454131059092;
        Fri, 29 Jan 2016 21:17:39 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id a21sm7498645pfj.40.2016.01.29.21.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2016 21:17:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, jfraser@broadcom.com,
        pgynther@google.com, dragan.stancevic@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 6/6] MIPS: BMIPS: Fix PRID_IMP_BMIPS5000 masking for BMIPS5200
Date:   Fri, 29 Jan 2016 21:17:26 -0800
Message-Id: <1454131046-11124-7-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
References: <1454131046-11124-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

BMIPS5000 have a PrID value of 0x5A00 and BMIPS5200 have a PrID value of
0x5B00, which, masked with 0x5A00, returns 0x5A00. Update all conditionals on
the PrID to cover both variants since we are going to need this to enable
BMIPS5200 SMP. The existing check, masking with 0xFF00 would not cover
BMIPS5200 at all.

Fixes: 68e6a78373a6d ("MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)")
Fixes: 6465460c92a85 ("MIPS: BMIPS: change compile time checks to runtime checks")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/bmips_vec.S |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index 8649507..d9495f3 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -93,7 +93,8 @@ NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
 #if defined(CONFIG_CPU_BMIPS5000)
 	mfc0	k0, CP0_PRID
 	li	k1, PRID_IMP_BMIPS5000
-	andi	k0, 0xff00
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
+	andi	k0, PRID_IMP_BMIPS5000
 	bne	k0, k1, 1f
 
 	/* if we're not on core 0, this must be the SMP boot signal */
@@ -166,10 +167,12 @@ bmips_smp_entry:
 2:
 #endif /* CONFIG_CPU_BMIPS4350 || CONFIG_CPU_BMIPS4380 */
 #if defined(CONFIG_CPU_BMIPS5000)
-	/* set exception vector base */
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
 	li	k1, PRID_IMP_BMIPS5000
+	andi	k0, PRID_IMP_BMIPS5000
 	bne	k0, k1, 3f
 
+	/* set exception vector base */
 	la	k0, ebase
 	lw	k0, 0(k0)
 	mtc0	k0, $15, 1
@@ -263,6 +266,8 @@ LEAF(bmips_enable_xks01)
 #endif /* CONFIG_CPU_BMIPS4380 */
 #if defined(CONFIG_CPU_BMIPS5000)
 	li	t1, PRID_IMP_BMIPS5000
+	/* mask with PRID_IMP_BMIPS5000 to cover both variants */
+	andi	t2, PRID_IMP_BMIPS5000
 	bne	t2, t1, 2f
 
 	mfc0	t0, $22, 5
-- 
1.7.1
