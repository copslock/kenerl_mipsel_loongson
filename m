Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 16:15:46 +0200 (CEST)
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:55643 "EHLO
        e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027240AbcDUOP2V8O9a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 16:15:28 +0200
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Thu, 21 Apr 2016 15:15:22 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp15.uk.ibm.com (192.168.101.145) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 21 Apr 2016 15:14:59 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B83B1B08072
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 15:15:43 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3LEEw0P64815158
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 14:14:58 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3LEEv5N009612
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 08:14:58 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3LEEukF009585;
        Thu, 21 Apr 2016 08:14:56 -0600
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 5D2E722046A;
        Thu, 21 Apr 2016 16:14:55 +0200 (CEST)
Subject: [PATCH v4 0/2] let archs decide for vcpu ids
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Date:   Thu, 21 Apr 2016 16:14:54 +0200
Message-ID: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042114-0021-0000-0000-0000339D1B06
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkurz@linux.vnet.ibm.com
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

This series mostly addresses Radim's comments on my previous patch
"KVM: remove buggy vcpu id check on vcpu creation":
- prepended a patch to fix kvm_get_vcpu_by_id()
- updated the KVM API documentation

---

Greg Kurz (2):
      KVM: remove NULL return path for vcpu ids >= KVM_MAX_VCPUS
      KVM: move vcpu id checking to archs


 Documentation/virtual/kvm/api.txt |    7 +++----
 arch/mips/kvm/mips.c              |    7 ++++++-
 arch/x86/kvm/x86.c                |    3 +++
 include/linux/kvm_host.h          |    7 ++++---
 virt/kvm/kvm_main.c               |    3 ---
 5 files changed, 16 insertions(+), 11 deletions(-)

--
Greg
