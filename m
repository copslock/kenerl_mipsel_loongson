Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:14:26 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:59915 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835246Ab3FGXEBK8Hj5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:04:01 +0200
Received: by mail-ie0-f171.google.com with SMTP id s9so12126750iec.2
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LMUysl035EmwVoBnbrs9qA7LJH3x0Z7Tdg1FuAhJ+Ao=;
        b=c7tKiUdezX6pWp/taLGAZ7jevB06/u/ud5C6OV6MQwy5JyNQ/WLne9lEcaP8urkX7E
         kvmZ3FzCrsPs53zlX477l4dlTj3RAKCx0MnKnjnfXRyqA1rZzrDCwLJn7qWlcXXVR5A7
         EFdAkTUxSRO+PXcwyDN7yelEk32jnXH8knxUXAkDj1gQBFJnyBJNEprtewJsynCrqmMw
         /8Lw5TqR4G1ICZNgdUzhjBBuX6h82uQizj7VyZvIuRaQYQVYtquhcabOp13+3zEleTdq
         vVgjhxaDIL+LMjR5nTTYO+fOYmnrV7ML6Q9/8Iv2pUgQHBlLez0lKdXk1q9H5bKJpfz9
         aR/A==
X-Received: by 10.50.136.226 with SMTP id qd2mr2298681igb.20.1370646235072;
        Fri, 07 Jun 2013 16:03:55 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id h3sm1222029igv.1.2013.06.07.16.03.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:54 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3qmO006723;
        Fri, 7 Jun 2013 16:03:52 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3qBV006722;
        Fri, 7 Jun 2013 16:03:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 28/31] mips/kvm: Only use KVM_COALESCED_MMIO_PAGE_OFFSET with KVM_MIPSTE
Date:   Fri,  7 Jun 2013 16:03:32 -0700
Message-Id: <1370646215-6543-29-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36746
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

The forthcoming MIPSVZ code doesn't currently use this, so it must
only be enabled for KVM_MIPSTE.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/kvm_host.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 505b804..9f209e1 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -25,7 +25,9 @@
 /* memory slots that does not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS 	0
 
+#ifdef CONFIG_KVM_MIPSTE
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+#endif
 
 /* Don't support huge pages */
 #define KVM_HPAGE_GFN_SHIFT(x)	0
-- 
1.7.11.7
