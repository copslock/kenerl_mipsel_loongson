Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:26:27 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:49880 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825756Ab2JaPVTFN3SL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 16:21:19 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:21:11 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [PATCH 19/20] KVM/MIPS32: Do not call vcpu_load when injecting  interrupts. 
Date:   Wed, 31 Oct 2012 11:21:07 -0400
Message-Id: <1C1ED963-A2A8-4552-AC1D-1F3124A4E61B@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34831
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e59bb63..1cc985a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1882,7 +1882,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 	if (vcpu->kvm->mm != current->mm)
 		return -EIO;
 
-#if defined(CONFIG_S390) || defined(CONFIG_PPC)
+#if defined(CONFIG_S390) || defined(CONFIG_PPC) || defined(CONFIG_MIPS)
 	/*
 	 * Special cases: vcpu ioctls that are asynchronous to vcpu execution,
 	 * so vcpu_load() would break it.
-- 
1.7.11.3
