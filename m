Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 18:49:56 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37632 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835061Ab3EWQtYyEss7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 18:49:24 +0200
Received: by mail-pa0-f53.google.com with SMTP id kq12so3185994pab.26
        for <multiple recipients>; Thu, 23 May 2013 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=NEr7ZixmRAAyQviwuTjhfz51CxLFDLZdNLIOTUIYSg4=;
        b=sYBH3du30jH2zK79EtmZYvwf/vEllbQnsTsiW2oK5LHzY+kmCRkjPlBilIPEa0Ebt3
         LjS4BNC832MCumhXQpG6oIxLLYqJBMFId0ckQfbvAfKPMVC4vcpiyp/yd4XRN3iqevUy
         tNV4ovDeOQaSHcoEXgKS8pGs8heGedxlGi6jVry2TtnfxYHcws0VBBdBx/6NbhRqxbfY
         5oG7CtqBV46EkQ1B6UoizuHdPwfhY/2sdPWyvnf38JzZVccB36UL0NAC1kxVLoPrB5rh
         7NMsiYzTsohRU3agaHwnNNHWQ0DRFRfaoBfxtLj4rqADNwBUKrY59jxwDtxxsmwb/fcQ
         49XA==
X-Received: by 10.68.171.196 with SMTP id aw4mr13659116pbc.78.1369327756723;
        Thu, 23 May 2013 09:49:16 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qb1sm12360507pbb.33.2013.05.23.09.49.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 May 2013 09:49:15 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4NGnD8g028619;
        Thu, 23 May 2013 09:49:13 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4NGnCdT028618;
        Thu, 23 May 2013 09:49:12 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v6 0/6] mips/kvm: Fix ABI for compatibility with 64-bit guests.
Date:   Thu, 23 May 2013 09:49:04 -0700
Message-Id: <1369327750-28580-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36557
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

Changes from v5: Adjust for kvm.h moving to uapi/asm.  Code formatting
                 to achieve line lengths <= 80.

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

 arch/mips/include/asm/kvm_host.h |   4 -
 arch/mips/include/uapi/asm/kvm.h | 137 +++++++++++++++----
 arch/mips/kvm/kvm_mips.c         | 280 ++++++++++++++++++++++++++++++++++++---
 arch/mips/kvm/kvm_trap_emul.c    |  50 -------
 4 files changed, 369 insertions(+), 102 deletions(-)

-- 
1.7.11.7
