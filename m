Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:04:35 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:54483 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835022Ab3FGXDwoX8aA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:52 +0200
Received: by mail-ie0-f182.google.com with SMTP id 9so12059186iec.41
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ch+pGPmG2SsXl/nYVYbYSdwF2ejA46SAHo0b5SS+JwI=;
        b=QMlB/3rN0OMnSmaPAYldWHoQPrExIAxlP7ZGePgheafrs12C0jiWo2HuPdpeUfHqHb
         dTFUgQoZ6R4L0iGYofaeOmGWMgn9yGCx3HS4DR+BIcVSD50lJbgB/7X6GW4W/s/qfIrW
         3vGpks+nGbSvOxbA9xCbmXVuXHtH5Rrzqb0US665VaMn+Pl4UKxCtMn89BMyYtrAQix1
         LFIpg1AlN51imB3xEU9uCmhAQ6Vx8XXfEH75cKEGlOjZQI0wbigjchqE1yurwIiyV/6B
         cqPcR9oCqbdSNPshhbWDMnGOaDBe5UlLbvHJvte7rUkfaVVSRS9afTClHTvUV4APXV+J
         s+jg==
X-Received: by 10.50.114.161 with SMTP id jh1mr368179igb.112.1370646226459;
        Fri, 07 Jun 2013 16:03:46 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id d9sm194172igr.4.2013.06.07.16.03.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:45 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3hCM006622;
        Fri, 7 Jun 2013 16:03:43 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3hKn006621;
        Fri, 7 Jun 2013 16:03:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 03/31] mips/kvm: Fix 32-bitisms in kvm_locore.S
Date:   Fri,  7 Jun 2013 16:03:07 -0700
Message-Id: <1370646215-6543-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

For a warning free compile, we need to use the width aware PTR_LI and
PTR_LA macros.  Use LI variant for immediate data and LA variant for
addresses.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kvm/kvm_locore.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
index dca2aa6..e86fa2a 100644
--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -310,7 +310,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
     LONG_S  t0, VCPU_R26(k1)
 
     /* Get GUEST k1 and save it in VCPU */
-    la      t1, ~0x2ff
+	PTR_LI	t1, ~0x2ff
     mfc0    t0, CP0_EBASE
     and     t0, t0, t1
     LONG_L  t0, 0x3000(t0)
@@ -384,14 +384,14 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
     mtc0        k0, CP0_DDATA_LO
 
     /* Restore RDHWR access */
-    la      k0, 0x2000000F
+	PTR_LI	k0, 0x2000000F
     mtc0    k0,  CP0_HWRENA
 
     /* Jump to handler */
 FEXPORT(__kvm_mips_jump_to_handler)
     /* XXXKYMA: not sure if this is safe, how large is the stack?? */
     /* Now jump to the kvm_mips_handle_exit() to see if we can deal with this in the kernel */
-    la          t9,kvm_mips_handle_exit
+	PTR_LA	t9, kvm_mips_handle_exit
     jalr.hb     t9
     addiu       sp,sp, -CALLFRAME_SIZ           /* BD Slot */
 
@@ -566,7 +566,7 @@ __kvm_mips_return_to_host:
     mtlo    k0
 
     /* Restore RDHWR access */
-    la      k0, 0x2000000F
+	PTR_LI	k0, 0x2000000F
     mtc0    k0,  CP0_HWRENA
 
 
-- 
1.7.11.7
