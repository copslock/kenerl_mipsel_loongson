Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 May 2013 22:22:09 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:54539 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6827470Ab3EMUWGqevH9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 May 2013 22:22:06 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Mon, 13 May 2013 13:21:57 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 39A8663004F; Mon, 13 May 2013 13:21:57 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, gleb@redhat.com, mtosatti@redhat.com,
        ralf@linux-mips.org, Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 0/2] KVM/MIPS32: Fixes for Linux 3.10
Date:   Mon, 13 May 2013 13:21:38 -0700
Message-Id: <1368476500-20031-1-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <n>
References: <n>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36393
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

The following patch set fixes a couple of issues with KVM/MIPS32 in Linux 3.10.

- As suggested by Gleb, wrap calls to gfn_to_pfn() with srcu_read_lock/unlock().
- kvm_mips_map_page() now returns an error code to it's callers, instead of calling panic()
  if it cannot find a mapping for a particular gfn.
- Follow the latest convention and move the kvm.h API file under uapi/...

--
Sanjay Lal (2):
  KVM/MIPS32: Move include/asm/kvm.h => include/uapi/asm/kvm.h since it
    is a user visible API.
  KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()

 arch/mips/include/asm/kvm.h      | 55 ----------------------------------------
 arch/mips/include/uapi/asm/kvm.h | 55 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_tlb.c          | 38 ++++++++++++++++++++-------
 3 files changed, 84 insertions(+), 64 deletions(-)
 delete mode 100644 arch/mips/include/asm/kvm.h
 create mode 100644 arch/mips/include/uapi/asm/kvm.h

-- 
1.7.11.3
