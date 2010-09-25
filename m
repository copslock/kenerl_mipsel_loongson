Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Sep 2010 21:20:26 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:53892 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491182Ab0IYTUX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Sep 2010 21:20:23 +0200
Received: by iwn36 with SMTP id 36so4052135iwn.36
        for <multiple recipients>; Sat, 25 Sep 2010 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=gzWwSA/jANMypSfr7AomUIMcWlalqeQnv4Uep8OALLA=;
        b=sX5GaPjklehcIFNjPlLD6Sr57+N4d8yoNUHgMyUUl3DCN0/AfZnaH0ahvLlnzl0rDp
         bVlOpCXeR3SDdl624ge88Zc6C2VQnezefeVRHdEc8eretsLgI/Ky3bGSZROFzYmXRXUE
         alJV9PdkLP2GHWTVceqNKmMoY0CAMW+UWmq04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=gNYiJVqk327p07VJ5NSupLG6mN0i44uEr4xX3HonEnNv/mlmCK2kbA9MyxQX30dtgD
         HFIVKAoU3jTY4ciZ5X5AQDub6F/ml2XxMixsfkrizJThm+oaGDmx2tZzwfvZNzPJMrku
         SrFX4GlS5BOGnuUELsHpWZRSmAkIUBrQ2huVA=
Received: by 10.231.155.7 with SMTP id q7mr6166813ibw.105.1285442421302; Sat,
 25 Sep 2010 12:20:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.140.6 with HTTP; Sat, 25 Sep 2010 12:20:01 -0700 (PDT)
From:   Dragos Tatulea <dragos.tatulea@gmail.com>
Date:   Sat, 25 Sep 2010 21:20:01 +0200
Message-ID: <AANLkTikJ4wreMMU0y-k7MRg_ju_u2BNu66mqq2NAY-xi@mail.gmail.com>
Subject: [PATCH] Fix MIPS math-emu -Werror compile failure encountered while
 doing a Malta build.
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dragos.tatulea@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20301

Signed-off-by: Dragos Tatulea <dragos.tatulea@gmail.com>
---
 arch/mips/math-emu/cp1emu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 47842b7..c0af7f1 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1243,7 +1243,7 @@ int fpu_emulator_cop1Handler(struct pt_regs
*xcp, struct mips_fpu_struct *ctx,
        int has_fpu)
 {
        unsigned long oldepc, prevepc;
-       mips_instruction insn;
+       mips_instruction uninitialized_var(insn);
        int sig = 0;

        oldepc = xcp->cp0_epc;
-- 
1.7.2.3
