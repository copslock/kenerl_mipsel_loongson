Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 22:55:14 +0200 (CEST)
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41215 "EHLO
        mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824786Ab3EUUzJLkxGU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 May 2013 22:55:09 +0200
Received: by mail-pb0-f46.google.com with SMTP id rq2so1000087pbb.5
        for <multiple recipients>; Tue, 21 May 2013 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fPm3TdZ2ywyqi/Suklkfsb2FTqNSGDkrf5FkTUcdxsc=;
        b=A7j7ggNEq0Chqky99NOOvAW+6wsRTHviWE66y87H3Ti8H54fjHPj/V80l35TByQi03
         q6TCUOhEJWBCeCl+K3UXMpKC+B63NDfSE2VuzZO8Ga4sep/LS2nUo8B8CmNKZR/wejCj
         q7FP1kOjsjcQ0KyYufYRrsJc6bBSgjbwwb8HEqIImDw3QjPBag/lmiESILKKPihyV9zO
         16iMi4t6uFHnOVVnh2dazJCDGJSelr9hM41dDMRDia/+PYA+H6YYvoKgOiNktIM403Js
         cUYn0Pq7fkOGC7ijQ8DAFnPiwyvVHfXDkQn/+gt7rafAqG7JbUzyYVSwY25/Up/2Mweh
         qgJw==
X-Received: by 10.66.4.106 with SMTP id j10mr5019933paj.218.1369169701635;
        Tue, 21 May 2013 13:55:01 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ra4sm4752847pab.9.2013.05.21.13.54.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 13:55:00 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4LKswZO010483;
        Tue, 21 May 2013 13:54:58 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4LKsu43010482;
        Tue, 21 May 2013 13:54:56 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v4 0/6] mips/kvm: Fix ABI for compatibility with 64-bit guests.
Date:   Tue, 21 May 2013 13:54:49 -0700
Message-Id: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36507
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

Chandes from v3: Use KVM_SET_ONE_REG instead of KVM_SET_MSRS.  Added
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

 arch/mips/include/asm/kvm.h      | 137 ++++++++++++----
 arch/mips/include/asm/kvm_host.h |   4 -
 arch/mips/kvm/kvm_mips.c         | 118 +++-----------
 arch/mips/kvm/kvm_trap_emul.c    | 338 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 430 insertions(+), 167 deletions(-)

-- 
1.7.11.7
