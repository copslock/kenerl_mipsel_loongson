Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 20:53:50 +0100 (CET)
Received: from mout.web.de ([212.227.15.3]:52633 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992267AbdARTxn2tKvv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jan 2017 20:53:43 +0100
Received: from [192.168.1.2] ([78.48.198.118]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6bn-1cnv4s3Z15-00oZP9; Wed, 18
 Jan 2017 20:52:30 +0100
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] MIPS: KVM: Return directly after a failed copy_from_user() in
 kvm_arch_vcpu_ioctl()
Message-ID: <87aac8b8-4f30-2edd-4688-42d32d815cd1@users.sourceforge.net>
Date:   Wed, 18 Jan 2017 20:52:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9qG4qTFLgp7g6dnKdZK6Nq1f7X/Ov5lZXO5uYEn/uZnZxuIKSxt
 NOHcbwH6Gwnnh0VCGwiYktgVbU2RlrXNUfFoM5AiKhl14iHE7SEvJNGVLlK9KAxBb4eGoKw
 4kwuLJj7O/OSClS1c58ykgp/Wt0vvzd82QsYlMvornWaZOZM51NT8/aPgK6vm9Me5zLU9t2
 BdEQi65ARhoT7t6x75Qhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IbuY9W70Pl0=:YZv+yn/BOLK04deS1N558q
 h/bwDaSGO7PxRKJDlx+m1mjUX+XJz6cR65lhV/70W34sDpwULw7OQ5HOowJyv9WAtVeuO3OXI
 m4cZtLIkk37wtkAFQ8kxwKJRaIF41mKDjoiwvImnChF9lF/PEXUSCZYkLn8Q4LASdeDALtLA0
 1RGHqfbKw8omrotIiWYT5mEq9CmUU+j0fOvIGMJc99C0Bdyy2MfCVVHIfGLfkJrLwc1Mv+BfB
 d2i+0dbkpQGKWmnac21woZ72m87NjgCd8fN1omq+oSjXkrbjRD6+aZPICBRXhaoRW87rkMr06
 DL3NcXubGaNj6AGlSa12s6Sa0QpAArQJ6ufQtTQEZwo1mRUCZi+VTSHfc6agMRPM13wSZAXdq
 f8e5mDWfkKN1X2f64lm0+nXT6N35wTIsnYay2bqS1N50N9ZpzpfPNMYsRDu8wwsalNDLCi+Bi
 FzgI+l0aIoR9W6f9M2xpXDHEpcItcRGj6R2wHBiaMh8CeGP3YU/R/15x8KajsWsJc/PKvw05g
 oDdfqfdnpYw6Do7YY+CCPA7SnJo0VRLv5yFBnoBuKfXr6ucSC5D/xUvkWQ7hzHl0IwmVCMDz2
 mAztQ26lhKEOA44gUy7qULLCuAbdxroe2MdY7ncYqm+9eOrPwTRmrJkRzFCuM7+sA2iRKycQi
 uKLPRECKaLoeGxy+w0UJ4p/UkvIPdxYdoY7fo3sV+I4RBk3VjJRjqLNDvq/l8d5ymhMyyoXE9
 CEXp5t9SFZTHpuD1bkeZ1Vn8DZRm5t3Y2h9DgA00S3zo1RBRDa0rHRSMTlMM49VN+Pji5cLez
 KHkEmyc
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 20:43:41 +0100

Return directly after a call of the function "copy_from_user" failed
in a case block.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kvm/mips.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 06a60b19acfb..1dad78f74e8c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1152,10 +1152,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 		{
 			struct kvm_mips_interrupt irq;
 
-			r = -EFAULT;
 			if (copy_from_user(&irq, argp, sizeof(irq)))
-				goto out;
-
+				return -EFAULT;
 			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
 				  irq.irq);
 
@@ -1165,9 +1163,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 	case KVM_ENABLE_CAP: {
 		struct kvm_enable_cap cap;
 
-		r = -EFAULT;
 		if (copy_from_user(&cap, argp, sizeof(cap)))
-			goto out;
+			return -EFAULT;
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
 		break;
 	}
-- 
2.11.0
