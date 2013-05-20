Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 23:12:25 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:61370 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824787Ab3ETVMHPwYBS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 23:12:07 +0200
Received: by mail-pd0-f174.google.com with SMTP id 14so1386884pdj.33
        for <multiple recipients>; Mon, 20 May 2013 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=RXGefvT2OfAtygtTZtkJ/7bVIHIChZtM41kPWlYWiKc=;
        b=XZaxeUfNAKVi5SiRECKZuMNEq5EnwOzkdYSPXYoSQRPYAPb/DJqEkmb4CbrmcclBYh
         c6NbCSxkQC3eFsZeIaxhmUTT8pnPWef+06eua/pXDmi8M/4d4blMzbbp1JOuByNspK5G
         ixbkKrNiuUqe9admgSwMgff43HMO8AkJ2/Vtv20d1Lkt3njc1cfqEfPcwQxDal2I82gu
         3nqfBedHmH5agVZG5oVoumyHcJIu9uBDS0O5MKWM/RHQwZio/QoSnmqiMkI+M0rTu942
         chRFVq7PXXvPerzzCavZYpFu5cQjtpOe7f62/I8gmQofQ8/Yg1PuQZPtq4qtjpLsOsJi
         XAMA==
X-Received: by 10.68.36.197 with SMTP id s5mr62725802pbj.23.1369084320336;
        Mon, 20 May 2013 14:12:00 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id cc15sm83941pac.1.2013.05.20.14.11.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 14:11:59 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4KLBvgQ027919;
        Mon, 20 May 2013 14:11:57 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4KL1SXS027561;
        Mon, 20 May 2013 14:01:28 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 0/5] mips/kvm: Fix ABI for compatibility with 64-bit guests.
Date:   Mon, 20 May 2013 14:01:21 -0700
Message-Id: <1369083686-27524-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36490
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

The initial patch set implementing MIPS KVM does not handle 64-bit
guests or use of the FPU.  This patch set corrects these ABI issues,
and does some very minor clean up.

Changes from v2:  Split into five parts, no code change.

David Daney (5):
  mips/kvm: Fix ABI for use of FPU.
  mips/kvm: Fix ABI for use of 64-bit registers.
  mips/kvm: Fix name of gpr field in struct kvm_regs.
  mips/kvm: Use ARRAY_SIZE() instead of hardcoded constants in
    kvm_arch_vcpu_ioctl_{s,g}et_regs
  mips/kvm: Fix ABI by moving manipulation of CP0 registers to
    KVM_{G,S}ET_MSRS

 arch/mips/include/asm/kvm.h      | 111 ++++++++++---
 arch/mips/include/asm/kvm_host.h |   4 -
 arch/mips/kvm/kvm_mips.c         | 102 +-----------
 arch/mips/kvm/kvm_trap_emul.c    | 330 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 386 insertions(+), 161 deletions(-)

-- 
1.7.11.7
