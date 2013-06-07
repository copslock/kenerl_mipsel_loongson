Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:15:09 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:48500 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835250Ab3FGXEB7Ci2i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:04:01 +0200
Received: by mail-ie0-f177.google.com with SMTP id u16so11429912iet.8
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1tpdypQdBsOOxSUEJbpytd1J3vyFnBk8p7KjDIlI8hI=;
        b=H8NPEWGjumk9Te3ljmYdTYqmMGiHlHCkSXV7n43CbqqOfx4TDET7WKWwOdt2kojbBQ
         YcnBQT5xqyNoQSwJthWAwghf3ciPMiJMepIv+fvxp+bIXtVvofeINXe2iBMT+ZyYOkKM
         Pbr6B96L0E9XB3e3IflarOdkBUsCq/WY1B8SG9/OWzS36FrZOiFYxgA1/NYCgh4/oHFU
         gVOQW+o3dZI5dUZ3QH5hl3Gt0nTo4+jhKSFTcYkcC5MlyqRDh3kGdTbptHIKlTfp1Dwz
         HUn7/NEhopCOL0XIoV5faUkHtVTx3EC3VXIY/CpkBgSxF3vaO0cwChOrmbUT9tK/cDF5
         6Vtg==
X-Received: by 10.50.29.73 with SMTP id i9mr362196igh.105.1370646235908;
        Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id j3sm1193754igv.4.2013.06.07.16.03.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3rxN006735;
        Fri, 7 Jun 2013 16:03:53 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3rl1006734;
        Fri, 7 Jun 2013 16:03:53 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 31/31] mips/kvm: Allow for upto 8 KVM vcpus per vm.
Date:   Fri,  7 Jun 2013 16:03:35 -0700
Message-Id: <1370646215-6543-32-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36748
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

The mipsvz implementation allows for SMP, so let's be able to create
all those vcpus.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 9f209e1..0a5e218 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -20,7 +20,7 @@
 #include <linux/spinlock.h>
 
 
-#define KVM_MAX_VCPUS		1
+#define KVM_MAX_VCPUS		8
 #define KVM_USER_MEM_SLOTS	8
 /* memory slots that does not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS 	0
-- 
1.7.11.7
