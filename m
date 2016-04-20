Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 20:29:24 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:47017 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027148AbcDTS3WyEy-Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Apr 2016 20:29:22 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88E0D7F356;
        Wed, 20 Apr 2016 18:29:14 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3KITAfj031903;
        Wed, 20 Apr 2016 14:29:10 -0400
Received: by potion (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:29:09 +0200
Date:   Wed, 20 Apr 2016 20:29:09 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160420182909.GB4044@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-04-20 17:44+0200, Greg Kurz:
> Commit 338c7dbadd26 ("KVM: Improve create VCPU parameter (CVE-2013-4587)")
> introduced a check to prevent potential kernel memory corruption in case
> the vcpu id is too great.
> 
> Unfortunately this check assumes vcpu ids grow in sequence with a common
> difference of 1, which is wrong: archs are free to use vcpu id as they fit.
> For example, QEMU originated vcpu ids for PowerPC cpus running in boot3s_hv
> mode, can grow with a common difference of 2, 4 or 8: if KVM_MAX_VCPUS is
> 1024, guests may be limited down to 128 vcpus on POWER8.
> 
> This means the check does not belong here and should be moved to some arch
> specific function: kvm_arch_vcpu_create() looks like a good candidate.
> 
> ARM and s390 already have such a check.
> 
> I could not spot any path in the PowerPC or common KVM code where a vcpu
> id is used as described in the above commit: I believe PowerPC can live
> without this check.

The only problematic path I see is kvm_get_vcpu_by_id(), which returns
NULL for any id above KVM_MAX_VCPUS.
kvm_vm_ioctl_create_vcpu() uses kvm_get_vcpu_by_id() to check for
duplicate ids, so PowerPC could end up with many VCPUs of the same id.
I'm not sure what could fail, but code doesn't expect this situation.
Patching kvm_get_vcpu_by_id() is easy, though.

Second issue is that Documentation/virtual/kvm/api.txt says
  4.7 KVM_CREATE_VCPU
  [...]
  This API adds a vcpu to a virtual machine.  The vcpu id is a small
  integer in the range [0, max_vcpus).

so we'd remove those two lines and change the API too.  The change would
be somewhat backward compatible, but doesn't PowerPC use high vcpu_id
just because KVM is lacking an API to set DT ID?
x86 (APIC ID) is affected by this and ARM (MP ID) probably too.

(Maybe it is time to decouple VCPU ID used in KVM interfaces from
 architecture dependent CPU ID that the guest uses ...
 Mostly for future architectures that won't fit into 32 bits, but
 clarity of the code could go up as well.)
