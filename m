Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 21:34:42 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:55902 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835133Ab3FJTeEWSAW4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 21:34:04 +0200
Received: by mail-ie0-f170.google.com with SMTP id e11so1665431iej.1
        for <multiple recipients>; Mon, 10 Jun 2013 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lX5DAPcJxrGdQ+4RI6QQg0K62Vmbrpy8Bn1RoJI9a8w=;
        b=tdOVkpAZWYhIdd6Ja+zopz4uVjlv+Cc1TVynN7D+xP2jl8XB7tei6iMCTfTVRLvcQ/
         XCVcT6VhD3rMXoTwP2SSoQ3m6tni2SVNZOYvacXUxp7JDurn5aaOyU9WnBCEouXspbsz
         5FcXLErEAldFLW3ZaP32bEarffa67nm4PDasMZCtGtJynWKoA6KNyJLWo0uyRkt2JyBr
         /jTp4nwfbLZcsmiEBB5rIr5VH8Rj4zgxF16xq72qKWoXgZsx2X/oQasWAzA3fcSadZun
         OkJJZZ4K7peuArjCyRpNiSzexTYwIQazNmU59ZypiRcEy6mn0KiXrh6JA0zs2hO1GN+N
         IojQ==
X-Received: by 10.50.102.41 with SMTP id fl9mr4637023igb.18.1370892837995;
        Mon, 10 Jun 2013 12:33:57 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ir8sm9485509igb.6.2013.06.10.12.33.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 12:33:57 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5AJXsau021715;
        Mon, 10 Jun 2013 12:33:54 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5AJXsZX021714;
        Mon, 10 Jun 2013 12:33:54 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] kvm: Add definition of KVM_REG_MIPS
Date:   Mon, 10 Jun 2013 12:33:47 -0700
Message-Id: <1370892828-21676-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370892828-21676-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370892828-21676-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36818
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

We use 0x7000000000000000ULL as 0x6000000000000000ULL is reserved for
ARM64.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a5c86fc..d88c8ee 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -783,6 +783,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_IA64		0x3000000000000000ULL
 #define KVM_REG_ARM		0x4000000000000000ULL
 #define KVM_REG_S390		0x5000000000000000ULL
+#define KVM_REG_MIPS		0x7000000000000000ULL
 
 #define KVM_REG_SIZE_SHIFT	52
 #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL
-- 
1.7.11.7
