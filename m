Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 12:32:58 +0200 (CEST)
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:38758 "EHLO
        e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011931AbbD1Kc4oNhRL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 12:32:56 +0200
Received: from /spool/local
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 28 Apr 2015 11:32:52 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 28 Apr 2015 11:32:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id A259317D8042
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 11:33:31 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3SAWoCW9961860
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 10:32:50 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3S5R3QS017651
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 01:27:03 -0400
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3S5R3QZ017645;
        Tue, 28 Apr 2015 01:27:03 -0400
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 9A5571224399; Tue, 28 Apr 2015 12:32:49 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 0/2] KVM: micro-optimization and interrupt disabling
Date:   Tue, 28 Apr 2015 12:32:46 +0200
Message-Id: <1430217168-25504-1-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.3.0
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15042810-0021-0000-0000-000003BAD5D4
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

I was able to get rid of some nanoseconds for a guest exit loop
on s390. I did my best to not break other architectures but
review and comments on the general approach is welcome.
Downside is that the existing irq_save things will just work
no matter what the callers have done, the new code must do
the right thing in the callers.

Is that approach acceptible? Does anybody else see some measurable
difference for guest exits?


Christian Borntraeger (2):
  KVM: Push down irq_save to architectures before kvm_guest_enter
  KVM: push down irq_save from kvm_guest_exit

 arch/powerpc/kvm/book3s_hv.c |  4 ++++
 arch/powerpc/kvm/book3s_pr.c |  2 ++
 arch/powerpc/kvm/booke.c     |  4 ++--
 arch/s390/kvm/kvm-s390.c     |  6 ++++--
 arch/x86/kvm/x86.c           |  2 ++
 include/linux/kvm_host.h     | 18 ++++++++----------
 6 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.3.0
