Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 23:25:33 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:57801 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835012Ab3EQVZ3NWGzw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 May 2013 23:25:29 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 17 May 2013 14:25:20 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 27DD163004F; Fri, 17 May 2013 14:25:20 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, gleb@redhat.com,
        mtosatti@redhat.com, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 0/3] KVM/MIPS32: Fixes for Linux 3.10
Date:   Fri, 17 May 2013 14:25:09 -0700
Message-Id: <1368825912-23562-1-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <n>
References: <n>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36438
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

--

Sanjay Lal (3):
  KVM/MIPS32: Move include/asm/kvm.h => include/uapi/asm/kvm.h since it
    is a user visible API.
  KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()
  KVM/MIPS32: Fix up KVM breakage caused by
    d532f3d26716a39dfd4b88d687bd344fbe77e390 which allows     ASID mask
    and increment to be determined @ runtime.

 arch/mips/include/asm/kvm.h      | 55 ---------------------------------------
 arch/mips/include/asm/kvm_host.h |  5 ++++
 arch/mips/include/uapi/asm/kvm.h | 55 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_mips_emul.c    | 22 ++++++++--------
 arch/mips/kvm/kvm_tlb.c          | 56 ++++++++++++++++++++++++++--------------
 5 files changed, 108 insertions(+), 85 deletions(-)
 delete mode 100644 arch/mips/include/asm/kvm.h
 create mode 100644 arch/mips/include/uapi/asm/kvm.h

-- 
1.7.11.3
