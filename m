Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 00:51:48 +0100 (CET)
Received: from mail177-1.suw61.mandrillapp.com ([198.2.177.1]:18396 "EHLO
        mail177-1.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27015057AbcCAXvHq7r4J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 00:51:07 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=mandrill; d=linuxfoundation.org;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=gregkh@linuxfoundation.org;
 bh=a6JOuHTAvqeZSDnVoMOhvNDrs/Q=;
 b=kkSrXtgdeCPrxoLpeK/imDguM4PLyzsnZIZ00wpKLLUVd5rEFeQeu9RobjSxJBneFWwQHF0IdJMv
   eAbokZrpqvmy4EdQlsyi37Nm6x4HpyCiWh0nAmsFMgeXIpDY3HugoivdukvKLc7aAvA51RIkLm4T
   ONB+fNj0/1K8CaG/OuI=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-1.suw61.mandrillapp.com id hqolem22rtkc for <linux-mips@linux-mips.org>; Tue, 1 Mar 2016 23:51:01 +0000 (envelope-from <bounce-md_30481620.56d62ae5.v1-24397eb2e783475fb55bf1a144af440b@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1456876261; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=XY0EhdYGs8GP7Um/K6KgP4RY/1mmfuN/o33bPgYN+pc=; 
 b=RVU33ILv2cQSvPs+bizE306ZEo7NdNArkbiM8FbVXMbYYkCO87qEDQYN3dmrKYcVmg7AU5
 SNx456J3RRAdMn2gGBMxRoFzU8tP8uhW7yxgOqYnANMSOUBamZPaLj2cUdQcUF+2UCi5Dv2j
 bVpsHMlXFBOkt5fkgru/3KwuvTCf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.14 035/130] MIPS: KVM: Uninit VCPU in vcpu_create error path
Received: from [50.170.35.168] by mandrillapp.com id 24397eb2e783475fb55bf1a144af440b; Tue, 01 Mar 2016 23:51:01 +0000
X-Mailer: git-send-email 2.7.2
To:     <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Message-Id: <20160301234500.991724417@linuxfoundation.org>
In-Reply-To: <20160301234459.768886030@linuxfoundation.org>
References: <20160301234459.768886030@linuxfoundation.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=30481620.24397eb2e783475fb55bf1a144af440b
X-Mandrill-User: md_30481620
Date:   Tue, 01 Mar 2016 23:51:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bounce-md_30481620.56d62ae5.v1-24397eb2e783475fb55bf1a144af440b@mandrillapp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 585bb8f9a5e592f2ce7abbe5ed3112d5438d2754 upstream.

If either of the memory allocations in kvm_arch_vcpu_create() fail, the
vcpu which has been allocated and kvm_vcpu_init'd doesn't get uninit'd
in the error handling path. Add a call to kvm_vcpu_uninit() to fix this.

Fixes: 669e846e6c4e ("KVM/MIPS32: MIPS arch specific APIs for KVM")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kvm/kvm_mips.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -313,7 +313,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
 
 	if (!gebase) {
 		err = -ENOMEM;
-		goto out_free_cpu;
+		goto out_uninit_cpu;
 	}
 	kvm_info("Allocated %d bytes for KVM Exception Handlers @ %p\n",
 		 ALIGN(size, PAGE_SIZE), gebase);
@@ -373,6 +373,9 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
 out_free_gebase:
 	kfree(gebase);
 
+out_uninit_cpu:
+	kvm_vcpu_uninit(vcpu);
+
 out_free_cpu:
 	kfree(vcpu);
