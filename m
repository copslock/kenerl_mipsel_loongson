Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 May 2013 15:54:42 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:36861 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822997Ab3ERNyiH0joy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 May 2013 15:54:38 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 06:54:28 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 443BF63004F; Sat, 18 May 2013 06:54:28 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     linux-mips@linux-mips.org
Cc:     kvm@vger.kernel.org, ralf@linux-mips.org, gleb@redhat.com,
        mtosatti@redhat.com, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v3 0/4] KVM/MIPS32: Fixes for Linux 3.10
Date:   Sat, 18 May 2013 06:54:22 -0700
Message-Id: <1368885266-8619-1-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <n>
References: <n>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36448
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

The following patch set fixes a few issues with KVM/MIPS32 in Linux 3.10.

Changes from v2:
- Drop KVM-MIPS32-Fix-up-KVM-breakage-caused-by-d532f3d2671 as the offending
  commit has been reverted and will be submitted upstream via the linux-mips
  tree.
- Integrate with the new 64 bit compatible KVM/MIPS ABI 
  defined by David Daney @ Cavium.

--

Sanjay Lal (4):
  KVM/MIPS32: Move include/asm/kvm.h => include/uapi/asm/kvm.h since it
    is a user visible API.
  KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()
  KVM/MIPS32: Export min_low_pfn.
  KVM/MIPS32: Bring in patch from David Daney with new 64 bit
    compatible ABI.

 arch/mips/include/asm/kvm.h      |  55 -------
 arch/mips/include/asm/kvm_host.h |   9 +-
 arch/mips/include/uapi/asm/kvm.h | 113 ++++++++++++++
 arch/mips/kernel/mips_ksyms.c    |   6 +
 arch/mips/kvm/kvm_mips.c         | 102 +-----------
 arch/mips/kvm/kvm_mips_emul.c    |  22 +--
 arch/mips/kvm/kvm_tlb.c          |  55 ++++---
 arch/mips/kvm/kvm_trap_emul.c    | 330 ++++++++++++++++++++++++++++++++++-----
 8 files changed, 471 insertions(+), 221 deletions(-)
 delete mode 100644 arch/mips/include/asm/kvm.h
 create mode 100644 arch/mips/include/uapi/asm/kvm.h

-- 
1.7.11.3
