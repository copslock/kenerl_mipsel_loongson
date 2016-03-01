Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 00:51:09 +0100 (CET)
Received: from mail333.us4.mandrillapp.com ([205.201.137.77]:37203 "EHLO
        mail333.us4.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007431AbcCAXvG5es6J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 00:51:06 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=mandrill; d=linuxfoundation.org;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=gregkh@linuxfoundation.org;
 bh=aatfENpt3LEZ42bCX4fGinkz2LA=;
 b=Czp9YZcKw89lPVDYZQnC73WPY8yse65x6DHc+kOYsJazqJK+HU4E5pWitVwZEngCbrKNq92/qZ4u
   3cOEyiLVGdC1d+Q3IK0I+PhXAl5hV4lxQHcvfRe/Z2K+VKiQ7dP6gaiH/1HuLoMuLr9Q9n0crXYh
   xGnx9lv+4Lm6273SZNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=mandrill; d=linuxfoundation.org;
 b=h4xTf98E+/c8KJFblEI4iRAbvwMHCf4C9wG38BLwx9EWeVVPMNLOQLygXcGYcpWdymqQhPaD5L6G
   I3TcdKJ7veWVh9I0VD4qmEpiI9lOLyGcBpAMM4azE6fVx1Y99bqxxfhs3vQuPwxa7WHJv7NFxNo9
   Kg5tlewso0DD9mXji2k=;
Received: from pmta03.dal05.mailchimp.com (127.0.0.1) by mail333.us4.mandrillapp.com id hqolek174noh for <linux-mips@linux-mips.org>; Tue, 1 Mar 2016 23:51:00 +0000 (envelope-from <bounce-md_30481620.56d62ae4.v1-9edb38bdf75e4a0ab6cdb726df4e7730@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1456876260; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=C7aNXXca7cJ/+XkXAMIBkLA2jQfzOkg3Jmo16TY+tak=; 
 b=if2uo8bB7KBmHvkpoxOHcFh8t3HTJ5h2Jo4fPzNnZMpb3FMj+Foh+DBgwjhUcLVl0BThsQ
 35/9dAJucIKxRNVfIjwoLLGsR18nvp2Q94kCZoE5VmsDp3b/0arVvmsRdQbTmBlxy+hJ4Hjs
 0+23G/sh/7s97HKCyEaCYXMph5JNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.14 033/130] MIPS: KVM: Fix ASID restoration logic
Received: from [50.170.35.168] by mandrillapp.com id 9edb38bdf75e4a0ab6cdb726df4e7730; Tue, 01 Mar 2016 23:51:00 +0000
X-Mailer: git-send-email 2.7.2
To:     <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Message-Id: <20160301234500.926247873@linuxfoundation.org>
In-Reply-To: <20160301234459.768886030@linuxfoundation.org>
References: <20160301234459.768886030@linuxfoundation.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=30481620.9edb38bdf75e4a0ab6cdb726df4e7730
X-Mandrill-User: md_30481620
Date:   Tue, 01 Mar 2016 23:51:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bounce-md_30481620.56d62ae4.v1-9edb38bdf75e4a0ab6cdb726df4e7730@mandrillapp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52398
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

commit 002374f371bd02df864cce1fe85d90dc5b292837 upstream.

ASID restoration on guest resume should determine the guest execution
mode based on the guest Status register rather than bit 30 of the guest
PC.

Fix the two places in locore.S that do this, loading the guest status
from the cop0 area. Note, this assembly is specific to the trap &
emulate implementation of KVM, so it doesn't need to check the
supervisor bit as that mode is not implemented in the guest.

Fixes: b680f70fc111 ("KVM/MIPS32: Entry point for trampolining to...")
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
 arch/mips/kvm/kvm_locore.S |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/mips/kvm/kvm_locore.S
+++ b/arch/mips/kvm/kvm_locore.S
@@ -159,9 +159,11 @@ FEXPORT(__kvm_mips_vcpu_run)
 
 FEXPORT(__kvm_mips_load_asid)
 	/* Set the ASID for the Guest Kernel */
-	INT_SLL	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
-			        /* addresses shift to 0x80000000 */
-	bltz	t0, 1f		/* If kernel */
+	PTR_L	t0, VCPU_COP0(k1)
+	LONG_L	t0, COP0_STATUS(t0)
+	andi	t0, KSU_USER | ST0_ERL | ST0_EXL
+	xori	t0, KSU_USER
+	bnez	t0, 1f		/* If kernel */
 	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
 	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
@@ -438,9 +440,11 @@ __kvm_mips_return_to_guest:
 	mtc0	t0, CP0_EPC
 
 	/* Set the ASID for the Guest Kernel */
-	INT_SLL	t0, t0, 1	/* with kseg0 @ 0x40000000, kernel */
-				/* addresses shift to 0x80000000 */
-	bltz	t0, 1f		/* If kernel */
+	PTR_L	t0, VCPU_COP0(k1)
+	LONG_L	t0, COP0_STATUS(t0)
+	andi	t0, KSU_USER | ST0_ERL | ST0_EXL
+	xori	t0, KSU_USER
+	bnez	t0, 1f		/* If kernel */
 	 INT_ADDIU t1, k1, VCPU_GUEST_KERNEL_ASID  /* (BD)  */
 	INT_ADDIU t1, k1, VCPU_GUEST_USER_ASID    /* else user */
 1:
