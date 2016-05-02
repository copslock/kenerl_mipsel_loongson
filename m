Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 May 2016 19:42:18 +0200 (CEST)
Received: from e06smtp06.uk.ibm.com ([195.75.94.102]:40696 "EHLO
        e06smtp06.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027835AbcEBRmQfQZwE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 May 2016 19:42:16 +0200
Received: from localhost
        by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Mon, 2 May 2016 18:42:11 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp06.uk.ibm.com (192.168.101.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 2 May 2016 18:42:09 +0100
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4583817D805A
        for <linux-mips@linux-mips.org>; Mon,  2 May 2016 18:43:02 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u42Hg8b661341716
        for <linux-mips@linux-mips.org>; Mon, 2 May 2016 17:42:08 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u42Hg8hC013466
        for <linux-mips@linux-mips.org>; Mon, 2 May 2016 11:42:08 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u42Hg8hC013457;
        Mon, 2 May 2016 11:42:08 -0600
Received: from bahia.huguette.org (sig-9-83-39-223.evts.uk.ibm.com [9.83.39.223])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 881EF220520;
        Mon,  2 May 2016 19:42:06 +0200 (CEST)
Subject: [PATCH v5 0/2] let archs decide for vCPU ids
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Date:   Mon, 02 May 2016 19:42:05 +0200
Message-ID: <146221092579.32310.10051562885606992534.stgit@bahia.huguette.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16050217-0025-0000-0000-00001A7F4D2C
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53269
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

Architectures can freely choose vCPU ids as long as they stay below
KVM_MAX_VCPUS, which is the maximum number of vCPUS. This is a problem
for PowerPC where the ids have to be multiples of the number of threads
per core in the host: when the host is POWER8 with 8 threads per core,
we can only have KVM_MAX_VCPUS / 8 in the guest.

This series decouplates the vCPU id limit from the number of vCPUs.

The first patch is a cleanup I kept from v4.

The second patch adds KVM_MAX_VCPU_ID as suggested by Radim.

---

Greg Kurz (2):
      KVM: remove NULL return path for vcpu ids >= KVM_MAX_VCPUS
      kvm: introduce KVM_MAX_VCPU_ID


 Documentation/virtual/kvm/api.txt   |   10 ++++++++--
 arch/powerpc/include/asm/kvm_host.h |    2 ++
 arch/powerpc/kvm/powerpc.c          |    3 +++
 include/linux/kvm_host.h            |   11 ++++++++---
 include/uapi/linux/kvm.h            |    1 +
 virt/kvm/kvm_main.c                 |    2 +-
 6 files changed, 23 insertions(+), 6 deletions(-)

--
Greg
