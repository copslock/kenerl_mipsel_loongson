Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:13:58 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:51075 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835220Ab3FGXEAwEQI7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:04:00 +0200
Received: by mail-ie0-f177.google.com with SMTP id u16so12057596iet.22
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=a59tVtzIe93vsEUdsX3VUzZV88X1ZBTKuBW+Aho4CnY=;
        b=BoQFk3ZXa0eea08hexMbc0njLl3nWCoGy4J2m435TX7dceiXHWf3Xwef0XvVN2KbEO
         S9dYF7sDKVdTtd9/PzB4U9VTx3LLzew4YJG27EI4aYomPKKh2YluUbjU5fKtF9Lg10RC
         fg2e9OPUrNtOOno02KM7xRnT19BO6LJYR5dKZg+vAlMeX4IbiicVOe75Rb169F1jeW0x
         +tx3SWLJoBX28ydlyCqL9FJayzSDY7YSV8SQbfJkrXml85xkoQ0XoJXnH4AmXJxVNpg1
         +8NWaTBy1C0XeDcXkhpgJYvx1r1/fq5KLE/vgWRQRSdT+A+tz5TYF4tvbWJl2bjfoSWP
         CdSQ==
X-Received: by 10.50.87.71 with SMTP id v7mr453451igz.29.1370646234772;
        Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vc15sm163622igb.7.2013.06.07.16.03.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3qoh006719;
        Fri, 7 Jun 2013 16:03:52 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3qCX006718;
        Fri, 7 Jun 2013 16:03:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 27/31] mips/kvm: Gate the use of kvm_local_flush_tlb_all() by KVM_MIPSTE
Date:   Fri,  7 Jun 2013 16:03:31 -0700
Message-Id: <1370646215-6543-28-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36745
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

Only the trap-and-emulate KVM code needs a Special tlb flusher.  All
other configurations should use the regular version.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 5609a32..04d0b74 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -117,7 +117,7 @@ get_new_asid(unsigned long cpu)
 	if (! ((asid += ASID_INC) & ASID_MASK) ) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
-#ifdef CONFIG_VIRTUALIZATION
+#if IS_ENABLED(CONFIG_KVM_MIPSTE)
 		kvm_local_flush_tlb_all();      /* start new asid cycle */
 #else
 		local_flush_tlb_all();	/* start new asid cycle */
-- 
1.7.11.7
