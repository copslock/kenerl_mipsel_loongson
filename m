Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 13:43:58 +0200 (CEST)
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:38960 "EHLO
        e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012295AbbD3LnklOUDi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 13:43:40 +0200
Received: from /spool/local
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Apr 2015 12:43:36 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 30 Apr 2015 12:43:34 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6DDCE17D805A
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 12:44:16 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3UBhYXV9961808
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 11:43:34 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3UBhXKT004554
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2015 05:43:34 -0600
Received: from tuxmaker.boeblingen.de.ibm.com (tuxmaker.boeblingen.de.ibm.com [9.152.85.9])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t3UBhXa1004538;
        Thu, 30 Apr 2015 05:43:33 -0600
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 4B2F91224399; Thu, 30 Apr 2015 13:43:33 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@linux-mips.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Alexander Graf <agraf@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv2 0/2] KVM: micro-optimization and interrupt disabling
Date:   Thu, 30 Apr 2015 13:43:29 +0200
Message-Id: <1430394211-25209-1-git-send-email-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.3.0
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15043011-0021-0000-0000-000003C1AA8A
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47169
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

This rework allows to avoid some cycles by not disabling interrupts
twice.

Christian Borntraeger (2):
  KVM: provide irq_unsafe kvm_guest_{enter|exit}
  KVM: arm/mips/x86/power use __kvm_guest_{enter|exit}

 arch/arm/kvm/arm.c         |  4 ++--
 arch/mips/kvm/mips.c       |  4 ++--
 arch/powerpc/kvm/powerpc.c |  2 +-
 arch/s390/kvm/kvm-s390.c   | 10 ++++++----
 arch/x86/kvm/x86.c         |  2 +-
 include/linux/kvm_host.h   | 27 ++++++++++++++++++---------
 6 files changed, 30 insertions(+), 19 deletions(-)

-- 
2.3.0
