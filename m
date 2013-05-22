Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 20:44:14 +0200 (CEST)
Received: from mail-da0-f52.google.com ([209.85.210.52]:41891 "EHLO
        mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835053Ab3EVSoNWtYyR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 20:44:13 +0200
Received: by mail-da0-f52.google.com with SMTP id o9so1273401dan.11
        for <multiple recipients>; Wed, 22 May 2013 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7P4QoF2S7bGEbt799dKDdSOybCXtnN2RchJFHKFMqSw=;
        b=eY1KzoEGyvqypCCaTZohM4sRmIycpNGAmfSkacQT5oabNpoBRUhyMrusPxtf8u213G
         wpNyZC/qTb5VSpQlBrf9vdtVZrX/zVJ6F+GZEIm+YCOW14ukV52EsbdeOIPI5MAiqu5B
         u0m3pJbAUhrlLwWl2flrcqxLs6QZDK2ByHokPelv1uqTXUxeVIPKii2LBfseS64vG7g9
         LLPt97HuuyzHl0x4iG3zuCIBzdIQ6ouVopLHA3p4HIQnDmjM89nuaoSeL/ItXJ8FbdJI
         m649vtC6vK3fDnsza89s+7TnecK/oxdV+5NK5+uyjkpP2A10LnQOvciSgyUpgDg5cb97
         6zOQ==
X-Received: by 10.66.14.1 with SMTP id l1mr9804946pac.150.1369248246354;
        Wed, 22 May 2013 11:44:06 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nt2sm8240456pbc.17.2013.05.22.11.44.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 11:44:05 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4MIi3fn027277;
        Wed, 22 May 2013 11:44:03 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4MIhvTI027275;
        Wed, 22 May 2013 11:43:57 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v5 0/6] mips/kvm: Fix ABI for compatibility with 64-bit guests.
Date:   Wed, 22 May 2013 11:43:50 -0700
Message-Id: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36531
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

Changes from v4: No code change, just keep more of the code in
                 kvm_mips.c rather than kvm_trap_emul.c

Changes from v3: Use KVM_SET_ONE_REG instead of KVM_SET_MSRS.  Added
                 ENOIOCTLCMD patch.

Changes from v2: Split into five parts, no code change.

David Daney (6):
  mips/kvm: Fix ABI for use of FPU.
  mips/kvm: Fix ABI for use of 64-bit registers.
  mips/kvm: Fix name of gpr field in struct kvm_regs.
  mips/kvm: Use ARRAY_SIZE() instead of hardcoded constants in
    kvm_arch_vcpu_ioctl_{s,g}et_regs
  mips/kvm: Fix ABI by moving manipulation of CP0 registers to
    KVM_{G,S}ET_ONE_REG
  mips/kvm: Use ENOIOCTLCMD to indicate unimplemented ioctls.

 arch/mips/include/asm/kvm.h      | 137 +++++++++++++++----
 arch/mips/include/asm/kvm_host.h |   4 -
 arch/mips/kvm/kvm_mips.c         | 278 ++++++++++++++++++++++++++++++++++++---
 arch/mips/kvm/kvm_trap_emul.c    |  50 -------
 4 files changed, 367 insertions(+), 102 deletions(-)

-- 
1.7.11.7
